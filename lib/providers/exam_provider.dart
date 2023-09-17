import 'dart:convert';

import 'package:exam_list/responseModels/home/exam_data.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/utils/preferences_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/responseModels/home/exam_list_response.dart'
    as exam_list_response;
import 'package:exam_list/network/http_requests.dart';
import 'package:exam_list/responseModels/request_data.dart';
import 'package:exam_list/responseModels/user/notify_me_response.dart';
import 'package:hive/hive.dart';
import 'package:exam_list/responseModels/user/aspirant_profile_response.dart'
    as aspirant_profile_response;

class ExamProvider with ChangeNotifier {
  final List<ExamData> _allExams = [];
  final Map<num, List<ExamData>> _differentTypesExams = {};
  final List<ExamData> _currentList = [];
  RequestData examRequest = RequestData();
  final Map<String, int> subscriptionStatus = {};

  late ExamData? _selectedExam;
  var isNotifying = false;

  // adNumber for opened exam
  String _openedExam = "";
  RequestData examRequestData = RequestData();

  void filterList(int index, {bool notify = true, String? query}) {
    _currentList.clear();
    if (query != null && query.length > 1) {
      _currentList.addAll(_allExams.where((exam) {
        return isQueryExist(exam.examName, query) ||
            isQueryExist(exam.adNumber, query);
      }));
    } else if (index == 0) {
      _currentList.addAll(_allExams);
    } else {
      _currentList.addAll(_differentTypesExams[index] ?? []);
    }
    if (notify) _notifyListenersWithBinding();
  }

  List<ExamData> get currentList {
    return [..._currentList];
  }

  void notifyWithRequest(RequestData data, bool isLoading) {
    data.isLoading = isLoading;
    if (isLoading) {
      data.data = null;
      data.isError = false;
    }
    _notifyListenersWithBinding();
  }

  void _notifyListenersWithBinding() {
    if (kDebugMode) {
      notifyListeners();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((status) {
        notifyListeners();
      });
    }
  }

  Future<RequestData> fetchExams(
      int selectedIndex, List<String> userSubscriptions) async {
    _allExams.clear();
    _differentTypesExams.clear();
    _currentList.clear();
    notifyWithRequest(examRequest, true);
    final response = exam_list_response.ExamListResponse.fromJson(
        await HttpRequests.instance()?.httpGetRequest(ApiEndPoints.getExams));
    if (response.status == false) {
      examRequest.setErrorData(response.toJson());
    } else {
      if (response.data != null && response.data?.isNotEmpty == true) {
        // traverse parent exams
        await checkSubscriptionsStatus(userSubscriptions, subscriptionStatus);
        printDebug(response.data?.where((element) => element.parent == null || element.parent == true).map((e) => e.parent).toList().toString()??"");
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
        filterList(selectedIndex, notify: false);
      }
    }
    notifyWithRequest(examRequest, false);
    return examRequest;
  }

  ExamData? get exam {
    return _selectedExam;
  }

  void setExam(ExamData exam) {
    _selectedExam = exam;
  }

  Future<void> getExams(String adNumber) async {
    if (_openedExam == adNumber) {
      return;
    } else {
      _selectedExam = null;
      notifyWithRequest(examRequestData, true);
    }
    final resortResponse = exam_list_response.ExamListResponse.fromJson(
        await HttpRequests.instance()?.httpGetRequest(adNumber));

    if (resortResponse.status == true) {
      _selectedExam = resortResponse.data?.first;
      _openedExam = adNumber;
    } else {
      examRequestData.setErrorData(resortResponse.toJson());
    }
    notifyWithRequest(examRequestData, false);
  }

  void refreshExams(String slug) async {
    var subscriptions = await PreferencesData.getSubscriptions();
    for (var exam in _allExams) {
      exam.setNotifyStatus(subscriptions.contains(exam.slug) ? 2 : 0);
    }
    _notifyListenersWithBinding();
  }

  Future<dynamic> notifyMe(String slug) async {
    isNotifying = true;
    _notifyListenersWithBinding();
    final response = NotifyMeResponse.fromJson(await HttpRequests.instance()
        ?.httpPatchRequest(ApiEndPoints.notifyMe, {'slug': slug}));
    if (response.status == true) {
      await checkSubscriptionsStatus(response.data, subscriptionStatus);
      updateHiveForUser(response.data ?? []);
      isNotifying = false;
      _notifyListenersWithBinding();
      return true;
    }
    _notifyListenersWithBinding();
    isNotifying = false;
    return response.message;
  }

  Future<dynamic> removeNotifyMe(String slug) async {
    isNotifying = true;
    _notifyListenersWithBinding();
    final response = NotifyMeResponse.fromJson(await HttpRequests.instance()
        ?.httpDeleteRequest(ApiEndPoints.notifyMe, {'slug': slug}));
    if (response.status == true) {
      await checkSubscriptionsStatus(response.data, subscriptionStatus);
      updateHiveForUser(response.data ?? []);
      isNotifying = false;
      _notifyListenersWithBinding();
      return true;
    }
    _notifyListenersWithBinding();
    isNotifying = false;
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
      box.put("response", responseObj.toJson());
      return true;
    } catch (e) {
      return null;
    }
  }
}
