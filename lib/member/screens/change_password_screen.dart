import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/widgets/btn_form_submit.dart';
import 'package:exam_list/widgets/illustration_svg.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = "/change-password";

  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  BaseState<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends BaseState<ChangePasswordScreen> {
  final _globalFormKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _hideOldPassword = true;
  bool _hideNewPassword = true;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const IllustrationSVG(
                  image: 'assets/svg/ill_change_password.svg',
                  fit: BoxFit.none,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Change Password',
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
                        obscureText: _hideOldPassword,
                        controller: _oldPasswordController,
                        onSaved: (input) => {
                          /* loginRequestModel.email = input */
                        },
                        validator: (input) => input?.isEmpty ?? true
                            ? "Please Enter Old Password"
                            : null,
                        decoration: AppStyles.inputDecoration(
                                "Old Password", Icons.lock_clock_outlined)
                            .copyWith(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _hideOldPassword = !_hideOldPassword;
                              });
                            },
                            color: Colors.black,
                            icon: Icon(_hideOldPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                          style: AppStyles.inputTextStyle(),
                          controller: _newPasswordController,
                          keyboardType: TextInputType.text,
                          onSaved: (input) => {
                                /*loginRequestModel.password = input*/
                              },
                          validator: (input) => input?.isEmpty ?? true
                              ? "Please Enter New Password"
                              : null,
                          obscureText: _hideNewPassword,
                          decoration: AppStyles.inputDecoration(
                                  "New Password", Icons.lock_open)
                              .copyWith(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _hideNewPassword = !_hideNewPassword;
                                });
                              },
                              color: Colors.black,
                              icon: Icon(_hideNewPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          )),
                      const SizedBox(height: 20),
                      TextFormField(
                          style: AppStyles.inputTextStyle(),
                          controller: _confirmPasswordController,
                          keyboardType: TextInputType.text,
                          onSaved: (input) => {
                                /*loginRequestModel.password = input*/
                              },
                          validator: (input) {
                            if (input?.isEmpty == true) {
                              return "Please Enter Password for Confirmation";
                            } else if (input != _newPasswordController.text) {
                              return "New password and Confirm password must be same";
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: AppStyles.inputDecoration(
                              "Confirm Password", Icons.lock_outline)),
                      const SizedBox(height: 20),
                      ButtonFormSubmit(
                          onClick: () {
                            if (_globalFormKey.currentState?.validate() ==
                                true) {
                              _proceedPasswordChange();
                            }
                          },
                          text: 'Reset'),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ],
            )));
  }

  void _proceedPasswordChange() {
    var enteredOldPassword = _oldPasswordController.text;
    var enteredNewPassword = _newPasswordController.text;
    showProgressDialog(context);
    Provider.of<UserProvider>(context, listen: false)
        .changePassword(enteredOldPassword, enteredNewPassword)
        .then((value) {
      Navigator.of(context).pop();
      showSnackBar(context, value is String ? value : value['errorMessage']);
      if (value is String) {
        for (var element in [
          _oldPasswordController,
          _newPasswordController,
          _confirmPasswordController
        ]) {
          element.clear();
        }
      }
    });
  }
}
