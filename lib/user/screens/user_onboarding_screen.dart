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
  String contactNumber =
      '1234567890'; // You can set the actual contact number here
  DateTime? selectedDate;
  String? chosenCategory;
  String? chosenCategoryDisabled;
  String? chosenQualification;
  String? gender;

  // Categories for the category list
  List<String> categories = ['GN', 'SC/ST', 'OBC'];
  List<String> qualifications = ['Intermediate', 'UG', 'PG'];

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
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
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
                                    style: _textStyle(),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 12),
                          _buildFormField(
                              'Category',
                              DropdownButtonFormField<String>(
                                value: chosenCategory,
                                onChanged: (value) {
                                  setState(() {
                                    chosenCategory = value;
                                  });
                                },
                                validator: (input) => chosenCategory != null
                                    ? "Please Enter Valid Voucher"
                                    : null,
                                items: categories.map((category) {
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
                              'Disabled Category',
                              DropdownButtonFormField<String>(
                                value: chosenCategoryDisabled,
                                onChanged: null,
                                items: categories.map((category) {
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
                                value: chosenQualification,
                                onChanged: (value) {
                                  setState(() {
                                    chosenQualification = value;
                                  });
                                },
                                items: qualifications.map((qualification) {
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
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value;
                                      });
                                    },
                                  ),
                                  const Text('Male'),
                                  Radio<String>(
                                    value: 'Female',
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value;
                                      });
                                    },
                                  ),
                                  const Text('Female'),
                                  Radio<String>(
                                    value: 'Other',
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value;
                                      });
                                    },
                                  ),
                                  const Text('Other'),
                                ],
                              )),
                          const SizedBox(height: 16),
                          ButtonFormSubmit(onClick: () {
                            _signUpAspirant();
                          }, text: 'Continue')
                        ],
                      ),
                    ),
                  )
                ],
              ))),
    );
  }

  void _signUpAspirant() {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.signUpAspirant().then((value) {
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
