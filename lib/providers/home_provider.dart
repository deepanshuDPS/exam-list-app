import 'package:flutter/material.dart';
import 'package:exam_list/responseModels/global_response.dart';
import 'package:exam_list/responseModels/home/check_voucher_response.dart'
    as voucher;
import 'package:exam_list/responseModels/home/exam_list_response.dart'
    as exam_list_response;
import 'package:exam_list/network/http_requests.dart';
import 'package:exam_list/responseModels/home/testimonials_response.dart'
    as testimonials;
import 'package:exam_list/responseModels/request_data.dart';

class HomeProvider with ChangeNotifier {
  final List<exam_list_response.Data> _allExams = [];
  final Map<int, List<exam_list_response.Data>> _differentTypesExams = {};
  final List<exam_list_response.Data> _currentList = [];
  final List<testimonials.Data> _testimonials = [];
  RequestData homeRequest = RequestData();
  RequestData testimonialsRequest = RequestData();

  List<exam_list_response.Data> get currentList {
    return [..._currentList];
  }

  List<testimonials.Data> get getTestimonials {
    return [..._testimonials];
  }

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

  Future<RequestData> fetchExams() async {
    _allExams.clear();
    _currentList.clear();
    _differentTypesExams.clear();
    notifyWithRequest(homeRequest, true);
    final response = exam_list_response.ExamListResponse.fromJson(
        await HttpRequests.instance()?.httpGetRequest(ApiEndPoints.getExams));
    if (response.status == false) {
      homeRequest.setErrorData(response.toJson());
    } else {
      _allExams.addAll(response.data!);
      _currentList.addAll(response.data!);
    }
    notifyWithRequest(homeRequest, false);
    return homeRequest;
  }

  Future<RequestData> fetchTestimonials() async {
    _testimonials.clear();
    notifyWithRequest(testimonialsRequest, true);
    final response = testimonials.TestimonialsResponse.fromJson(
        await HttpRequests.instance()
            ?.httpGetRequest(ApiEndPoints.testimonials));
    if (response.status == -1) {
      testimonialsRequest.setErrorData(response.toJson());
    } else {
      _testimonials.addAll(response.data!);
    }
    notifyWithRequest(testimonialsRequest, false);
    return testimonialsRequest;
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
