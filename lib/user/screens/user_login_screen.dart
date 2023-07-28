import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/widgets/btn_form_submit.dart';
import 'package:exam_list/widgets/illustration_svg.dart';

class UserLoginScreen extends StatefulWidget {
  static const routeName = "/user-login";

  const UserLoginScreen({Key? key}) : super(key: key);

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final _globalFormKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();

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
                          decoration: AppStyles.inputDecorationWithoutIcon('Enter Mobile Number', prefixText: '+91 ')
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
                              if (_globalFormKey.currentState?.validate() ==
                                  true) {
                                _loginUser();
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

  void _loginUser() {
    // var enteredMemNum = _userIdController.text.trim();
    // var enteredPassword = _passwordController.text.trim();
    // showProgressDialog(context);
    // Provider.of<UserProvider>(context, listen: false)
    //     .loginUser(enteredMemNum, enteredPassword)
    //     .then((value) {
    //   Navigator.of(context).pop();
    //   if (value is bool) {
    //     Navigator.of(context).pop();
    //   } else {
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(makeSnackBar(value as String));
    //   }
    // });
  }
}
