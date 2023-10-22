import 'package:exam_list/home/screens/home_screen.dart';
import 'package:exam_list/options/screens/terms_conditions_screen.dart';
import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/user/extras/otp_sheet.dart';
import 'package:exam_list/user/screens/user_onboarding_screen.dart';
import 'package:exam_list/utils/colors.dart';
import 'package:exam_list/utils/constants.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/widgets/btn_form_submit.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  bool _agreedToTerms = false;
  String? _verificationId;

  UserProvider get userProvider {
    // Initialize the property only when accessed for the first time
    return Provider.of<UserProvider>(context, listen: false);
  }

  void _verifyMobileNumber() async {
    if (!_agreedToTerms) {
      showSnackBar(context, 'Please Agree to Terms');
      return;
    }
    String mobileNumber = _mobileController.text.trim();

    if (kDebugMode && mobileNumber == '8800757476') {
      _signInForGuest(mobileNumber);
      return;
    }

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
          _signInForMobile(context, phoneAuthCredential);
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
      isDismissible: false,
      builder: (BuildContext context) {
        return OTPSheet(
          confirmOTP: (vContext, smsCode) {
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: _verificationId!,
              smsCode: smsCode,
            );
            _signInForMobile(vContext, credential);
          },
          resentOTP: () {
            _verifyMobileNumber();
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

  void _signInForMobile(BuildContext vContext, PhoneAuthCredential credential) {
    showProgressDialog(context);
    userProvider.loginMobile(credential).then((value) {
      Navigator.of(context).pop();
      if (value is String) {
        if (vContext != context) {
          Fluttertoast.showToast(
            msg: value,
          );
        } else {
          showSnackBar(context, value);
        }
      } else {
        // successfully login toast
        // check on boarding and change screen
        if (value == true) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, UserOnBoardingScreen.routeName, (route) => false);
        }
      }
    }).onError((error, stackTrace) {
      Navigator.of(context).pop();
      var value = Constants.somethingWentWrong;
      if (error is FirebaseException) {
        value = (error).message ?? Constants.somethingWentWrong;
      }
      if (vContext != context) {
        Fluttertoast.showToast(
          msg: value,
        );
      } else {
        showSnackBar(context, value);
      }
    });
  }

  void _signInForGuest(String mobile) {
    showProgressDialog(context);
    userProvider.loginGuest(mobile).then((value) {
      Navigator.of(context).pop();
      if (value is String) {
        showSnackBar(context, value);
      } else {
        // successfully login toast
        // check on boarding and change screen
        if (value == true) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, UserOnBoardingScreen.routeName, (route) => false);
        }
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Stack(
          children: [
            // First child - Image with fit center
            Image.asset(
              'assets/images/bg_login.jpg',
              // Replace 'your_image.png' with your image file
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            // Second child - White gradient at the bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.white.withOpacity(0.8),
                      Colors.white.withOpacity(0.9),
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white
                    ],
                  ),
                ),
              ),
            ),
            // Third child - Widgets at the bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Get Instant Information',
                      textAlign: TextAlign.center,
                      style: AppStyles.robotoBold().copyWith(fontSize: 22),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.',
                      textAlign: TextAlign.center,
                      style: AppStyles.robotoBlackText().copyWith(fontSize: 14),
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
                            validator: (input) => input?.isEmpty ?? true
                                ? "Please Enter Mobile Number"
                                : input?.length != 10
                                    ? 'Please Enter a Valid Mobile Number'
                                    : null,
                            maxLength: 10,
                            decoration: AppStyles.inputDecorationWithoutIcon(
                                    'Enter Mobile Number',
                                    prefixText: '+91 ')
                                .copyWith(counterText: ""),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Checkbox(
                                value: _agreedToTerms,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _agreedToTerms = value ?? false;
                                  });
                                },
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, TermsConditionsScreen.routeName);
                                },
                                child: RichText(
                                    text: const TextSpan(
                                        text: 'Please, agree with our ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                        children: [
                                      TextSpan(
                                          text: 'Terms & Conditions',
                                          style: TextStyle(
                                              color: appRed,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600))
                                    ])),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          ButtonFormSubmit(
                              onClick: () {
                                if (_globalFormKey.currentState?.validate() ==
                                    true) {
                                  _verifyMobileNumber();
                                }
                              },
                              text: 'Get Started'),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
