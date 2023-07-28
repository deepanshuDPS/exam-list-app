import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/member/extras/forgot_password.dart';
import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/widgets/btn_form_submit.dart';
import 'package:exam_list/widgets/illustration_svg.dart';
import 'package:provider/provider.dart';

class MemberLoginScreen extends StatefulWidget {
  static const routeName = "/member-login";

  const MemberLoginScreen({Key? key}) : super(key: key);

  @override
  State<MemberLoginScreen> createState() => _MemberLoginScreenState();
}

class _MemberLoginScreenState extends State<MemberLoginScreen> {
  final _globalFormKey = GlobalKey<FormState>();
  final _userIdController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;

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
                          keyboardType: TextInputType.text,
                          controller: _userIdController,
                          onSaved: (input) => {
                            /* loginRequestModel.email = input */
                          },
                          validator: (input) => input?.isEmpty ?? true
                              ? "Please Enter Membership Id"
                              : null,
                          decoration: AppStyles.inputDecoration(
                              "Membership Id", Icons.email),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                            style: AppStyles.inputTextStyle(),
                            controller: _passwordController,
                            keyboardType: TextInputType.text,
                            onSaved: (input) => {
                                  /*loginRequestModel.password = input*/
                                },
                            validator: (input) => input?.isEmpty ?? true
                                ? "Please Enter Password"
                                : null,
                            obscureText: _hidePassword,
                            decoration:
                                AppStyles.inputDecoration("Password", Icons.lock)
                                    .copyWith(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _hidePassword = !_hidePassword;
                                  });
                                },
                                color: Colors.black,
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Icon(_hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                              ),
                            )),
                        const SizedBox(height: 30),
                        InkWell(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Forgot Password?",
                                style: AppStyles.inputHintStyle(),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            onTap: () => {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return const ForgotPasswordSheet();
                                    },
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10),
                                      ),
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                  )
                                }),
                        const SizedBox(height: 30),
                        ButtonFormSubmit(
                            onClick: () {
                              if (_globalFormKey.currentState?.validate() ==
                                  true) {
                                _loginUser();
                              }
                            },
                            text: 'Login'),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }

  void _loginUser() {
    var enteredMemNum = _userIdController.text.trim();
    var enteredPassword = _passwordController.text.trim();
    showProgressDialog(context);
    Provider.of<UserProvider>(context, listen: false)
        .loginUser(enteredMemNum, enteredPassword)
        .then((value) {
      Navigator.of(context).pop();
      if (value is bool) {
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(makeSnackBar(value as String));
      }
    });
  }
}
