import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/widgets/btn_form_submit.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/providers/user_provider.dart';
import 'package:provider/provider.dart';

class UserOnBoardingScreen extends StatefulWidget {
  static const routeName = "/user-on-boarding-screen";

  const UserOnBoardingScreen({Key? key}) : super(key: key);

  @override
  BaseState<UserOnBoardingScreen> createState() => _UserOnBoardingScreenState();
}

class _UserOnBoardingScreenState extends BaseState<UserOnBoardingScreen> {
  String name = '';
  String contactNumber = ''; // You can set the actual contact number here
  DateTime? selectedDate;
  Map<String, dynamic>? chosenCategory;
  Map<String, dynamic>? chosenCategoryDisabled;
  Map<String, dynamic>? chosenQualification;
  int? gender;
  final _globalFormKey = GlobalKey<FormState>();

  // Categories for the category list
  Map<String, int> reservationCategories = {
    'General': 1,
    'OBC': 2,
    'SC': 3,
    'ST': 4,
    'EWS': 5,
  };

  Map<String, int> educationalQualifications = {
    'High School (10th Pass)': 1,
    'Intermediate (12th Pass)': 2,
    'Diploma': 3,
    'Bachelor\'s Degree (UG)': 4,
    'Master\'s Degree (PG)': 5,
    'Ph.D.': 6,
  };

  Map<String, int> disabilityCategories = {
    'OD-Orthopedic Disability': 1,
    'VI-Visual Impairment': 2,
    'HI-Hearing Impairment': 3,
    'LD-Learning Disability': 4,
    'MD-Multiple Disability': 5
  };

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      contactNumber = userProvider.userDetails?.mobile ?? "";
      printDebug(contactNumber);
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
                                    name = value;
                                  });
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
                              'Date of Birth',
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
                                  if (pickedDate != null &&
                                      pickedDate != selectedDate) {
                                    setState(() {
                                      selectedDate = pickedDate;
                                    });
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
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
                              'Category',
                              DropdownButtonFormField<String>(
                                value: chosenCategory?['optionName'],
                                onChanged: (value) {
                                  setState(() {
                                    chosenCategory = {
                                      'optionName': value,
                                      'id': reservationCategories[value]
                                    };
                                  });
                                },
                                validator: (input) => chosenCategory == null
                                    ? "Please Enter Valid Category"
                                    : null,
                                items:
                                    reservationCategories.keys.map((category) {
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
                              'Disabled Category (Only for differentially able)',
                              DropdownButtonFormField<String>(
                                value: chosenCategoryDisabled?['optionName'],
                                onChanged: (value) {
                                  setState(() {
                                    chosenCategory = {
                                      'optionName': value,
                                      'id': disabilityCategories[value]
                                    };
                                  });
                                },
                                items:
                                    disabilityCategories.keys.map((category) {
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
                              'Qualification',
                              DropdownButtonFormField<String>(
                                value: chosenQualification?['optionName'],
                                onChanged: (value) {
                                  setState(() {
                                    chosenQualification = {
                                      'optionName': value,
                                      'id': educationalQualifications[value]
                                    };
                                  });
                                },
                                items: educationalQualifications.keys
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
                              'Gender',
                              Row(
                                children: [
                                  Radio<String>(
                                    value: 'Male',
                                    groupValue: gender == 1 ? 'Male' : null,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = 1;
                                      });
                                    },
                                  ),
                                  const Text('Male'),
                                  Radio<String>(
                                    value: 'Female',
                                    groupValue: gender == 2 ? 'Female' : null,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = 2;
                                      });
                                    },
                                  ),
                                  const Text('Female'),
                                  Radio<String>(
                                    value: 'Other',
                                    groupValue: gender == 0 ? 'other' : null,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = 0;
                                      });
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
                  )
                ],
              ))),
    );
  }

  UserProvider get userProvider {
    // Initialize the property only when accessed for the first time
    return Provider.of<UserProvider>(context, listen: false);
  }

  void _signUpAspirant() {
    if (selectedDate == null) {
      showSnackBar(context, 'Select Date of Birth');
    } else if (chosenCategory == null) {
      showSnackBar(context, 'Choose Reservation Category');
      return;
    } else if (chosenQualification == null) {
      showSnackBar(context, 'Choose Qualification');
      return;
    } else if (gender == null) {
      showSnackBar(context, 'Choose Gender');
      return;
    }
    printDebug('here for signup');
    userProvider.signUpAspirant({
      'name': name,
      'dob': selectedDate?.toIso8601String(),
      'category': chosenCategory,
      'diffAbleCategory': chosenCategoryDisabled,
      'eduQualification': chosenQualification,
      'gender': gender,
      'accountType': 1
    }).then((value) {
      printDebug(value);
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
