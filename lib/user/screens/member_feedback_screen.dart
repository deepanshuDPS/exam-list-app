import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:exam_list/containers/base_image_container.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/utils/preferences_data.dart';
import 'package:exam_list/widgets/btn_form_submit.dart';

import '../../network/http_utils.dart';
import '../../utils/constants.dart';

class MemberFeedbackScreen extends StatefulWidget {
  static const routeName = "/member-feedback";

  const MemberFeedbackScreen({Key? key}) : super(key: key);

  @override
  BaseState<MemberFeedbackScreen> createState() => _MemberFeedbackScreenState();
}

class _MemberFeedbackScreenState extends BaseState<MemberFeedbackScreen> {
  final _globalFormKey = GlobalKey<FormState>();

  // final _userNameController = TextEditingController();
  // final _emailController = TextEditingController();
  final _feedbackController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _imageFileList = [];
  String _memberId = '';
  double _rating = 3;

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      _memberId = ModalRoute.of(context)?.settings.arguments as String;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        titleText: "Feedback",
        isYellow: true,
        child: BaseImageContainer(
          opacity: 0.5,
          child: SingleChildScrollView(
            child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.white.withAlpha(210)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Center(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {
                            if (_imageFileList.length < 5) {
                              final List<XFile>? selectedImages =
                                  await _picker.pickMultiImage();
                              if (selectedImages?.isNotEmpty == true) {
                                for (var i = 0;
                                    i < (selectedImages?.length ?? 0);
                                    i++) {
                                  _imageFileList.add(selectedImages![i]);
                                  if (_imageFileList.length < 5) {
                                    continue;
                                  } else {
                                    break;
                                  }
                                }
                              }
                              setState(() {});
                            } else {
                              showSnackBar(
                                  context, 'Only select up to 5 images');
                            }
                          },
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(80)),
                              width: 150,
                              height: 150,
                              child: Icon(
                                Icons.camera_enhance,
                                color: Colors.grey[800],
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _imageFileList.isEmpty ? Container() : buildGridView(),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _globalFormKey,
                      child: Column(
                        children: <Widget>[
                          // TextFormField(
                          //   style: AppStyles.inputTextStyle(),
                          //   keyboardType: TextInputType.text,
                          //   controller: _userNameController,
                          //   onSaved: (input) => {
                          //     /* loginRequestModel.email = input */
                          //   },
                          //   validator: (input) => (input?.length ?? 0) < 3
                          //       ? "Please, Enter your Name"
                          //       : null,
                          //   decoration: AppStyles.inputDecoration(
                          //       "Enter Your Name", Icons.person),
                          // ),
                          // const SizedBox(height: 10),
                          // TextFormField(
                          //     style: AppStyles.inputTextStyle(),
                          //     controller: _emailController,
                          //     keyboardType: TextInputType.emailAddress,
                          //     onSaved: (input) => {
                          //           /*loginRequestModel.password = input*/
                          //         },
                          //     validator: (input) {
                          //       if ((input?.length ?? 0) < 3) {
                          //         return "Please Enter At least 3 chars in mail";
                          //       } else if (!RegExp(
                          //               r"^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$")
                          //           .hasMatch(input ?? "")) {
                          //         return "Please Enter Valid Email Id";
                          //       }
                          //       return null;
                          //     },
                          //     decoration: AppStyles.inputDecoration(
                          //         "Enter Your Email", Icons.email)),
                          // const SizedBox(height: 10),
                          TextFormField(
                            style: AppStyles.inputTextStyle(),
                            keyboardType: TextInputType.text,
                            enabled: false,
                            initialValue: _memberId,
                            decoration: AppStyles.inputDecoration(
                                "Membership Id", Icons.person_pin),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 120,
                            child: TextFormField(
                                expands: true,
                                textAlignVertical: TextAlignVertical.top,
                                style: AppStyles.inputTextStyle(),
                                controller: _feedbackController,
                                keyboardType: TextInputType.multiline,
                                minLines: null,
                                maxLines: null,
                                maxLength: 500,
                                onSaved: (input) => {
                                      /*loginRequestModel.password = input*/
                                    },
                                validator: (input) {
                                  if (input?.isEmpty ?? true) {
                                    return "Please Enter Feedback";
                                  } else if ((input?.trim().length ?? 0) < 20 ||
                                      (input?.length ?? 0) > 500) {
                                    return "Enter feedback within range 20-500 characters";
                                  }
                                },
                                decoration: AppStyles.inputDecoration(
                                    "Feedback", Icons.feedback,paddingVertical: 12),),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            unratedColor: Colors.amber.withAlpha(50),
                            itemCount: 5,
                            itemSize: 44.0,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                _rating = rating;
                              });
                            },
                            updateOnDrag: true,
                          ),
                          const SizedBox(height: 20),
                          ButtonFormSubmit(
                              onClick: () {
                                if (_globalFormKey.currentState?.validate() ==
                                    true) {
                                  _sendFeedback();
                                }
                              },
                              text: 'Submit'),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 5,
      shrinkWrap: true,
      children: List.generate(_imageFileList.length, (index) {
        //Asset asset = imageFileList[index].path;
        List<XFile> asset = _imageFileList;
        return Padding(
          padding: const EdgeInsets.all(2),
          child: CircleAvatar(
            radius: 55,
            backgroundColor: const Color(0xffFDCF09),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(50)),
              width: 70,
              height: 70,
              child: Image.file(
                File(asset[index].path),
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      }),
    );
  }

  void _sendFeedback() async {
    if (_imageFileList.isEmpty) {
      showSnackBar(context, 'Please select at-least one image for feedback');
    } else {
      showProgressDialog(context, loadingText: 'Sending Feedback...');
      try {
        // List<String> absolutePaths = [];
        // if (_imageFileList.isNotEmpty) {
        //   for (var asset in _imageFileList) {
        //     print(asset.path);
        //     final filePath =
        //         await LecleFlutterAbsolutePath.getAbsolutePath(uri: asset.path);
        //     if (asset.path != null) {
        //       absolutePaths.add(asset.path);
        //     }
        //   }
        // }
        var userData = (await PreferencesData.getUserData());
        FormData data = FormData.fromMap({
          'comment': _feedbackController.text.trim(),
          'stars': _rating.toString(),
        });
        for (var file in _imageFileList) {
          data.files.addAll([
            MapEntry(
                "files[]",
                await MultipartFile.fromFile(file.path,
                    filename: file.path.split('/').last))
          ]);
        }
        Dio dio = Dio();
        dio.options.contentType = 'application/json';
        dio.options.headers['Content-Type'] = 'application/json';
        dio.options.headers['phw-auth'] = Constants.apiKey;
        dio.options.headers['phw-user-token'] = userData?.id ?? 'N/A';

        var response =
            await dio.post('${Constants.baseURL}member/feedback', data: data);
        dynamic code = jsonDecode(response.toString())['code'];
        if (code == 200) {
          _feedbackController.clear();
          _imageFileList.clear();
          showSnackBar(context, 'Feedback submitted successfully');
          setState(() {});
        } else {
          var errorData =
              getErrorResponse(code, jsonDecode(response.toString()));
          showSnackBar(context, errorData['message']);
        }
      } catch (error) {
        dynamic _emptyError = {'message': '', 'status': -1};
        if (error is SocketException) {
          _emptyError = getErrorResponse(1, _emptyError);
        } else if (error is DioError) {
          _emptyError = getErrorResponse(
              (error).response?.statusCode ?? 0,
              jsonDecode((error).response?.toString() ??
                  "{'message':'Something Went Wrong'}"));
        } else {
          _emptyError = getErrorResponse(0, _emptyError);
        }
        showSnackBar(context, _emptyError['message']);
      } finally {
        Navigator.of(context).pop();
      }
    }
  }
}
