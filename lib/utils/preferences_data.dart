import 'dart:convert';

import 'package:exam_list/responseModels/login/check_user_response.dart' as checkUserResponse;
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

class PreferencesData {

  //save user details
  static Future<void> saveUserData(checkUserResponse.Data userData) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.userData, jsonEncode(userData));
  }

  // get user details
  static Future<checkUserResponse.Data?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(Constants.userData);
    if (data == null) return null;
    var userDetails = checkUserResponse.Data.fromJson(jsonDecode(data));
    return userDetails;
  }

  static Future<void> clearOnLogOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(Constants.userData);
  }
}
