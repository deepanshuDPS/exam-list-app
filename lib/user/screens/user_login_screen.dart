import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/widgets/btn_form_submit.dart';
import 'package:exam_list/widgets/illustration_svg.dart';
import 'package:provider/provider.dart';

import '../extras/otp_sheet.dart';

class UserLoginScreen extends StatefulWidget {
  static const routeName = "/user-login";

  const UserLoginScreen({Key? key}) : super(key: key);

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final _globalFormKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();
  String? _verificationId;

  UserProvider get userProvider {
    // Initialize the property only when accessed for the first time
    return Provider.of<UserProvider>(context, listen: false);
  }

  void _verifyMobileNumber() async {
    String mobileNumber = _mobileController.text.trim();
    _verificationId = null;
    // switch to otp dialog here
    userProvider.verifyMobileNumber(
      '+91$mobileNumber',
      (dynamic message, PhoneAuthCredential? phoneAuthCredential) {
        if (message is FirebaseAuthException) {
          // something went wrong
          print("here error");
        } else if (phoneAuthCredential != null) {
          showSnackBar(context, message);
          userProvider
              .loginMobile(phoneAuthCredential)
              .then((value) {})
              .onError((error, stackTrace) {});
        }
      },
      (verificationId, resendToken) {
        print("code sent");
        _verificationId = verificationId;
        // switch to otp screen with verificationId
      },
      (verificationId) {
        print("timeout");
        _verificationId = verificationId;
        // code auto retrieval timeout
        // request for otp && switch to otp screen with verificationId
        // again verify mobile
      },
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return OTPSheet(
          confirmOTP: (smsCode) {
            userProvider.authenticateOTP(smsCode, _verificationId!).then((UserCredential value){
              print(value.user?.phoneNumber);
            });
          },
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
  }

  // void _signInWithOTP(String smsCode) async {
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //     verificationId: _verificationId,
  //     smsCode: smsCode,
  //   );
  //
  //   try {
  //     UserCredential authResult = await _auth.signInWithCredential(credential);
  //     // User is logged in, navigate to the home screen or perform desired action.
  //   } catch (e) {
  //     print('Sign in failed: $e');
  //     // Handle sign-in failure, e.g., show an error message.
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        child: SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const IllustrationSVG(image: 'assets/svg/ill_login.svg'),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Member Login',
                style: AppStyles.robotoBold().copyWith(fontSize: 22),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 24,
              ),
              Form(
                key: _globalFormKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      style: AppStyles.inputTextStyle(),
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: AppStyles.inputDecorationWithoutIcon(
                              'Enter Mobile Number',
                              prefixText: '+91 ')
                          .copyWith(counterText: ""),
                    ),
                    // TextFormField(
                    //   style: AppStyles.inputTextStyle(),
                    //   keyboardType: TextInputType.text,
                    //   controller: _userIdController,
                    //   onSaved: (input) => {
                    //     /* loginRequestModel.email = input */
                    //   },
                    //   validator: (input) => input?.isEmpty ?? true
                    //       ? "Please Enter Membership Id"
                    //       : null,
                    //   decoration: AppStyles.inputDecoration(
                    //       "Membership Id", Icons.email),
                    // ),
                    const SizedBox(height: 30),
                    ButtonFormSubmit(
                        onClick: () {
                          if (_globalFormKey.currentState?.validate() == true) {
                            _verifyMobileNumber();
                          }
                        },
                        text: 'Get Started'),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          )),
    ));
  }
}
