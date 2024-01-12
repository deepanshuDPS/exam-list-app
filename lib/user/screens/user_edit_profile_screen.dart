import 'package:exam_list/controllers/aspirant_user_controller.dart';
import 'package:exam_list/responseModels/user/aspirant_data.dart';
import 'package:exam_list/utils/constants.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/widgets/btn_form_submit.dart';
import 'package:exam_list/widgets/container_loading.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:get/get.dart';

class UserEditProfileScreen extends GetWidget<AspirantUserController> {
  static const routeName = "/user-edit-profile-screen";

  UserEditProfileScreen({Key? key}) : super(key: key);

  // bool diffAble = false;
  // Map<String, dynamic>? chosenCategory;
  // Map<String, dynamic>? chosenCategoryDisabled;
  // Map<String, dynamic>? chosenQualification;
  // Map<String, dynamic>? chosenQualificationAdd;
  // int? gender;
  // AspirantData? _aspirantDetailsData;
  final _globalFormKey = GlobalKey<FormState>();

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

  Widget _getSelectedDateText() {
    DateTime selectedDate = controller.selectedDate.value ?? DateTime.now();
    return Text(
      controller.selectedDate.value == null
          ? 'Select date'
          : '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
      style: _textStyle().copyWith(color: Colors.blueGrey),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.getProfileDetails();
    return BaseScaffold(
      isAppBarColored: false,
      titleText: 'Edit Profile',
      isBackRequired: true,
      child: Obx(() {
        if (controller.editDetailsData.value == null) {
          return const ContainerLoading();
        }
        return SingleChildScrollView(
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
                    Padding(
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
                                    controller.editDetailsData.value
                                        ?.setName(value);
                                  },
                                  initialValue: controller.editDetails?.name,
                                  style: _textStyle(),
                                  validator: (input) => (input?.length ?? 0) < 3
                                      ? "Please Enter Valid Name"
                                      : null,
                                )),
                            const SizedBox(height: 12),
                            _buildFormField(
                                'Mobile No.*',
                                TextFormField(
                                  initialValue: controller.editDetails?.mobile,
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
                                      initialDate:
                                          controller.selectedDate.value ??
                                              DateTime.now(),
                                      firstDate: DateTime.now().subtract(
                                          const Duration(days: 50 * 365)),
                                      lastDate: DateTime.now().subtract(
                                          const Duration(days: 14 * 365)),
                                    );
                                    if (pickedDate != null &&
                                        pickedDate !=
                                            controller.selectedDate.value) {
                                      controller.selectedDate.value =
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
                                  value: controller
                                      .editDetails?.category?.optionName,
                                  onChanged: (value) {
                                    controller.editDetailsData.value
                                        ?.setCategory(Category(
                                            optionName: value!,
                                            optionId:
                                                Constants.reservationCategories[
                                                    value]!));
                                  },
                                  validator: (input) => controller.editDetails
                                              ?.category?.optionName ==
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
                                      groupValue:
                                          controller.editDetails?.isDiffAble ==
                                                  true
                                              ? true
                                              : null,
                                      onChanged: (value) {
                                        controller.editDetails
                                            ?.setDiffAble(true);
                                        controller.editDetailsData.value =
                                            controller.editDetails?.copyWith();
                                      },
                                    ),
                                    const Text('Yes'),
                                    Radio<bool>(
                                      value: false,
                                      groupValue:
                                          controller.editDetails?.isDiffAble ==
                                                  false
                                              ? false
                                              : null,
                                      onChanged: (value) {
                                        controller.editDetails
                                            ?.setDiffAble(false);
                                        controller.editDetailsData.value =
                                            controller.editDetails?.copyWith();
                                      },
                                    ),
                                    const Text('No'),
                                  ],
                                )),
                            const SizedBox(height: 12),
                            if (controller.editDetails?.isDiffAble == true)
                              _buildFormField(
                                  'Differently Able Category',
                                  DropdownButtonFormField<String>(
                                    value: controller.editDetails
                                            ?.diffAbleCategory?.optionName ??
                                        "None",
                                    onChanged: (value) {
                                      if (value == "None") {
                                        controller.editDetailsData.value
                                            ?.setDiffAbleCategory(null);
                                      } else {
                                        controller.editDetailsData.value
                                            ?.setDiffAbleCategory(Category(
                                                optionName: value!,
                                                optionId: Constants
                                                        .disabilityCategories[
                                                    value]!));
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
                            if (controller.editDetails?.isDiffAble == true)
                              const SizedBox(height: 12),
                            _buildFormField(
                                'Qualification*',
                                DropdownButtonFormField<String>(
                                  value: controller.editDetails
                                      ?.eduQualification?.optionName,
                                  onChanged: (value) {
                                    controller.editDetailsData.value
                                        ?.setEduQualification(EduQualification(
                                            optionName: value!,
                                            optionId: Constants
                                                    .educationalQualifications[
                                                value]!));
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
                                  value: controller.editDetails
                                          ?.addQualification?.optionName ??
                                      "None",
                                  onChanged: (value) {
                                    if (value == "None") {
                                      controller.editDetailsData.value
                                          ?.setAddQualification(null);
                                    } else {
                                      controller.editDetailsData.value
                                          ?.setAddQualification(EduQualification(
                                              optionName: value!,
                                              optionId: Constants
                                                      .additionalQualifications[
                                                  value]!));
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
                                          controller.editDetails?.gender == 1
                                              ? 'Male'
                                              : null,
                                      onChanged: (value) {
                                        controller.editDetails?.setGender(1);
                                        controller.editDetailsData.value =
                                            controller.editDetails?.copyWith();
                                      },
                                    ),
                                    const Text('Male'),
                                    Radio<String>(
                                      value: 'Female',
                                      groupValue:
                                          controller.editDetails?.gender == 2
                                              ? 'Female'
                                              : null,
                                      onChanged: (value) {
                                        controller.editDetails?.setGender(2);
                                        controller.editDetailsData.value =
                                            controller.editDetails?.copyWith();
                                      },
                                    ),
                                    const Text('Female'),
                                    Radio<String>(
                                      value: 'Other',
                                      groupValue:
                                          controller.editDetails?.gender == 0
                                              ? 'Other'
                                              : null,
                                      onChanged: (value) {
                                        controller.editDetails?.setGender(0);
                                        controller.editDetailsData.value =
                                            controller.editDetails?.copyWith();
                                      },
                                    ),
                                    const Text('Other'),
                                  ],
                                )),
                            const SizedBox(height: 16),
                            ButtonFormSubmit(
                                onClick: () {
                                  if (_globalFormKey.currentState?.validate() ==
                                      true) _editAspirant();
                                },
                                text: 'Save')
                          ],
                        ),
                      ),
                    )
                  ],
                )));
      }),
    );
  }

  void _editAspirant() {
    if (controller.selectedDate.value == null) {
      showGetSnackBar('Select Date of Birth');
    } else if (controller.editDetails?.category == null) {
      showGetSnackBar('Choose Reservation Category');
      return;
    } else if (controller.editDetails?.eduQualification == null) {
      showGetSnackBar('Choose Qualification');
      return;
    } else if (controller.editDetails?.gender == null) {
      showGetSnackBar('Choose Gender');
      return;
    }

    if (controller.editDetails?.isDiffAble == false) {
      controller.editDetails?.setDiffAbleCategory(null);
    }

    controller.editDetails
        ?.setDob(controller.selectedDate.value?.toIso8601String() ?? "");
    showGetProgressDialog();
    controller.editAspirantProfile().then((value) {
      Get.back();
      if (value is String) {
        showGetSnackBar(value);
      } else {
        // successfully login toast
        // check on boarding and change screen
        if (value == true) {
          Get.back(result: true);
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
