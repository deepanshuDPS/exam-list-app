import 'dart:convert';

import 'package:exam_list/network/http_requests.dart';
import 'package:exam_list/responseModels/exam/exam_data.dart';
import 'package:exam_list/responseModels/request_data.dart';
import 'package:exam_list/responseModels/user/aspirant_data.dart';
import 'package:exam_list/utils/constants.dart';
import 'package:exam_list/utils/exam_utils.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/utils/preferences_data.dart';
import 'package:get/get.dart';
import 'package:exam_list/responseModels/user/notify_me_response.dart';
import 'package:exam_list/responseModels/exam/exam_list_response.dart'
    as exam_list_response;
import 'package:hive/hive.dart';
import 'package:exam_list/responseModels/user/aspirant_profile_response.dart'
    as aspirant_profile_response;
import 'package:exam_list/responseModels/exam/exam_pattern_list_response.dart'
    as exam_pattern_list_response;

class AspirantExamController extends GetxController {
  var currentFilterIndex = 0.obs;
  var isNotifying = false.obs;
  late AspirantData updatedAspirantData;

  final List<ExamData> _allExams = [];
  final Map<num, List<ExamData>> _differentTypesExams = {};
  final Map<String, int> subscriptionStatus = {};

  final _currentList = List<ExamData>.empty(growable: true).obs;
  final _examCategories = List<int>.empty(growable: true).obs;

  final examRequest = RequestData().obs;

  get currentList => _currentList;

  get examCategories => _examCategories;

  @override
  void onInit() {
    super.onInit();
    _examCategories.value = Constants.examCategories.keys.toList();
    currentFilterIndex.value = 0;
  }

  void filterList({int? index, bool notify = true, String? query}) {
    if (index != null) {
      currentFilterIndex.value = index;
    }
    _currentList.clear();
    if (query != null && query.length > 1) {
      _currentList.addAll(_allExams.where((exam) {
        return isQueryExist(exam.examName, query) ||
            isQueryExist(exam.adNumber, query);
      }));
    } else if (currentFilterIndex.value == 0) {
      _currentList.addAll(_allExams);
    } else {
      _currentList.addAll(_differentTypesExams[currentFilterIndex.value] ?? []);
    }
    if (notify) {
      _examCategories.refresh();
    }
  }

  Future<RequestData> fetchExams(
      int selectedIndex, List<String> userSubscriptions) async {
    _allExams.clear();
    _differentTypesExams.clear();
    _currentList.clear();
    currentFilterIndex.value = selectedIndex;
    subscriptionStatus.clear();
    notifyWithRequest(examRequest, true);
    final response = exam_list_response.ExamListResponse.fromJson(
        await HttpRequests.instance()?.httpGetRequest(ApiEndPoints.getExams));
    if (response.status == false) {
      notifyWithRequest(examRequest, true, response.toJson());
      return examRequest.value;
    } else {
      if (response.data != null && response.data?.isNotEmpty == true) {
        // traverse parent exams
        await checkSubscriptionsStatus(userSubscriptions, subscriptionStatus);
        printDebug(response.data
                ?.where((element) =>
                    element.parent == null || element.parent == true)
                .map((e) => e.parent)
                .toList()
                .toString() ??
            "");
        response.data
            ?.where(
                (element) => element.parent == null || element.parent == true)
            .forEach((exam) {
          // filter child exams
          var listOfChild = response.data?.where((element) =>
              element.parent == false && element.adNumber == exam.adNumber);
          if (listOfChild != null && listOfChild.isNotEmpty) {
            exam.setChildExams(listOfChild.toList());
          }
          exam.setNotifyStatus(subscriptionStatus[exam.slug] ?? 0);
          _allExams.add(exam);
        });
        printDebug(response.data?.length.toString() ?? '');
        // different types -> list
        for (var exam in _allExams) {
          exam.categoryTypes?.forEach((type) {
            if (_differentTypesExams[type] == null) {
              _differentTypesExams[type] = [exam];
            } else {
              var examList = _differentTypesExams[type];
              examList?.add(exam);
            }
          });
        }
        filterList(notify: false);
      }
    }
    notifyWithRequest(examRequest, false);
    return examRequest.value;
  }

