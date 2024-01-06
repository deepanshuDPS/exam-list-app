import 'package:exam_list/controllers/info_controller.dart';
import 'package:exam_list/responseModels/user/terms_policy_response.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_image_container.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:get/get.dart';

class TermsConditionsScreen extends GetWidget<InfoController> {
  static String routeName = '/terms-conditions-screen';

  const TermsConditionsScreen({Key? key}) : super(key: key);

  Widget _contentWiseTerms(String title, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: AppStyles.robotoBlackText()
              .copyWith(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: AppStyles.description().copyWith(fontSize: 14),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.getTermsPolicy();
    var isShowTerms =
        (ModalRoute.of(context)?.settings.arguments ?? 0) as int == 0;
    controller.data.listen((value) {
      if (value != 0 && value is String) {
        showGetSnackBar(value);
      }
    });
    return BaseScaffold(
        isAppBarColored: true,
        titleText: isShowTerms ? 'Terms & Conditions' : 'Privacy Policy',
        child: BaseImageContainer(
            opacity: 0.7,
            child: Obx(
              () {
                var titles = [];
                var information = [];
                if (controller.data.value != 0 &&
                    controller.data.value is Data) {
                  var data = controller.data.value as Data;
                  titles =
                      (isShowTerms ? data.termsTitles : data.policyTitles) ??
                          [];
                  information = (isShowTerms
                          ? data.termsConditions
                          : data.privacyPolicy) ??
                      [];
                }
                if (controller.isProgress.isTrue) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 20),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: Colors.white.withAlpha(220)),
                      child: Column(
                        children: [
                          ...titles.map((e) {
                            return Column(children: [
                              _contentWiseTerms(
                                  e, information[titles.indexOf(e)]),
                              const SizedBox(
                                height: 8,
                              )
                            ]);
                          })
                        ],
                      ),
                    ),
                  );
                }
              },
            )));
  }
}
