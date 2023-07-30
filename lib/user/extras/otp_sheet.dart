import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/colors.dart';
import 'package:exam_list/widgets/btn_form_submit.dart';

class OTPSheet extends StatefulWidget {
  final Function confirmOTP;

  const OTPSheet(
      {Key? key, required this.confirmOTP})
      : super(key: key);

  @override
  State<OTPSheet> createState() => _OTPSheetState();
}

class _OTPSheetState extends State<OTPSheet> {
  final _otpController = TextEditingController();
  final _globalFormKey = GlobalKey<FormState>();

  void onSubmitClick() {
    var enteredOTP = _otpController.text.trim();
    FocusScope.of(context).requestFocus(FocusNode());
    widget.confirmOTP(enteredOTP);
    // showProgressDialog(context);
    // Provider.of<UserProvider>(context, listen: false)
    //     .bookingOfferOrHoliday(widget.bodyData, widget.isOffer)
    //     .then((value) {
    //   Navigator.of(context).pop();
    //   Fluttertoast.showToast(
    //       msg: value is String ? value : value['errorMessage']);
    //   if (value is String) {
    //     Navigator.of(context).pop();
    //   }
    // });
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
          height: 330,
          child: SvgPicture.asset(
            'assets/svg/bg_voucher.svg',
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
                'Booking',
                style: AppStyles.robotoBlackText()
                    .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Please enter OTP for Login',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: appDarkBlue),
              ),
              const SizedBox(
                height: 8,
              ),
              Form(
                key: _globalFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _otpController,
                      validator: (input) =>
                          (input?.length ?? 0) < 6 && input != ''
                              ? "Please Enter Valid OTP."
                              : null,
                      maxLength: 6,
                      style: AppStyles.inputTextStyle(),
                      keyboardType: TextInputType.phone,
                      // onSaved: (input) => loginRequestModel.email = input,
                      obscureText: false,
                      decoration: AppStyles.inputDecoration(
                              'Enter OTP', Icons.phone_android)
                          .copyWith(counterText: ""),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ButtonFormSubmit(
                      text: 'Submit',
                      onClick: () {
                        if (_globalFormKey.currentState?.validate() == true) {
                          onSubmitClick();
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
