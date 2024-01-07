import 'package:exam_list/network/http_requests.dart';
import 'package:exam_list/responseModels/user/terms_policy_response.dart';
import 'package:get/get.dart';

class InfoController extends GetxController {
  var isProgress = false.obs;
  Rx<dynamic> data = Rx<dynamic>(null);

  void getTermsPolicy() async {
    isProgress.value = true;
    final response = TermsPolicyResponse.fromJson(await HttpRequests.instance()
        ?.httpGetRequest(ApiEndPoints.infoTermsPolicy));
    isProgress.value = false;
    if (response.status == true) {
      data.value = response.data;
    }else{
      data.value = response.message ?? 'Something went Wrong';
    }
  }
}
