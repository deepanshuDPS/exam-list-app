import 'dart:async';

import 'package:flutter/material.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/colors.dart';
import 'package:exam_list/widgets/btn_form_submit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OTPSheet extends StatefulWidget {
  final Function confirmOTP;
  final Function resentOTP;

  const OTPSheet({Key? key, required this.confirmOTP, required this.resentOTP})
      : super(key: key);

  @override
  State<OTPSheet> createState() => _OTPSheetState();
}

class _OTPSheetState extends State<OTPSheet> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());
  final _globalFormKey = GlobalKey<FormState>();

  int _counter = 120; // Initial counter value (1 minute = 60 seconds)
  Timer? _timer; // Timer object

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          // Timer has reached 0, you can enable the Resend OTP button here
          timer.cancel(); // Cancel the timer when done
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void onSubmitClick() {
    String enteredOTP =
        _otpControllers.map((controller) => controller.text).join();
    if (enteredOTP.length != 6) {
      Fluttertoast.showToast(
        msg: 'Please enter valid OTP',
      );
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    widget.confirmOTP(context, enteredOTP);
  }

  OutlineInputBorder _outLinedBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: appRed, width: 2.0),
      borderRadius: BorderRadius.circular(6.0),
    );
  }

  String formatDuration(int seconds) {
    int minutes = seconds ~/ 60; // Get the whole minutes
    int remainingSeconds = seconds % 60; // Get the remaining seconds

    String result = '';
    result += '0$minutes:';
    result += '${remainingSeconds < 10 ? '0' : ''}$remainingSeconds';

    return result.trim(); // Remove trailing whitespace
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(
          top: 20,
          right: 20,
          left: 20,
          bottom: /*MediaQuery.of(context).viewInsets.bottom +*/ 40),
      // padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 60,
              height: 5,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(217, 217, 217, 1),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(2.5),
                      bottomRight: Radius.circular(2.5))),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Enter OTP',
            style: AppStyles.blackBoldText()
                .copyWith(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'Enter the 6 digits code that you received on your Mobile No.',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: sharpGrey),
          ),
          const SizedBox(
            height: 16,
          ),
          Form(
            key: _globalFormKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    6,
                    (index) => Container(
                      width: 42,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      child: TextFormField(
                        controller: _otpControllers[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "*",
                          counterText: '',
                          enabledBorder: _outLinedBorder(),
                          focusedBorder: _outLinedBorder(),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 2),
                        ),
                        maxLength: 1,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            if (index < 5) {
                              FocusScope.of(context).nextFocus();
                            }
                          } else {
                            if (index > 0) {
                              FocusScope.of(context).previousFocus();
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: _counter > 0
                        ? null
                        : () {
                            Navigator.of(context).pop();
                            widget.resentOTP();
                          },
                    child: Text(
                      _counter > 0
                          ? '${formatDuration(_counter)} time left to resend OTP'
                          : 'Resend OTP',
                      style: TextStyle(
                        fontSize: 14,
                        color: _counter > 0 ? sharpGrey : appRed,
                        decoration:
                            _counter > 0 ? null : TextDecoration.underline,
                      ),
                    )),
                const SizedBox(
                  height: 16,
                ),
                ButtonFormSubmit(
                  text: 'Continue',
                  onClick: () {
                    if (_globalFormKey.currentState?.validate() == true) {
                      onSubmitClick();
                    }
                  },
                ),
                TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                          fontSize: 14,
                          color: appRed,
                          fontWeight: FontWeight.w600),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }
}
