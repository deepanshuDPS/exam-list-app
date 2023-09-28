import 'package:exam_list/responseModels/user/aspirant_data.dart';
import 'package:exam_list/responseModels/user/notification_response.dart'
    as notification_response;
import 'package:exam_list/responseModels/user/terms_policy_response.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/network/http_requests.dart';
import 'package:exam_list/responseModels/user/aspirant_profile_response.dart'
    as aspirant_profile_response;
import 'package:exam_list/responseModels/request_data.dart';
import 'package:exam_list/utils/preferences_data.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:exam_list/responseModels/user/check_user_response.dart'
    as check_user_response;

class UserProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  AspirantData? _aspirantDetailsData;
  check_user_response.Data? _userDetailsData;
  final List<notification_response.Notification> _notifications = [];

  RequestData aspirantRequestData = RequestData();
  RequestData notificationsRequestData = RequestData();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var _currentVersion = -1;

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

  bool get isLogin {
    return _isLoggedIn;
  }

  AspirantData? get aspirantDetails {
    return _aspirantDetailsData;
  }

  List<notification_response.Notification> get notifications {
    return _notifications;
  }

  check_user_response.Data? get userDetails {
    return _userDetailsData;
  }

  Future<void> logoutUser() async {
    await removeFcmDisableNotification();
    await _auth.signOut();
    await PreferencesData.clearOnLogOut();
    _isLoggedIn = false;
  }

  Future<void> removeFcmDisableNotification() async {
    String fcmTokenToRemove = await PreferencesData.getFCMToken();
    try {
      if (fcmTokenToRemove != "") {
        await HttpRequests.instance()?.httpPatchRequest(
            ApiEndPoints.logoutUser, {'fcmTokenToRemove': fcmTokenToRemove});
      } else {
        return;
      }
    } catch (e) {
      e.toString();
    } finally {
      FirebaseMessaging.instance.deleteToken().then((value) {
        PreferencesData.checkFCMToken();
      });
      var subsList = await PreferencesData.getSubscriptions();
      for (var topic in subsList) {
        FirebaseMessaging.instance.unsubscribeFromTopic(topic);
      }
    }
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
      printDebug("hello here");
      aspirantRequestData.setErrorData(response.toJson());
    }
    notifyWithRequest(aspirantRequestData, false);
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

  Future<void> getNotifications() async {
    notifyWithRequest(notificationsRequestData, true);
    final response = notification_response.NotificationResponse.fromJson(
        await HttpRequests.instance()
            ?.httpGetRequest(ApiEndPoints.getAspirantNotification));
    if (response.data != null) {
      _notifications.addAll(response.data ?? []);
    } else {
      notificationsRequestData.setErrorData(response.toJson());
    }
    notifyWithRequest(notificationsRequestData, false);
  }

  void setCurrentVersion() async {
    _currentVersion = await PreferencesData.getCurrentVersion();
  }

  Future<bool> isNewVersionAvailable() async {
    var newVersion = await PreferencesData.getCurrentVersion();
    if (_currentVersion != newVersion) {
      _currentVersion = newVersion;
      return true;
    }
    return false;
  }
}
