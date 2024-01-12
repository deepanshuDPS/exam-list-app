import 'package:exam_list/controllers/auth_user_controller.dart';
import 'package:exam_list/home/screens/home_screen.dart';
import 'package:exam_list/utils/constants.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/widgets/btn_form_submit.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:get/get.dart';

class UserOnBoardingScreen extends GetWidget<AuthUserController> {
  static const routeName = "/user-on-boarding-screen";

  // String name = '';
  // DateTime? selectedDate;

  // bool isDiffAble = false;
  // Map<String, dynamic>? chosenCategory;
  // Map<String, dynamic>? chosenCategoryDisabled;
  // Map<String, dynamic>? chosenQualification;
  // Map<String, dynamic>? chosenQualificationAdd;
  // int? gender;

  final _globalFormKey = GlobalKey<FormState>();

  UserOnBoardingScreen({Key? key}) : super(key: key);

  Widget _buildFormField(String heading, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(heading,
            style: TextStyle(
                fontSize: 18 * 0.7,
                fontWeight: FontWeight.w600,
                color: Get.theme.colorScheme.secondary)),
        child,
      ],
    );
  }

  Map<String, dynamic> _map(dynamic data) {
    if (data == null) return {};
    return data as Map<String, dynamic>;
  }

  bool _mapInt(dynamic data) {
    if (data == null) return false;
    return data as bool;
  }

  Widget _getSelectedDateText() {
    DateTime selectedDate =
        controller.onBoardingData['selectedDate'] ?? DateTime.now();
    return Text(
      controller.onBoardingData['selectedDate'] == null
          ? 'Select date'
          : '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
      style: _textStyle().copyWith(color: Colors.blueGrey),
    );
  }

  @override
  Widget build(BuildContext context) {
    var contactNumber = controller.user?.mobile ?? "";
    printDebug(contactNumber);

    return BaseScaffold(
      isAppBarColored: false,
      titleText: 'Set up Profile',
      child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Personal Information',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Form(
                        key: _globalFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            _buildFormField(
                                'Name*',
                                TextFormField(
                                  decoration: _inputDecoration('Enter Name'),
                                  onChanged: (value) {
                                    controller.onBoardingData['name'] = value;
                                  },
                                  style: _textStyle(),
                                  validator: (input) => (input?.length ?? 0) < 3
                                      ? "Please Enter Valid Name"
                                      : null,
                                )),
                            const SizedBox(height: 12),
                            _buildFormField(
                                'Mobile No.*',
                                TextFormField(
                                  initialValue: contactNumber,
                                  decoration: _inputDecoration('Mobile No.'),
                                  enabled: false,
                                  style: _textStyle(),
                                )),
                            const SizedBox(height: 12),
                            _buildFormField(
                                'Date of Birth*',
                                InkWell(
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now().subtract(
                                          const Duration(days: 14 * 365)),
                                      firstDate: DateTime.now().subtract(
                                          const Duration(days: 50 * 365)),
                                      lastDate: DateTime.now().subtract(
                                          const Duration(days: 14 * 365)),
                                    );
                                    if (pickedDate != null) {
                                      controller
                                              .onBoardingData['selectedDate'] =
                                          pickedDate;
                                    }
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: _getSelectedDateText(),
                                  ),
                                )),
                            const SizedBox(height: 12),
                            _buildFormField(
                                'Category*',
                                DropdownButtonFormField<String>(
                                  value: _map(controller.onBoardingData[
                                      'category'])['optionName'],
                                  onChanged: (value) {
                                    controller.onBoardingData['category'] = {
                                      'optionName': value,
                                      'optionId':
                                          Constants.reservationCategories[value]
                                    };
                                  },
                                  validator: (input) =>
                                      controller.onBoardingData['category'] ==
                                              null
                                          ? "Please Enter Valid Category"
                                          : null,
                                  items: Constants.reservationCategories.keys
                                      .map((category) {
                                    return DropdownMenuItem<String>(
                                      value: category,
                                      child: Text(
                                        category,
                                        style: _textStyle(),
                                      ),
                                    );
                                  }).toList(),
                                  decoration: _inputDecoration('Select Option'),
                                )),
                            const SizedBox(height: 12),
                            _buildFormField(
                                'Differently Able?',
                                Row(
                                  children: [
                                    Radio<bool>(
                                      value: true,
                                      groupValue: controller
                                                  .onBoardingData['isDiffAble'] ==
                                              true
                                          ? true
                                          : null,
                                      onChanged: (value) {
                                        controller.onBoardingData['isDiffAble'] =
                                            true;
                                      },
                                    ),
                                    const Text('Yes'),
                                    Radio<bool>(
                                      value: false,
                                      groupValue: controller
                                                  .onBoardingData['isDiffAble'] ==
                                              false
                                          ? false
                                          : null,
                                      onChanged: (value) {
                                        controller.onBoardingData['isDiffAble'] =
                                            false;
                                      },
                                    ),
                                    const Text('No'),
                                  ],
                                )),
                            const SizedBox(height: 12),
                            if (_mapInt(controller.onBoardingData['isDiffAble']))
                              _buildFormField(
                                  'Differently Able Category',
                                  DropdownButtonFormField<String>(
                                    value: _map(controller.onBoardingData[
                                                'diffAbleCategory'])[
                                            'optionName'] ??
                                        "None",
                                    onChanged: (value) {
                                      if (value == "None") {
                                        controller.onBoardingData[
                                            'diffAbleCategory'] = null;
                                      } else {
                                        controller.onBoardingData[
                                            'diffAbleCategory'] = {
                                          'optionName': value,
                                          'optionId': Constants
                                              .disabilityCategories[value]
                                        };
                                      }
                                    },
                                    items: Constants.disabilityCategories.keys
                                        .map((category) {
                                      return DropdownMenuItem<String>(
                                        value: category,
                                        child: Text(
                                          category,
                                          style: _textStyle(),
                                        ),
                                      );
                                    }).toList(),
                                    decoration:
                                        _inputDecoration('Select Option'),
                                  )),
                            if (_mapInt(controller.onBoardingData['isDiffAble']))
                              const SizedBox(height: 12),
                            _buildFormField(
                                'Qualification*',
                                DropdownButtonFormField<String>(
                                  value: _map(controller.onBoardingData[
                                      'eduQualification'])['optionName'],
                                  onChanged: (value) {
                                    controller
                                        .onBoardingData['eduQualification'] = {
                                      'optionName': value,
                                      'optionId': Constants
                                          .educationalQualifications[value]
                                    };
                                  },
                                  items: Constants
                                      .educationalQualifications.keys
                                      .map((qualification) {
                                    return DropdownMenuItem<String>(
                                      value: qualification,
                                      child: Text(
                                        qualification,
                                        style: _textStyle(),
                                      ),
                                    );
                                  }).toList(),
                                  decoration:
                                      _inputDecoration('Choose Qualification'),
                                )),
                            const SizedBox(height: 12),
                            _buildFormField(
                                'Additional Qualification',
                                DropdownButtonFormField<String>(
                                  value: _map(controller.onBoardingData[
                                          'addQualification'])['optionName'] ??
                                      "None",
                                  onChanged: (value) {
                                    if (value == "None") {
                                      controller.onBoardingData[
                                          'addQualification'] = null;
                                    } else {
                                      controller.onBoardingData[
                                          'addQualification'] = {
                                        'optionName': value,
                                        'optionId': Constants
                                            .additionalQualifications[value]
                                      };
                                    }
                                  },
                                  items: Constants.additionalQualifications.keys
                                      .map((qualification) {
                                    return DropdownMenuItem<String>(
                                      value: qualification,
                                      child: Text(
                                        qualification,
                                        style: _textStyle(),
                                      ),
                                    );
                                  }).toList(),
                                  decoration: _inputDecoration(
                                      'Choose Additional Qualification'),
                                )),
                            const SizedBox(height: 12),
                            _buildFormField(
                                'Gender*',
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Male',
                                      groupValue:
                                          controller.onBoardingData['gender'] ==
                                                  1
                                              ? 'Male'
                                              : null,
                                      onChanged: (value) {
                                        controller.onBoardingData['gender'] = 1;
                                      },
                                    ),
                                    const Text('Male'),
                                    Radio<String>(
                                      value: 'Female',
                                      groupValue:
                                          controller.onBoardingData['gender'] ==
                                                  2
                                              ? 'Female'
                                              : null,
                                      onChanged: (value) {
                                        controller.onBoardingData['gender'] = 2;
                                      },
                                    ),
                                    const Text('Female'),
                                    Radio<String>(
                                      value: 'Other',
                                      groupValue:
                                          controller.onBoardingData['gender'] ==
                                                  0
                                              ? 'Other'
                                              : null,
                                      onChanged: (value) {
                                        controller.onBoardingData['gender'] = 0;
                                      },
                                    ),
                                    const Text('Other'),
                                  ],
                                )),
                            const SizedBox(height: 16),
                            ButtonFormSubmit(
                                onClick: () {
                                  if (_globalFormKey.currentState?.validate() ==
                                      true) _signUpAspirant();
                                },
                                text: 'Continue')
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ))),
    );
  }

  // UserProvider get userProvider {
  //   // Initialize the property only when accessed for the first time
  //   return Provider.of<UserProvider>(context, listen: false);
  // }

  void _signUpAspirant() {
    if (controller.onBoardingData['selectedDate'] == null) {
      showGetSnackBar('Select Date of Birth');
    } else if (controller.onBoardingData['category'] == null) {
      showGetSnackBar('Choose Reservation Category');
      return;
    } else if (controller.onBoardingData['eduQualification'] == null) {
      showGetSnackBar('Choose Qualification');
      return;
    } else if (controller.onBoardingData['gender'] == null) {
      showGetSnackBar('Choose Gender');
      return;
    }
    controller.onBoardingData['dob'] =
        (controller.onBoardingData['selectedDate'] as DateTime)
            .toIso8601String();
    controller.onBoardingData['accountType'] = 1;
    showGetProgressDialog();
    controller.signUpAspirant().then((value) {
      Get.back();
      if (value is String) {
        showGetSnackBar(value);
      } else {
        // successfully login toast
        // check on boarding and change screen
        if (value == true) {
          Get.offAllNamed(HomeScreen.routeName);
        } else {
          showGetSnackBar('Something went Wrong');
        }
      }
    });
  }

  InputDecoration _inputDecoration(String text) {
    return InputDecoration(
      hintText: text,
      // Your hint text
      enabledBorder: const UnderlineInputBorder(
        // Enable underline when not focused
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: const UnderlineInputBorder(
        // Enable underline when focused
        borderSide: BorderSide(color: Colors.blue),
      ),
      errorBorder: const UnderlineInputBorder(
        // Customize underline on error if needed
        borderSide: BorderSide(color: Colors.red),
      ),
      // Remove underline on error
      disabledBorder: InputBorder.none,
    );
  }

  TextStyle _textStyle() {
    return const TextStyle(
        fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black);
  }
}
