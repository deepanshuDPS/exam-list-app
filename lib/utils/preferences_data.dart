import 'dart:convert';

import 'package:exam_list/responseModels/user/check_user_response.dart'
    as check_user_response;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

class PreferencesData {
  //save user details
  static Future<void> saveUserData(check_user_response.Data userData) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.userData, jsonEncode(userData));
  }

  // get user details
  static Future<check_user_response.Data?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(Constants.userData);
    if (data == null) return null;
    var userDetails = check_user_response.Data.fromJson(jsonDecode(data));
    return userDetails;
  }

  static Future<void> notifyAddNumber(String adNumber) async {
    final prefs = await SharedPreferences.getInstance();
    var subsList = prefs.getStringList(Constants.subscriptions) ?? [];
    if (!subsList.contains(adNumber)) {
      subsList.add(adNumber);
    }
    prefs.setStringList(Constants.subscriptions, subsList);
  }

  static Future<void> setNewSubsList(List<String> subsList) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(Constants.subscriptions, subsList);
  }

  // get user details
  static Future<List<String>> getSubscriptions() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(Constants.subscriptions) ?? [];
  }

  static Future<void> checkFCMToken() async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    final prefs = await SharedPreferences.getInstance();
    var savedToken = prefs.getString(Constants.fcmToken);
    if (fcmToken != savedToken) {
      prefs.setString(Constants.fcmToken, fcmToken ?? "");
      prefs.setBool(Constants.isFcmTokenSent, false);
    }
  }

  static Future<String> getFCMToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.fcmToken) ?? "";
  }

  static Future<bool> isFCMSent() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constants.isFcmTokenSent) ?? false;
  }

  static Future<int> getCurrentVersion() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(Constants.currentVersion) ?? 0;
  }

  static Future<void> setCurrentVersion() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(Constants.currentVersion, await getCurrentVersion() + 1);
  }

  static Future<void> clearOnLogOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(Constants.userData);
    prefs.remove(Constants.isFcmTokenSent);
    prefs.remove(Constants.currentVersion);
  }
}
