import 'package:exam_list/network/http_requests.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/utils/preferences_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:exam_list/responseModels/user/check_user_response.dart'
    as check_user_response;

class AuthUserController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<check_user_response.Data?> _userDetailsData =
      Rx<check_user_response.Data?>(null);

  static int waiting = -1;
  static int error = -2;

  final Rx<int> checkState = Rx<int>(waiting);
  var isProgress = false.obs;
  var agreedToTerms = false.obs;

  check_user_response.Data? get user => _userDetailsData.value;

  void initializeApp() async {
    try {
      if (_auth.currentUser != null) {
        var user = await PreferencesData.getUserData();
        _userDetailsData.value = user;
        var isLoggedIn = user != null;
        if (!isLoggedIn) {
          await _auth.signOut();
          checkState.value = 0;
        } else if (user.onBoarded == true) {
          checkState.value = 2;
        }
        checkState.value = 1;
      }
      checkState.value = 0;
    } catch (e) {
      checkState.value = error;
    }
  }

  Future<dynamic> loginGuest(String mobile) async {
    final customResponse = check_user_response.CheckUserResponse.fromJson(
        await HttpRequests.instance()?.httpPostRequest(
            ApiEndPoints.checkGuestUser, {'mobile': '+91$mobile'}));
    if (customResponse.status == false) {
      return customResponse.message ?? 'Something went Wrong';
    }
    printDebug(customResponse.data?.customToken ?? '');
    await _auth.signInWithCustomToken(customResponse.data?.customToken ?? '');
    final response = check_user_response.CheckUserResponse.fromJson(
        await HttpRequests.instance()?.httpGetRequest(ApiEndPoints.checkUser));
    if (response.status == true) {
      PreferencesData.saveUserData(response.data!);
      _userDetailsData.value = response.data!;
      // _isLoggedIn = true;
      return response.data?.onBoarded == true;
    }
    await _auth.signOut();
    return response.message ?? 'Something went Wrong';
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
      codeSent: (verificationId, resendToken) {
        codeSent(verificationId, resendToken);
      },
      codeAutoRetrievalTimeout: (verificationId) {
        phoneCodeAutoRetrievalTimeout(verificationId);
      },
    );
  }

  Future<dynamic> loginMobile(PhoneAuthCredential phoneAuthCredential) async {
    await _auth.signInWithCredential(phoneAuthCredential);
    final response = check_user_response.CheckUserResponse.fromJson(
        await HttpRequests.instance()?.httpGetRequest(ApiEndPoints.checkUser));
    if (response.status == true) {
      PreferencesData.saveUserData(response.data!);
      _userDetailsData.value = response.data!;
      // _isLoggedIn = true;
      return response.data?.onBoarded == true;
    }
    await _auth.signOut();
    return response.message ?? 'Something went Wrong';
  }

// void createUser(String name, String email, String password) async {
//   try {
//     AuthResult _authResult = await _auth.createUserWithEmailAndPassword(
//         email: email.trim(), password: password);
//     //create user in database.dart
//     UserModel _user = UserModel(
//       id: _authResult.user.uid,
//       name: name,
//       email: _authResult.user.email,
//     );
//     if (await Database().createNewUser(_user)) {
//       Get.find<UserController>().user = _user;
//       Get.back();
//     }
//   } catch (e) {
//     Get.snackbar(
//       "Error creating Account",
//       e.message,
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }
// }
//
// void login(String email, String password) async {
//   try {
//     AuthResult _authResult = await _auth.signInWithEmailAndPassword(
//         email: email.trim(), password: password);
//     Get.find<UserController>().user =
//     await Database().getUser(_authResult.user.uid);
//   } catch (e) {
//     Get.snackbar(
//       "Error signing in",
//       e.message,
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }
// }
//
// void signOut() async {
//   try {
//     await _auth.signOut();
//     Get.find<UserController>().clear();
//   } catch (e) {
//     Get.snackbar(
//       "Error signing out",
//       e.message,
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }
// }
}
