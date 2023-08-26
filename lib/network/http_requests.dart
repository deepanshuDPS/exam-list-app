import 'dart:convert';
import 'dart:io';

import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/utils/hive_cache_handling.dart';
import 'package:exam_list/utils/preferences_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:exam_list/network/http_utils.dart';
import 'package:exam_list/utils/constants.dart';

class HttpRequests {
  static HttpRequests? _httpRequests;
  final dynamic _emptyError = {'message': '', 'status': -1};

  HttpRequests._();

  static HttpRequests? instance() {
    _httpRequests ??= HttpRequests._();
    return _httpRequests;
  }

  Future<Map<String, String>> getHeaders(bool isAuthHeader) async {
    Map<String, String> headersToSend = {
      'Content-Type': 'application/json',
      'x-api-key': Constants.apiKey
    };
    var authUser = FirebaseAuth.instance.currentUser;
    if (authUser != null) {
      headersToSend['id-token'] = (await authUser.getIdToken()) ?? "";
      headersToSend['mobile'] = authUser.phoneNumber ?? "";
      headersToSend['user-id'] =
          (await PreferencesData.getUserData())?.id ?? "";
    }
    if (!await PreferencesData.isFCMSent()) {
      headersToSend['fcm-token'] = await PreferencesData.getFCMToken();
    }
    return headersToSend;
  }

  Future<dynamic> httpPostRequest(String endPoint, Map<String, dynamic> request,
      {bool includeAuthHeader = true}) async {
    try {
      var url = "${Constants.baseURL}$endPoint";
      var headersToSend = await getHeaders(includeAuthHeader);

      final response = await http.post(Uri.parse(url),
          headers: headersToSend, body: jsonEncode(request));

      if (response.statusCode < 300) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        return getErrorResponse(
            response.statusCode, jsonDecode(utf8.decode(response.bodyBytes)));
      }
    } catch (error) {
      if (error is SocketException) {
        return getErrorResponse(1, _emptyError);
      }
      return getErrorResponse(0, _emptyError);
    }
  }

  Future<dynamic> httpPutRequest(String endPoint, Map<String, dynamic> request,
      {bool includeAuthHeader = true}) async {
    try {
      var url = "${Constants.baseURL}$endPoint";
      var headersToSend = await getHeaders(includeAuthHeader);

      final response = await http.put(Uri.parse(url),
          headers: headersToSend, body: jsonEncode(request));

      if (response.statusCode < 300) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        return getErrorResponse(
            response.statusCode, jsonDecode(utf8.decode(response.bodyBytes)));
      }
    } catch (error) {
      if (error is SocketException) {
        return getErrorResponse(1, _emptyError);
      }
      return getErrorResponse(0, _emptyError);
    }
  }

  Future<dynamic> httpGetQueryRequest(String endPoint,
      {bool includeAuthHeader = true, Map<String, String>? queryParams}) async {
    try {
      var headersToSend = await getHeaders(includeAuthHeader);
      var cachedResponse =
      await getAuthCachedResponse(endPoint, headersToSend);
      if (cachedResponse != null) {
        return cachedResponse;
      }
      var uri = Uri.http(Constants.baseURL, endPoint, queryParams);
      final response = await http.get(uri, headers: headersToSend);
      if (response.statusCode < 300) {
        var responseAsString = utf8.decode(response.bodyBytes);
        await saveAuthCachedResponse(endPoint, headersToSend, response);
        printDebug(responseAsString);
        return jsonDecode(responseAsString);
      } else {
        return getErrorResponse(
            response.statusCode, jsonDecode(utf8.decode(response.bodyBytes)));
      }
    } catch (error) {
      if (error is SocketException) {
        return getErrorResponse(1, _emptyError);
      }
      return getErrorResponse(0, _emptyError);
    }
  }

  Future<dynamic> httpGetRequest(String endPoint,
      {bool includeAuthHeader = true}) async {
    try {
      var url = "${Constants.baseURL}$endPoint";
      var headersToSend = await getHeaders(includeAuthHeader);
      var cachedResponse =
          await getAuthCachedResponse(endPoint, headersToSend);
      if (cachedResponse != null) {
        printDebug("here cached");
        return cachedResponse;
      }
      final response = await http.get(Uri.parse(url), headers: headersToSend);
      if (response.statusCode < 300) {
        var responseAsString = utf8.decode(response.bodyBytes);
        await saveAuthCachedResponse(endPoint, headersToSend, response);
        printDebug(responseAsString);
        return jsonDecode(responseAsString);
      } else {
        if (response.statusCode == 404) {
          return getErrorResponse(response.statusCode, _emptyError);
        }
        return getErrorResponse(
            response.statusCode, jsonDecode(utf8.decode(response.bodyBytes)));
      }
    } catch (error) {
      printDebug("here error: "+error.runtimeType.toString());
      if (error is SocketException) {
        return getErrorResponse(1, _emptyError);
      }
      return getErrorResponse(0, _emptyError);
    }
  }
}

class ApiEndPoints {
  static const authUser = 'auth/user';
  static const authExam = 'auth/exam';

  static const checkUser = "$authUser/checkUser";
  static const signUpAspirant = "$authUser/signup";
  static const getAspirant = "$authUser/aspirant";
  static const checkGuestUser = "anon/user/checkGuestUser";

  static const getExams = '$authExam/';

  /////////////////////////////////////////////////////////////////////////////
  static const home = 'home';
  static const domesticPlaces = 'destination?category=domestic';
  static const internationalPlaces = 'destination?category=international';
  static const exchangePlaces = 'destination?category=exchange';
  static const destinationResorts = 'destination/{id}/resort';
  static const getResort = 'destination/{dId}/resort/{rId}';
  static const checkVoucher = 'voucher/{voucher_num}';
  static const enquiry = 'enquiry';
  static const testimonials = 'feedback';
  static const searchPlaces = 'search?q=';
  static const forgotPassword = 'forget_password';

  // member login end points
  static const login = 'login';
  static const memberOffers = 'member/offers';
  static const memberProfile = 'member/profile';
  static const memberHolidays = 'member/holidays';
  static const memberDocuments = 'member/documents';
  static const memberFee = 'member/fee';
  static const memberAMC = 'member/amc';
  static const memberTrips = 'member/mytrips/{trip_type}';
  static const memberChangePassword = 'member/change_password';
  static const memberBook = 'member/book/{type}';
}
