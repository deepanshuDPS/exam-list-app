import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/widgets/btn_form_submit.dart';
import 'package:exam_list/widgets/illustration_svg.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = "/payment";

  const PaymentScreen({Key? key}) : super(key: key);

  @override
  BaseState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends BaseState<PaymentScreen> {
  final _globalFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _emailController = TextEditingController();
  final _amountController = TextEditingController();

  late Razorpay _razorpay;

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context)
        .showSnackBar(makeSnackBar(response.message ?? "Something went wrong"));
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context)
        .showSnackBar(makeSnackBar(response.paymentId ?? "Success"));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context)
        .showSnackBar(makeSnackBar(response.walletName ?? "..."));
  }

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      _razorpay = Razorpay();
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    }
    super.didChangeDependencies();
  }

  void _launchPayment() async {
    var options = {
      'key': 'rzp_live_FkKxyB4QJHBPCP',
      'amount': int.parse(_amountController.text.trim()) * 100,
      'name': 'The Pacific Holiday World',
      'description': '',
      'prefill': {
        'name': _nameController.text.trim(),
        'contact': _phoneNoController.text.trim(),
        'email': _emailController.text.trim()
      },
      'external': {'wallets': []}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      printDebug(e.toString());
    }
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
              const IllustrationSVG(image: 'assets/svg/ill_payments.svg'),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Payments',
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
                      keyboardType: TextInputType.name,
                      controller: _nameController,
                      onSaved: (input) => {
                        /* loginRequestModel.email = input */
                      },
                      validator: (input) =>
                          input?.isEmpty ?? true ? "Please Enter Name" : null,
                      decoration:
                          AppStyles.inputDecoration('Name', Icons.person),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: AppStyles.inputTextStyle(),
                      controller: _phoneNoController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      onSaved: (input) => {
                        /*loginRequestModel.password = input*/
                      },
                      validator: (input) {
                        if (input?.isEmpty ?? false) {
                          return "Please Enter a valid Number";
                        } else if ((input?.length ?? 0) < 10) {
                          return "Please Enter a valid Number";
                        } else {
                          return null;
                        }
                      },
                      decoration: AppStyles.inputDecoration(
                              'Phone No.', Icons.phone_android)
                          .copyWith(counterText: ""),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: AppStyles.inputTextStyle(),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      onSaved: (input) => {
                        /* loginRequestModel.email = input */
                      },
                      validator: (input) {
                        if ((input?.length ?? 0) < 3) {
                          return "Please Enter At least 3 chars in mail";
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$")
                            .hasMatch(input ?? "")) {
                          return "Please Enter Valid Email Id";
                        }
                        return null;
                      },
                      decoration:
                          AppStyles.inputDecoration('Email', Icons.email),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: AppStyles.inputTextStyle(),
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      onSaved: (input) => {
                        /*loginRequestModel.password = input*/
                      },
                      validator: (input) {
                        if (input?.isEmpty ?? false) {
                          return "Please Enter Amount";
                        } else if (int.parse(input ?? '0') < 100) {
                          return "Required Rs100 minimum";
                        } else {
                          return null;
                        }
                      },
                      decoration: AppStyles.inputDecoration(
                          'Amount', LineAwesomeIcons.indian_rupee_sign),
                    ),
                    const SizedBox(height: 24),
                    ButtonFormSubmit(
                        onClick: () {
                          if (_globalFormKey.currentState?.validate() == true) {
                            _launchPayment();
                          }
                        },
                        text: 'Pay Now'),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          )),
    ));
  }
}
