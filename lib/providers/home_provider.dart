import 'package:exam_list/responseModels/home/exam_data.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/responseModels/global_response.dart';
import 'package:exam_list/responseModels/home/check_voucher_response.dart'
    as voucher;
import 'package:exam_list/responseModels/home/exam_list_response.dart'
    as exam_list_response;
import 'package:exam_list/network/http_requests.dart';
import 'package:exam_list/responseModels/request_data.dart';

class HomeProvider with ChangeNotifier {
  final List<ExamData> _allExams = [];
  final Map<num, List<ExamData>> _differentTypesExams = {};
  final List<ExamData> _currentList = [];
  RequestData homeRequest = RequestData();
  RequestData testimonialsRequest = RequestData();

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
    notifyWithRequest(homeRequest, true);
    final response = exam_list_response.ExamListResponse.fromJson(
        await HttpRequests.instance()?.httpGetRequest(ApiEndPoints.getExams));
    if (response.status == false) {
      homeRequest.setErrorData(response.toJson());
    } else {
      if (response.data != null && response.data?.isNotEmpty == true) {
        _allExams.addAll(response.data!);
        // different types -> list
        response.data?.forEach((exam) {
          exam.categoryTypes?.forEach((type) {
            if (_differentTypesExams[type] == null) {
              _differentTypesExams[type] = [exam];
            } else {
              var examList = _differentTypesExams[type];
              examList?.add(exam);
            }
          });
        });
        setIndex(selectedIndex, notify: false);
      }
    }
    notifyWithRequest(homeRequest, false);
    return homeRequest;
  }

  Future<dynamic> checkVoucher(String vNum) async {
    final response = voucher.CheckVoucherResponse.fromJson(
        await HttpRequests.instance()?.httpGetRequest(
            ApiEndPoints.checkVoucher.replaceAll("{voucher_num}", vNum)));
    // printDebug(response.toString());
    if (response.data?.isNotEmpty == true) {
      return response.data![0];
    } else {
      return response.message ?? 'Something went wrong';
    }
  }

  Future<dynamic> forgotPassword(String memNum) async {
    final response = GlobalResponse.fromJson(await HttpRequests.instance()
        ?.httpPutRequest(ApiEndPoints.forgotPassword, {'mem_num': memNum}));
    // printDebug(response.toString());
    if (response.status != -1) {
      return response.message;
    } else {
      return {'errorMessage': response.message ?? 'Something went wrong'};
    }
  }

  Future<dynamic> getOffers(Map<String, String> requestBody) async {
    final response = GlobalResponse.fromJson(await HttpRequests.instance()
        ?.httpPostRequest(ApiEndPoints.enquiry, requestBody));
    if (response.status != -1) {
      return response.message;
    } else {
      return {'errorMessage': response.message ?? 'Something went wrong'};
    }
  }
}
