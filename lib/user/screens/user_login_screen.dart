import 'package:exam_list/home/screens/home_screen.dart';
import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/user/extras/otp_sheet.dart';
import 'package:exam_list/utils/constants.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/widgets/btn_form_submit.dart';
import 'package:exam_list/widgets/illustration_svg.dart';
import 'package:provider/provider.dart';

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
    showProgressDialog(context);
    userProvider.verifyMobileNumber(
      '+91$mobileNumber',
      (dynamic message, PhoneAuthCredential? phoneAuthCredential) {
        if (message is FirebaseAuthException) {
          // something went wrong
        } else if (phoneAuthCredential != null) {
          showSnackBar(context, message);
          signInForMobile(phoneAuthCredential);
        }
      },
      (verificationId, resendToken) {
        Navigator.of(context).pop();
        _verificationId = verificationId;
        showGetOTPSheet();
        // switch to otp screen with verificationId
      },
      (verificationId) {
        _verificationId = verificationId;
        // code auto retrieval timeout
        // request for otp && switch to otp screen with verificationId
        // again verify mobile
        // Navigator.of(context).popUntil(ModalRoute.withName('/'));
        // showGetOTPSheet();
      },
    );
  }

  void showGetOTPSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return OTPSheet(
          confirmOTP: (smsCode) {
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: _verificationId!,
              smsCode: smsCode,
            );
            signInForMobile(credential);
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

  void signInForMobile(PhoneAuthCredential credential) {
    showProgressDialog(context);
    userProvider.loginMobile(credential).then((value) {
      Navigator.of(context).pop();
      if (value is String) {
        showSnackBar(context, value);
      } else {
        // successfully login toast
        // check on boarding and change screen
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
      }
    }).onError((error, stackTrace) {
      Navigator.of(context).pop();
      if (error is FirebaseException) {
        showSnackBar(context, (error).message!);
      } else {
        showSnackBar(context, Constants.somethingWentWrong);
      }
    });
  }

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
