import 'package:exam_list/responseModels/user/aspirant_data.dart';
import 'package:exam_list/utils/constants.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/widgets/btn_form_submit.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/providers/user_provider.dart';
import 'package:provider/provider.dart';

class UserEditProfileScreen extends StatefulWidget {
  static const routeName = "/user-edit-profile-screen";

  const UserEditProfileScreen({Key? key}) : super(key: key);

  @override
  BaseState<UserEditProfileScreen> createState() =>
      _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends BaseState<UserEditProfileScreen> {
  // String name = '';
  DateTime? selectedDate;

  // bool diffAble = false;
  // Map<String, dynamic>? chosenCategory;
  // Map<String, dynamic>? chosenCategoryDisabled;
  // Map<String, dynamic>? chosenQualification;
  // Map<String, dynamic>? chosenQualificationAdd;
  // int? gender;
  late AspirantData _aspirantDetailsData;
  final _globalFormKey = GlobalKey<FormState>();

  UserProvider _userProvider() {
    return Provider.of<UserProvider>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      _userProvider().getAspirantUser().then((value) {
        setState(() {
          _aspirantDetailsData = _userProvider().aspirantDetails!.copyWith();
          selectedDate = DateTime.parse(_aspirantDetailsData.dob ?? "");
        });
      });
    }
    super.didChangeDependencies();
  }