  void refreshExams(String slug) async {
    var subscriptions = await PreferencesData.getSubscriptions();
    for (var exam in _allExams) {
      exam.setNotifyStatus(subscriptions.contains(exam.slug) ? 2 : 0);
    }
    _currentList.refresh();
  }

  Future<dynamic> notifyMe(String slug) async {
    isNotifying.value = true;
    final response = NotifyMeResponse.fromJson(await HttpRequests.instance()
        ?.httpPatchRequest(ApiEndPoints.notifyMe, {'slug': slug}));
    if (response.status == true) {
      await checkSubscriptionsStatus(response.data, subscriptionStatus);
      updateHiveForUser(response.data ?? []);
      isNotifying.value = false;
      refreshExams(slug);
      return true;
    }
    isNotifying.value = false;
    return response.message;
  }

  Future<dynamic> removeNotifyMe(String slug) async {
    isNotifying.value = true;
    final response = NotifyMeResponse.fromJson(await HttpRequests.instance()
        ?.httpDeleteRequest(ApiEndPoints.notifyMe, {'slug': slug}));
    if (response.status == true) {
      await checkSubscriptionsStatus(response.data, subscriptionStatus);
      updateHiveForUser(response.data ?? []);
      isNotifying.value = false;
      refreshExams(slug);
      return true;
    }
    isNotifying.value = false;
    return response.message;
  }

  Future<dynamic> updateHiveForUser(List<String> subsList) async {
    try {
      var cachePoint =
          ApiEndPoints.getAspirant.split("?").first.replaceAll("/", "_");
      var box = await Hive.openBox<dynamic>(cachePoint);
      if (box.length != 4) {
        return null;
      }
      var response = jsonDecode(box.get("response"));
      var responseObj =
          aspirant_profile_response.AspirantProfileResponse.fromJson(response);
      responseObj.data?.setSubscribedChannels(subsList);
      printDebug(jsonEncode(responseObj.toJson()));
      box.put("response", jsonEncode(responseObj.toJson()));
      updatedAspirantData = responseObj.data!;
      return true;
    } catch (e) {
      printDebug(e.toString());
      return null;
    }
  }

  // selected exam handling

  late ExamData? _selectedExam;

  ExamData? get selectedExam => _selectedExam;
  final List<String> _htmlContents = [];
  final List<String> _extraHtmlContents = [];
  final Map<String, String> examToExamPattern = {};
  final Rx<RequestData> examRequestData = RequestData().obs;

  void setExam(ExamData exam) {
    _selectedExam = exam;
    getExamPatternsById();
  }

  Future<void> getExamPatternsById() async {
    _htmlContents.clear();
    _extraHtmlContents.clear();
    examToExamPattern.clear();
    notifyWithRequest(examRequestData, true);
    var idsList = fetchAllExamIds(_selectedExam!);
    String examIds;
    if (idsList.length == 1) {
      examIds = idsList[0];
    } else {
      examIds = idsList.join("-");
    }
    final response = exam_pattern_list_response.ExamPatternListResponse
        .fromJson(await HttpRequests.instance()?.httpGetRequest(
            ApiEndPoints.getExamPatterByID.replaceAll('{examIds}', examIds)));
    if (response.status == true) {
      response.data?.forEach((examPattern) {
        examToExamPattern[examPattern.examId ?? "N/A"] =
            examPattern.id ?? "N/A";
        if (examPattern.htmlContent != null) {
          _htmlContents.add(examPattern.htmlContent!);
        }
        if (examPattern.extraHtmlContent != null) {
          _extraHtmlContents.add(examPattern.extraHtmlContent!);
        }
      });
    }
    notifyWithRequest(examRequestData, false);
  }

  ExamData? getAdNumberExam(String adNumber) {
    return _allExams.firstWhere((element) => element.adNumber == adNumber);
  }
}
