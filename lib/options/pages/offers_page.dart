import 'package:flutter/material.dart';
import 'package:exam_list/options/screens/terms_conditions_screen.dart';
import 'package:exam_list/providers/home_provider.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/widgets/btn_form_submit.dart';
import 'package:provider/provider.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({Key? key}) : super(key: key);

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _location = TextEditingController();
  final _globalFormKey = GlobalKey<FormState>();
  bool _checkTC = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: UnconstrainedBox(
        constrainedAxis: Axis.horizontal,
        alignment: Alignment.topCenter,
        child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Colors.white.withAlpha(215)),
            child: Column(
              children: <Widget>[
                Form(
                    key: _globalFormKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Get In Touch For Best Offers',
                          style: AppStyles.robotoBold().copyWith(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _name,
                          style: AppStyles.inputTextStyle(),
                          keyboardType: TextInputType.name,
                          maxLength: 100,
                          // onSaved: (input) => loginRequestModel.email = input,
                          validator: (input) =>
                              (input?.length ?? 0) < 3 ? "Invalid Name" : null,
                          obscureText: false,
                          decoration:
                              AppStyles.inputDecoration('Name', Icons.person)
                                  .copyWith(counterText: ""),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          controller: _phone,
                          maxLength: 10,
                          style: AppStyles.inputTextStyle(),
                          keyboardType: TextInputType.phone,
                          // onSaved: (input) => loginRequestModel.email = input,
                          validator: (input) {
                            if ((input?.length ?? 0) < 10) {
                              return "Please Enter Valid Mobile No";
                            }
                          },
                          obscureText: false,
                          decoration: AppStyles.inputDecoration(
                                  'Mobile no.', Icons.phone_android)
                              .copyWith(counterText: ""),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          controller: _email,
                          style: AppStyles.inputTextStyle(),
                          keyboardType: TextInputType.emailAddress,
                          // onSaved: (input) => loginRequestModel.email = input,
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
                          obscureText: false,
                          decoration:
                              AppStyles.inputDecoration('Email Id', Icons.email),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          controller: _location,
                          style: AppStyles.inputTextStyle(),
                          keyboardType: TextInputType.text,
                          maxLength: 50,
                          // onSaved: (input) => loginRequestModel.email = input,
                          validator: (input) => (input?.length ?? 0) < 3
                              ? "Please Enter Your Location"
                              : null,
                          obscureText: false,
                          decoration: AppStyles.inputDecoration(
                                  'Location', Icons.pin_drop_rounded)
                              .copyWith(counterText: ""),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                child: const Text(
                                  "I Accept Terms & Conditions",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                onTap: () => {
                                  Navigator.of(context)
                                      .pushNamed(TermsConditionsScreen.routeName)
                                },
                              ),
                              Checkbox(
                                value: _checkTC,
                                activeColor: Theme.of(context)
                                    .colorScheme
                                    .secondaryVariant,
                                onChanged: (newValue) {
                                  setState(() {
                                    _checkTC = newValue!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  child: ButtonFormSubmit(
                      text: 'Submit',
                      onClick: () {
                        if (_globalFormKey.currentState?.validate() == true) {
                          if (_checkTC) {
                            _proceedToGetOffers();
                          } else {
                            showSnackBar(
                                context, 'Please check Terms & Conditions');
                          }
                        }
                      }),
                )
              ],
            )),
      ),
    );
  }

  void _proceedToGetOffers() {
    var requestBody = {
      "name": _name.text.trim(),
      "email": _email.text.trim(),
      "mobile": _phone.text.trim(),
      "location": _location.text.trim()
    };

    showProgressDialog(context);
    Provider.of<HomeProvider>(context, listen: false)
        .getOffers(requestBody)
        .then((value) {
      Navigator.of(context).pop();
      if (value is String) {
        for (var element in [_name, _email, _phone, _location]) {
          element.clear();
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
          makeSnackBar(value is String ? value : value['errorMessage']));
    });
  }
}