  Widget _buildFormField(String heading, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(heading,
            style: TextStyle(
                fontSize: 18 * 0.7,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.secondary)),
        child,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isAppBarColored: false,
      titleText: 'Edit Profile',
      isBackRequired: true,
      child: Consumer<UserProvider>(
        builder: (context, user, child) {
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
                                      setState(() {
                                        _aspirantDetailsData.setName(value);
                                        printDebug(_aspirantDetailsData.name
                                            .toString());
                                      });
                                    },
                                    initialValue: _aspirantDetailsData.name,
                                    style: _textStyle(),
                                    validator: (input) =>
                                        (input?.length ?? 0) < 3
                                            ? "Please Enter Valid Name"
                                            : null,
                                  )),
                              const SizedBox(height: 12),
                              _buildFormField(
                                  'Mobile No.*',
                                  TextFormField(
                                    initialValue: _aspirantDetailsData.mobile,
                                    decoration: _inputDecoration('Mobile No.'),
                                    enabled: false,
                                    style: _textStyle(),
                                  )),
                              const SizedBox(height: 12),
                              _buildFormField(
                                  'Date of Birth*',
                                  InkWell(
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate:
                                            selectedDate ?? DateTime.now(),
                                        firstDate: DateTime.now().subtract(
                                            const Duration(days: 50 * 365)),
                                        lastDate: DateTime.now().subtract(
                                            const Duration(days: 14 * 365)),
                                      );
                                      if (pickedDate != null &&
                                          pickedDate != selectedDate) {
                                        setState(() {
                                          selectedDate = pickedDate;
                                        });
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Text(
                                        selectedDate == null
                                            ? 'Select date'
                                            : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                                        style: _textStyle()
                                            .copyWith(color: Colors.blueGrey),
                                      ),
                                    ),
                                  )),
                              const SizedBox(height: 12),
                              _buildFormField(
                                  'Category*',
                                  DropdownButtonFormField<String>(
                                    value: _aspirantDetailsData
                                        .category?.optionName,
                                    onChanged: (value) {
                                      setState(() {
                                        _aspirantDetailsData.setCategory(
                                            Category(
                                                optionName: value!,
                                                optionId: Constants
                                                        .reservationCategories[
                                                    value]!));
                                      });
                                    },
                                    validator: (input) => _aspirantDetailsData
                                                .category?.optionName ==
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
                                    decoration:
                                        _inputDecoration('Select Option'),
                                  )),
                              const SizedBox(height: 12),
                              _buildFormField(
                                  'Differently Able?',
                                  Row(
                                    children: [
                                      Radio<bool>(
                                        value: true,
                                        groupValue:
                                            _aspirantDetailsData.isDiffAble ==
                                                true,
                                        onChanged: (value) {
                                          setState(() {
                                            _aspirantDetailsData
                                                .setDiffAble(true);
                                          });
                                        },
                                      ),
                                      const Text('Yes'),
                                      Radio<bool>(
                                        value: false,
                                        groupValue:
                                            _aspirantDetailsData.isDiffAble ==
                                                true,
                                        onChanged: (value) {
                                          setState(() {
                                            _aspirantDetailsData
                                                .setDiffAble(false);
                                          });
                                        },
                                      ),
                                      const Text('No'),
                                    ],
                                  )),
                              const SizedBox(height: 12),
                              if (_aspirantDetailsData.isDiffAble == true)
                                _buildFormField(
                                    'Differently Able Category',
                                    DropdownButtonFormField<String>(
                                      value: _aspirantDetailsData
                                              .diffAbleCategory?.optionName ??
                                          "None",
                                      onChanged: (value) {
                                        setState(() {
                                          if(value == "None"){
                                            _aspirantDetailsData.setDiffAbleCategory(null);
                                          }else{
                                            _aspirantDetailsData
                                                .setDiffAbleCategory(Category(
                                                optionName: value!,
                                                optionId: Constants
                                                    .disabilityCategories[
                                                value]!));
                                          }
                                        });
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
                              if (_aspirantDetailsData.isDiffAble == true)
                                const SizedBox(height: 12),
                              _buildFormField(
                                  'Qualification*',
                                  DropdownButtonFormField<String>(
                                    value: _aspirantDetailsData
                                        .eduQualification?.optionName,
                                    onChanged: (value) {
                                      setState(() {
                                        _aspirantDetailsData.setEduQualification(
                                            EduQualification(
                                                optionName: value!,
                                                optionId: Constants
                                                        .educationalQualifications[
                                                    value]!));
                                      });
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
                                    decoration: _inputDecoration(
                                        'Choose Qualification'),
                                  )),
                              const SizedBox(height: 12),
                              _buildFormField(
                                  'Additional Qualification',
                                  DropdownButtonFormField<String>(
                                    value: _aspirantDetailsData
                                            .addQualification?.optionName ??
                                        "None",
                                    onChanged: (value) {
                                      setState(() {
                                        if (value == "None") {
                                          _aspirantDetailsData
                                              .setAddQualification(null);
                                        } else {
                                          _aspirantDetailsData.setAddQualification(
                                              EduQualification(
                                                  optionName: value!,
                                                  optionId: Constants
                                                          .additionalQualifications[
                                                      value]!));
                                        }
                                      });
                                    },
                                    items: Constants
                                        .additionalQualifications.keys
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
                                            _aspirantDetailsData.gender == 1
                                                ? 'Male'
                                                : null,
                                        onChanged: (value) {
                                          setState(() {
                                            _aspirantDetailsData.setGender(1);
                                          });
                                        },
                                      ),
                                      const Text('Male'),
                                      Radio<String>(
                                        value: 'Female',
                                        groupValue:
                                            _aspirantDetailsData.gender == 2
                                                ? 'Female'
                                                : null,
                                        onChanged: (value) {
                                          setState(() {
                                            _aspirantDetailsData.setGender(2);
                                          });
                                        },
                                      ),
                                      const Text('Female'),
                                      Radio<String>(
                                        value: 'Other',
                                        groupValue:
                                            _aspirantDetailsData.gender == 0
                                                ? 'other'
                                                : null,
                                        onChanged: (value) {
                                          setState(() {
                                            _aspirantDetailsData.setGender(0);
                                          });
                                        },
                                      ),
                                      const Text('Other'),
                                    ],
                                  )),
                              const SizedBox(height: 16),
                              ButtonFormSubmit(
                                  onClick: () {
                                    if (_globalFormKey.currentState
                                            ?.validate() ==
                                        true) _editAspirant();
                                  },
                                  text: 'Edit Profile')
                            ],
                          ),
                        ),
                      )
                    ],
                  )));
        },
        child: Container(),
      ),
    );
  }

  UserProvider get userProvider {
    // Initialize the property only when accessed for the first time
    return Provider.of<UserProvider>(context, listen: false);
  }

  void _editAspirant() {
    if (selectedDate == null) {
      showSnackBar(context, 'Select Date of Birth');
    } else if (_aspirantDetailsData.category == null) {
      showSnackBar(context, 'Choose Reservation Category');
      return;
    } else if (_aspirantDetailsData.eduQualification == null) {
      showSnackBar(context, 'Choose Qualification');
      return;
    } else if (_aspirantDetailsData.gender == null) {
      showSnackBar(context, 'Choose Gender');
      return;
    }

    if(_aspirantDetailsData.isDiffAble == false) {
      _aspirantDetailsData.setDiffAbleCategory(null);
    }

    _aspirantDetailsData.setDob(selectedDate!.toIso8601String());
    showProgressDialog(context);
    userProvider
        .editAspirantProfile(_aspirantDetailsData.toJson())
        .then((value) {
      Navigator.of(context).pop();
      if (value is String) {
        showSnackBar(context, value);
      } else {
        // successfully login toast
        // check on boarding and change screen
        if (value == true) {
          Navigator.of(context).pop(true);
        } else {
          showSnackBar(context, 'Something went Wrong');
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
