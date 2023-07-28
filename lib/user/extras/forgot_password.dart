import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/providers/home_provider.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/widgets/btn_form_submit.dart';
import 'package:provider/provider.dart';

class ForgotPasswordSheet extends StatefulWidget {
  const ForgotPasswordSheet({Key? key}) : super(key: key);

  @override
  BaseState<ForgotPasswordSheet> createState() => _ForgotPasswordSheetState();
}

class _ForgotPasswordSheetState extends BaseState<ForgotPasswordSheet> {
  final _memberIdController = TextEditingController();
  final _globalFormKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      // something to do
    }
    super.didChangeDependencies();
  }

  void onProceedClick() {
    var enteredText = _memberIdController.text.trim();
    showProgressDialog(context);
    Provider.of<HomeProvider>(context, listen: false)
        .forgotPassword(enteredText)
        .then((value) {
      Navigator.of(context).pop();
      if (value is String) {
        _memberIdController.clear();
      }
      Fluttertoast.showToast(
          msg: value is String ? value : value['errorMessage']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          padding: const EdgeInsets.all(10),
          height: 325,
          child: SvgPicture.asset(
            'assets/svg/bg_forgot_password.svg',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          color: Colors.transparent,
          padding: EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          // padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 5,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(217, 217, 217, 1),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(2.5),
                        bottomRight: Radius.circular(2.5))),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Forget Password',
                style: AppStyles.robotoBlackText()
                    .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: _globalFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _memberIdController,
                      validator: (input) => (input?.length ?? 0) < 5
                          ? "Please Enter Valid MembershipId"
                          : null,
                      style: AppStyles.inputTextStyle(),
                      keyboardType: TextInputType.text,
                      // onSaved: (input) => loginRequestModel.email = input,
                      obscureText: false,
                      decoration: AppStyles.inputDecoration(
                          'Enter Membership No.', Icons.lock_clock_outlined),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ButtonFormSubmit(
                      text: 'Submit',
                      onClick: () {
                        if (_globalFormKey.currentState?.validate() == true) {
                          onProceedClick();
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
