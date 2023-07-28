import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/options/screens/voucher_screen.dart';
import 'package:exam_list/providers/home_provider.dart';
import 'package:exam_list/responseModels/home/check_voucher_response.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/widgets/btn_form_submit.dart';
import 'package:provider/provider.dart';

class VoucherSheet extends StatefulWidget {
  const VoucherSheet({Key? key}) : super(key: key);

  @override
  BaseState<VoucherSheet> createState() => _VoucherSheetState();
}

class _VoucherSheetState extends BaseState<VoucherSheet> {
  final _voucher = TextEditingController();
  final _globalFormKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      // something to do
    }
    super.didChangeDependencies();
  }

  void onProceedClick() {
    var enteredText = _voucher.text.trim();
    FocusScope.of(context).requestFocus(FocusNode());
    showProgressDialog(context);
    Provider.of<HomeProvider>(context, listen: false)
        .checkVoucher(enteredText)
        .then((value) {
      Navigator.of(context).pop();
      if (value is Data) {
        Navigator.of(context)
            .pushNamed(VoucherScreen.routeName, arguments: value);
      } else {
        Fluttertoast.showToast(
            msg: value as String, backgroundColor: Colors.red);
      }
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
                'Voucher',
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
                      controller: _voucher,
                      validator: (input) => (input?.length ?? 0) < 3
                          ? "Please Enter Valid Voucher"
                          : null,
                      style: AppStyles.inputTextStyle(),
                      keyboardType: TextInputType.text,
                      // onSaved: (input) => loginRequestModel.email = input,
                      obscureText: false,
                      decoration: AppStyles.inputDecoration(
                          'Enter Voucher No.', Icons.wallet_giftcard),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ButtonFormSubmit(
                      text: 'Proceed',
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
