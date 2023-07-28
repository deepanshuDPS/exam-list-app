import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'package:exam_list/responseModels/login/login_response.dart' as loginResponse;

class PreferencesData {

  //save user details
  static Future<void> saveUserData(loginResponse.Data userData) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.userData, jsonEncode(userData));
  }

  // get user details
  static Future<loginResponse.Data?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(Constants.userData);
    if (data == null) return null;
    var userDetails = loginResponse.Data.fromJson(jsonDecode(data));
    return userDetails;
  }

  static Future<void> clearOnLogOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(Constants.userData);
  }
}
