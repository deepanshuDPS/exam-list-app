import 'package:exam_list/utils/extras_utils.dart';

dynamic getErrorResponse(int errorCode, dynamic bodyContent) {
  if(bodyContent['message'] == '') {
    switch (errorCode) {
      case 001:
        bodyContent['message'] = "Something went wrong with your connection."
            " Please check your Connection and try again.";
        break;
      case 400:
        bodyContent['message'] = 'Something wrong with the request';
        break;
      case 204:
      case 404:
        bodyContent['message'] = 'No Data Found';
        break;
      case 401:
      case 403:
      case 402:
      case 406:
        break;
      case 500:
        bodyContent['message'] = 'Unable to reach server';
        break;
      default:
        bodyContent['message'] = 'Something went wrong. Please try again';
    }
  }
  bodyContent['status'] = false;
  return bodyContent;
}
