import 'dart:convert';

import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/utils/preferences_data.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

Future<dynamic> getAuthCachedResponse(
    String endPoint, Map<String, String> headers) async {
  try {
    // end point will be like this /api/v1/users
    // make box name as _api_v1_users
    var cachePoint = endPoint.split("?").first.replaceAll("/", "_");
    var box = await Hive.openBox<dynamic>(cachePoint);
    if (box.length != 4) {
      // I have 4 keys for now
      // id-token, max-age, current-version, response
      printDebug("here size");
      return null;
    }
    var currentVersion = await PreferencesData.getCurrentVersion();
    if (box.get("current-version") != currentVersion) {
      printDebug("here version");
      return null;
    }
    if (box.get("max-age") > DateTime.now().millisecondsSinceEpoch &&
        box.get("id-token") == headers['id-token']) {
      printDebug("from_cache");
      return jsonDecode(box.get("response"));
    }
  } catch (e) {
    printDebug(e.toString());
    return null;
  }

  return null;
}

Future<void> saveAuthCachedResponse(
    String endPoint, Map<String, String> headers, Response response) async {
  try {
    // end point will be like this /api/v1/users
    // make box name as _api_v1_users
    var cachePoint = endPoint.split("?").first.replaceAll("/", "_");

    var box = await Hive.openBox<dynamic>(cachePoint);
    box.put("response", utf8.decode(response.bodyBytes));
    box.put("id-token", headers['id-token']);
    box.put("current-version", await PreferencesData.getCurrentVersion());
    box.put(
        "max-age",
        extractMaxAgeInSeconds(
            response.headers['cache-control'] ?? "max-age=3600"));
    printDebug("saved_to_cache");
  } catch (e) {
    printDebug(e.toString());
    rethrow;
  }
}

int extractMaxAgeInSeconds(String header) {
  final RegExp regExp = RegExp(r'max-age=(\d+)');
  final Match match = regExp.firstMatch(header) as Match;

  if (match.groupCount >= 1) {
    final String? secondsString = match.group(1);
    return DateTime.now().millisecondsSinceEpoch +
        (int.tryParse(secondsString ?? "3600") ?? 3600) * 1000;
  }

  return DateTime.now().millisecondsSinceEpoch + 3600 * 1000;
}
