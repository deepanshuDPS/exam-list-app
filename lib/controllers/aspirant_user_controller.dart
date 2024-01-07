import 'package:exam_list/controllers/aspirant_exam_controller.dart';
import 'package:exam_list/network/http_requests.dart';
import 'package:exam_list/responseModels/request_data.dart';
import 'package:exam_list/responseModels/user/aspirant_data.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:get/get.dart';
import 'package:exam_list/responseModels/user/aspirant_profile_response.dart'
    as aspirant_profile_response;

class AspirantUserController extends GetxController {

  AspirantData? _aspirantDetailsData;
  final AspirantExamController _examController = Get.find();


  AspirantData? get aspirantDetails {
    return _aspirantDetailsData;
  }

  final Rx<RequestData> aspirantRequestData = RequestData().obs;

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
}
