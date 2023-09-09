import 'package:exam_list/responseModels/home/exam_data.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/responseModels/home/exam_list_response.dart'
    as exam_list_response;
import 'package:exam_list/network/http_requests.dart';
import 'package:exam_list/responseModels/request_data.dart';

class ExamProvider with ChangeNotifier {

  final List<ExamData> _allExams = [];
  final Map<num, List<ExamData>> _differentTypesExams = {};
  final List<ExamData> _currentList = [];
  RequestData examRequest = RequestData();

  late ExamData? _selectedExam;
  // adNumber for opened exam
  String _openedExam = "";
  RequestData examRequestData = RequestData();

  void setIndex(int index, {bool notify = true}) {
    _currentList.clear();
    if (index == 0) {
      _currentList.addAll(_allExams);
    } else {
      _currentList.addAll(_differentTypesExams[index] ?? []);
    }
    if (notify) notifyTheProvider();
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
    notifyTheProvider();
  }

  void notifyTheProvider() {
    WidgetsBinding.instance.addPostFrameCallback((status) {
      notifyListeners();
    });
  }

  Future<RequestData> fetchExams(int selectedIndex) async {
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
        response.data
            ?.where((element) =>
                element.parent == null || element.parent == true)
            .forEach((exam) {
          // filter child exams
          var listOfChild = response.data?.where((element) =>
              element.parent == false && element.adNumber == exam.adNumber);
          if (listOfChild != null && listOfChild.isNotEmpty) {
            exam.setChildExams(listOfChild.toList());
          }
          _allExams.add(exam);
        });
        printDebug(response.data?.length.toString()??'');
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
        setIndex(selectedIndex, notify: false);
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
}
