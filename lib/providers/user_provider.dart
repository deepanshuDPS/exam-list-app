import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/network/http_requests.dart';
import 'package:exam_list/responseModels/global_response.dart';
import 'package:exam_list/responseModels/login/holidays_response.dart'
    as holiday_response;
import 'package:exam_list/responseModels/login/offers_response.dart'
    as offers_response;
import 'package:exam_list/responseModels/login/documents_response.dart'
    as docs_response;
import 'package:exam_list/responseModels/login/member_fee_payments.dart'
    as fee_response;
import 'package:exam_list/responseModels/login/member_profile_response.dart'
    as member_details_response;
import 'package:exam_list/responseModels/login/my_trips_response.dart'
    as trips_response;
import 'package:exam_list/responseModels/request_data.dart';
import 'package:exam_list/responseModels/search/all_places_response.dart'
    as all_places_response;
import 'package:exam_list/utils/preferences_data.dart';

import '../responseModels/login/check_user_response.dart'
    as check_user_response;

class UserProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  final List<holiday_response.Data> _holidaysList = [];
  final List<offers_response.Data> _offersList = [];
  final List<docs_response.Data> _docsList = [];
  final List<fee_response.Data> _feesList = [];
  final List<trips_response.Data> _upTripsList = [];
  final List<trips_response.Data> _comTripsList = [];
  final List<all_places_response.Data> _domesticList = [];
  final List<all_places_response.Data> _internationalList = [];
  member_details_response.Data? _memberDetailsData;
  check_user_response.Data? _userDetailsData;

  RequestData memberRequestData = RequestData();
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
    WidgetsBinding.instance.addPostFrameCallback((status) {
      notifyListeners();
    });
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

  member_details_response.Data? get memberDetails {
    return _memberDetailsData;
  }

  check_user_response.Data? get userDetails {
    return _userDetailsData;
  }

  List<fee_response.Data> get feeList {
    return _feesList;
  }

  List<holiday_response.Data> get holidaysList {
    return [..._holidaysList];
  }

  List<offers_response.Data> get offersList {
    return [..._offersList];
  }

  List<docs_response.Data> get docsList {
    return [..._docsList];
  }

  List<trips_response.Data> get upTripsList {
    return [..._upTripsList];
  }

  List<trips_response.Data> get comTripsList {
    return [..._comTripsList];
  }

  Future<void> logoutUser() async {
    await PreferencesData.clearOnLogOut();
    _isLoggedIn = false;
    _notifyListenersWithBinding();
  }

  Future<dynamic> checkUser() async {}

  Future<dynamic> changePassword(String oldPass, String newPass) async {
    var body = {'old_pwd': oldPass, 'new_pwd': newPass, 'cnew_pwd': newPass};
    final response = GlobalResponse.fromJson(await HttpRequests.instance()
        ?.httpPutRequest(ApiEndPoints.memberChangePassword, body));
    if (response.status == -1) {
      return {'errorMessage': response.message ?? 'Something Went Wrong'};
    }
    return response.message;
  }

  Future<void> getMemberDetails() async {
    _memberDetailsData = null;
    notifyWithRequest(memberRequestData, true);
    final response = member_details_response.MemberProfileResponse.fromJson(
        await HttpRequests.instance()
            ?.httpGetRequest(ApiEndPoints.memberProfile));
    if (response.data?.isNotEmpty == true) {
      _memberDetailsData = response.data![0];
    } else {
      memberRequestData.setErrorData(response.toJson());
    }
    notifyWithRequest(memberRequestData, false);
  }

  Future<void> getHolidays() async {
    notifyWithRequest(memberRequestData, true);
    _holidaysList.clear();
    final response = holiday_response.HolidaysResponse.fromJson(
        await HttpRequests.instance()
            ?.httpGetRequest(ApiEndPoints.memberHolidays));
    if (response.status == -1) {
      memberRequestData.setErrorData(response.toJson());
    } else {
      _holidaysList.addAll(response.data!);
    }
    notifyWithRequest(memberRequestData, false);
  }

  Future<void> getDocs() async {
    notifyWithRequest(memberRequestData, true);
    _docsList.clear();
    final response = docs_response.DocumentsResponse.fromJson(
        await HttpRequests.instance()
            ?.httpGetRequest(ApiEndPoints.memberDocuments));
    if (response.status == -1) {
      memberRequestData.setErrorData(response.toJson());
    } else {
      _docsList.addAll(response.data!);
    }
    notifyWithRequest(memberRequestData, false);
  }

  Future<void> getMemberFees({bool isAMC = false}) async {
    notifyWithRequest(memberRequestData, true);
    _feesList.clear();
    final response = fee_response.MemberFeePayments.fromJson(
        await HttpRequests.instance()?.httpGetRequest(
            isAMC ? ApiEndPoints.memberAMC : ApiEndPoints.memberFee));
    if (response.status == -1) {
      memberRequestData.setErrorData(response.toJson());
    } else {
      _feesList.addAll(response.data!);
    }
    notifyWithRequest(memberRequestData, false);
  }

  Future<void> getOffers() async {
    notifyWithRequest(memberRequestData, true);
    _offersList.clear();
    final response = offers_response.OffersResponse.fromJson(
        await HttpRequests.instance()
            ?.httpGetRequest(ApiEndPoints.memberOffers));
    if (response.status == -1) {
      memberRequestData.setErrorData(response.toJson());
    } else {
      _offersList.addAll(response.data!);
    }
    notifyWithRequest(memberRequestData, false);
  }

  Future<void> getTrips(int type) async {
    if (type == 0) {
      notifyWithRequest(myUpTripsRequestData, true);
      _upTripsList.clear();
    } else {
      notifyWithRequest(myCompTripsRequestData, true);
      _comTripsList.clear();
    }
    final response = trips_response.MyTripsResponse.fromJson(
        await HttpRequests.instance()?.httpGetRequest(ApiEndPoints.memberTrips
            .replaceAll('{trip_type}', type == 0 ? 'upcoming' : 'completed')));
    if (type == 0) {
      notifyWithRequest(myUpTripsRequestData, true);
      _upTripsList.clear();
      if (response.status == -1) {
        myUpTripsRequestData.setErrorData(response.toJson());
      } else {
        _upTripsList.addAll(response.data!);
      }
      notifyWithRequest(myUpTripsRequestData, false);
    } else {
      if (response.status == -1) {
        myCompTripsRequestData.setErrorData(response.toJson());
      } else {
        _comTripsList.addAll(response.data!);
      }
      notifyWithRequest(myCompTripsRequestData, false);
    }
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
}
