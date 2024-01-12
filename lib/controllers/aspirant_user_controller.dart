import 'package:exam_list/controllers/aspirant_exam_controller.dart';
import 'package:exam_list/network/http_requests.dart';
import 'package:exam_list/responseModels/request_data.dart';
import 'package:exam_list/responseModels/user/aspirant_data.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/utils/preferences_data.dart';
import 'package:get/get.dart';
import 'package:exam_list/responseModels/user/aspirant_profile_response.dart'
    as aspirant_profile_response;
import 'package:exam_list/responseModels/user/notification_response.dart'
    as notification_response;

import 'package:exam_list/responseModels/user/check_user_response.dart'
    as check_user_response;

class AspirantUserController extends GetxController {
  AspirantData? _aspirantDetailsData;
  final AspirantExamController _examController = Get.find();

  final List<notification_response.Notification> _notifications = [];

  AspirantData? get aspirantDetails => _aspirantDetailsData;

  List<notification_response.Notification> get notifications => _notifications;

  final Rx<RequestData> aspirantRequestData = RequestData().obs;
  final Rx<RequestData> notificationRequestData = RequestData().obs;

  Future<dynamic> getAspirantUser() async {
    _aspirantDetailsData = null;
    notifyWithRequest(aspirantRequestData, true);
    final response = aspirant_profile_response.AspirantProfileResponse.fromJson(
        await HttpRequests.instance()
            ?.httpGetRequest(ApiEndPoints.getAspirant));
    if (response.data != null) {
      _aspirantDetailsData = response.data;
      // refresh exam user
      _examController.updatedAspirantData = _aspirantDetailsData!;
    } else {
      notifyWithRequest(aspirantRequestData, false, response.toJson());
      return;
    }
    notifyWithRequest(aspirantRequestData, false);
  }

  Future<void> getNotifications() async {
    _notifications.clear();
    notifyWithRequest(notificationRequestData, true);
    final response = notification_response.NotificationResponse.fromJson(
        await HttpRequests.instance()
            ?.httpGetRequest(ApiEndPoints.getAspirantNotification));
    if (response.data != null) {
      _notifications.addAll(response.data ?? []);
    } else {
      notifyWithRequest(notificationRequestData, false, response.toJson());
      return;
    }
    notifyWithRequest(notificationRequestData, false);
  }

  final selectedDate = Rx<DateTime?>(null);
  final editDetailsData = Rx<AspirantData?>(null);

  AspirantData? get editDetails => editDetailsData.value;

  Future<void> getProfileDetails() async {
    editDetailsData.value = null;
    selectedDate.value = null;
    final response = aspirant_profile_response.AspirantProfileResponse.fromJson(
        await HttpRequests.instance()
            ?.httpGetRequest(ApiEndPoints.getAspirant));
    if (response.data != null) {
      _aspirantDetailsData = response.data;
      // refresh exam user
      _examController.updatedAspirantData = _aspirantDetailsData!;
      // edit details with copied data
      selectedDate.value = DateTime.parse(_aspirantDetailsData?.dob ?? "");
      editDetailsData.value = _aspirantDetailsData?.copyWith();
    }
  }

  Future<dynamic> editAspirantProfile() async {
    final response = check_user_response.CheckUserResponse.fromJson(
        await HttpRequests.instance()?.httpPutRequest(
            ApiEndPoints.editAspirantProfile, editDetails?.toJson() ?? {}));
    if (response.status == true) {
      await PreferencesData.setCurrentVersion();
      return true;
    }
    return response.message ?? 'Something went Wrong';
  }
}
