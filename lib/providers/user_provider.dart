import 'package:exam_list/responseModels/user/aspirant_data.dart';
import 'package:exam_list/responseModels/user/terms_policy_response.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/network/http_requests.dart';
import 'package:exam_list/responseModels/global_response.dart';
import 'package:exam_list/responseModels/user/aspirant_profile_response.dart'
    as aspirant_profile_response;
import 'package:exam_list/responseModels/request_data.dart';
import 'package:exam_list/responseModels/search/all_places_response.dart'
    as all_places_response;
import 'package:exam_list/utils/preferences_data.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:exam_list/responseModels/user/check_user_response.dart'
    as check_user_response;

class UserProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  final List<all_places_response.Data> _domesticList = [];
  final List<all_places_response.Data> _internationalList = [];

  AspirantData? _aspirantDetailsData;
  check_user_response.Data? _userDetailsData;

  RequestData aspirantRequestData = RequestData();
  RequestData myUpTripsRequestData = RequestData();
  RequestData myCompTripsRequestData = RequestData();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// 0-> Login Screen
  /// 1-> Not onBoarded
  /// 2-> Home Screen
  Future<int> initializeApp() async {
    // await Firebase.initializeApp();
    // // set crashlytics
    // Function originalOnError = FlutterError.onError;
    // FlutterError.onError = (FlutterErrorDetails errorDetails) async {
    //   await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    //   // Forward to original handler.
    //   originalOnError(errorDetails);
    // };
    // // google ads
    // await FirebaseAdMob.instance.initialize(appId: AdManager.appId);
    //
    // // set remote config
    // final RemoteConfig remoteConfig = await RemoteConfig.instance;
    // final defaults = <String, dynamic>{'base_url': ''};
    // await remoteConfig.setDefaults(defaults);
    // await remoteConfig.fetch(expiration: const Duration(hours: 6));
    // await remoteConfig.activateFetched();
    // String baseUrl = remoteConfig.getString('base_url');
    // // set descriptions for applications
    // await checkUserDetails();
    // await Future.delayed(Duration(milliseconds: 100));
    Hive.init((await getApplicationDocumentsDirectory()).path);
    if (_auth.currentUser != null) {
      _userDetailsData = await PreferencesData.getUserData();
      _isLoggedIn = (_userDetailsData) != null;
      if (!_isLoggedIn) {
        await _auth.signOut();
        return 0;
      } else if (_userDetailsData?.onBoarded == true) {
        return 2;
      }
      return 1;
    }
    return 0;
  }

  void verifyMobileNumber(
      String mobileNumber,
      Function isVerificationCompleted,
      PhoneCodeSent codeSent,
      PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout) async {
    await _auth.signOut();
    await _auth.verifyPhoneNumber(
      phoneNumber: mobileNumber,
      verificationCompleted: (credential) {
        isVerificationCompleted("Mobile no. verified", credential);
      },
      verificationFailed: (authException) {
        // error in verification of phone no.
        isVerificationCompleted(authException);
      },
      codeSent: codeSent,
      codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
    );
  }

  Future<dynamic> loginGuest(String mobile) async {
    final customResponse = check_user_response.CheckUserResponse.fromJson(
        await HttpRequests.instance()?.httpPostRequest(
            ApiEndPoints.checkGuestUser, {'mobile': '+91$mobile'}));
    if (customResponse.status == false) {
      _notifyListenersWithBinding();
      return customResponse.message ?? 'Something went Wrong';
    }
    printDebug(customResponse.data?.customToken ?? '');
    await _auth.signInWithCustomToken(customResponse.data?.customToken ?? '');
    final response = check_user_response.CheckUserResponse.fromJson(
        await HttpRequests.instance()?.httpGetRequest(ApiEndPoints.checkUser));
    if (response.status == true) {
      PreferencesData.saveUserData(response.data!);
      _userDetailsData = response.data!;
      _isLoggedIn = true;
      _notifyListenersWithBinding();
      return response.data?.onBoarded == true;
    }
    await _auth.signOut();
    _notifyListenersWithBinding();
    return response.message ?? 'Something went Wrong';
  }

  Future<dynamic> loginMobile(PhoneAuthCredential phoneAuthCredential) async {
    await _auth.signInWithCredential(phoneAuthCredential);
    final response = check_user_response.CheckUserResponse.fromJson(
        await HttpRequests.instance()?.httpGetRequest(ApiEndPoints.checkUser));
    if (response.status == true) {
      PreferencesData.saveUserData(response.data!);
      _userDetailsData = response.data!;
      _isLoggedIn = true;
      _notifyListenersWithBinding();
      return response.data?.onBoarded == true;
    }
    await _auth.signOut();
    _notifyListenersWithBinding();
    return response.message ?? 'Something went Wrong';
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

  List<all_places_response.Data> get allPlacesList {
    return [..._domesticList, ..._internationalList];
  }

  bool isPlacesListNotEmpty() =>
      _domesticList.isNotEmpty || _internationalList.isNotEmpty;

  Future<bool> getAllPlaces() async {
    if (_domesticList.isEmpty && _internationalList.isEmpty) {
      final domesticRes = all_places_response.AllPlacesResponse.fromJson(
          await HttpRequests.instance()
              ?.httpGetRequest(ApiEndPoints.domesticPlaces));
      final internationalRes = all_places_response.AllPlacesResponse.fromJson(
          await HttpRequests.instance()
              ?.httpGetRequest(ApiEndPoints.internationalPlaces));
      if (domesticRes.data?.isNotEmpty == true) {
        _domesticList.addAll(domesticRes.data!);
      }
      if (internationalRes.data?.isNotEmpty == true) {
        _internationalList.addAll(internationalRes.data!);
      }
      return isPlacesListNotEmpty();
    }
    return true;
  }

  bool get isLogin {
    return _isLoggedIn;
  }

  AspirantData? get aspirantDetails {
    return _aspirantDetailsData;
  }

  check_user_response.Data? get userDetails {
    return _userDetailsData;
  }

  Future<void> logoutUser() async {
    await PreferencesData.clearOnLogOut();
    _isLoggedIn = false;
    _notifyListenersWithBinding();
  }

  Future<dynamic> getAspirantUser() async {
    _aspirantDetailsData = null;
    notifyWithRequest(aspirantRequestData, true);
    final response = aspirant_profile_response.AspirantProfileResponse.fromJson(
        await HttpRequests.instance()
            ?.httpGetRequest(ApiEndPoints.getAspirant));
    if (response.data != null) {
      _aspirantDetailsData = response.data;
    } else {
      aspirantRequestData.setErrorData(response.toJson());
    }
    notifyWithRequest(aspirantRequestData, false);
  }

  Future<dynamic> changePassword(String oldPass, String newPass) async {
    var body = {'old_pwd': oldPass, 'new_pwd': newPass, 'cnew_pwd': newPass};
    final response = GlobalResponse.fromJson(await HttpRequests.instance()
        ?.httpPutRequest(ApiEndPoints.memberChangePassword, body));
    if (response.status == -1) {
      return {'errorMessage': response.message ?? 'Something Went Wrong'};
    }
    return response.message;
  }

  Future<dynamic> bookingOfferOrHoliday(
      Map<String, String?> bodyData, bool isOffer) async {
    final response = GlobalResponse.fromJson(await HttpRequests.instance()
        ?.httpPostRequest(
            ApiEndPoints.memberBook
                .replaceAll('{type}', isOffer ? 'offer' : 'holiday'),
            bodyData));
    if (response.status == -1) {
      return {'errorMessage': response.message ?? 'Something Went Wrong'};
    }
    return response.message;
  }

  Future<dynamic> signUpAspirant(Map<String, dynamic> body) async {
    final response = check_user_response.CheckUserResponse.fromJson(
        await HttpRequests.instance()
            ?.httpPostRequest(ApiEndPoints.signUpAspirant, body));
    if (response.status == true) {
      PreferencesData.saveUserData(response.data!);
      _userDetailsData = response.data!;
      _isLoggedIn = true;
      _notifyListenersWithBinding();
      return response.data?.onBoarded == true;
    }
    _notifyListenersWithBinding();
    return response.message ?? 'Something went Wrong';
  }

  Future<dynamic> editAspirantProfile(Map<String, dynamic> body) async {
    final response = check_user_response.CheckUserResponse.fromJson(
        await HttpRequests.instance()
            ?.httpPutRequest(ApiEndPoints.editAspirantProfile, body));
    if (response.status == true) {
      _notifyListenersWithBinding();
      return true;
    }
    _notifyListenersWithBinding();
    return response.message ?? 'Something went Wrong';
  }

  Future<dynamic> getTermsPolicy() async {
    final response = TermsPolicyResponse.fromJson(await HttpRequests.instance()
        ?.httpGetRequest(ApiEndPoints.infoTermsPolicy));
    if (response.status == true) {
      return response.data;
    }
    return response.message ?? 'Something went Wrong';
  }

  void getNotifications() {}
}
