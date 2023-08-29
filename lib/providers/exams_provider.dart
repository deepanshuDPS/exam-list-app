import 'package:exam_list/responseModels/home/exam_data.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/network/http_requests.dart';
import 'package:exam_list/responseModels/request_data.dart';
import 'package:exam_list/responseModels/home/exam_list_response.dart';

class ExamsProvider with ChangeNotifier {

  late ExamData? _exam;
  // adNumber for opened exam
  String _openedExam = "";
  RequestData resortsListingRequestData = RequestData();
  RequestData examRequestData = RequestData();

  void notifyWithRequest(RequestData data, bool isLoading) {
    data.isLoading = isLoading;
    if (isLoading) {
      data.data = null;
      data.isError = false;
    }
    WidgetsBinding.instance.addPostFrameCallback((status) {
      notifyListeners();
    });
  }

  ExamData? get exam {
    return _exam;
  }

  void setExam(ExamData exam) {
    _exam = exam;
  }

  Future<void> getResort(String adNumber) async {
    if (_openedExam == adNumber) {
      return;
    } else {
      _exam = null;
      notifyWithRequest(examRequestData, true);
    }
    final resortResponse = ExamListResponse.fromJson(
        await HttpRequests.instance()?.httpGetRequest(adNumber));

    if (resortResponse.status == true) {
      _exam = resortResponse.data?.first;
      _openedExam = adNumber;
    } else {
      examRequestData.setErrorData(resortResponse.toJson());
    }
    notifyWithRequest(examRequestData, false);
  }
}
