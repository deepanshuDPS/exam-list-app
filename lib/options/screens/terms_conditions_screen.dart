import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_image_container.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/constants.dart';

class TermsConditionsScreen extends StatelessWidget {
  static String routeName = 'terms-conditions-screen';

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
          style: AppStyles.description().copyWith(
            fontSize: 14
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: BaseImageContainer(
        opacity: 0.7,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Colors.white.withAlpha(220)),
            child: Column(
              children: [
                _contentWiseTerms(Constants.termsConditionsTitles[0],
                    Constants.termsConditions[0]),
                const SizedBox(height: 8,),
                _contentWiseTerms(Constants.termsConditionsTitles[1],
                    Constants.termsConditions[1]),
                const SizedBox(height: 8,),
                _contentWiseTerms(Constants.termsConditionsTitles[2],
                    Constants.termsConditions[2]),
                const SizedBox(height: 8,),
                _contentWiseTerms(Constants.termsConditionsTitles[3],
                    Constants.termsConditions[3]),
                const SizedBox(height: 8,),
                _contentWiseTerms(Constants.termsConditionsTitles[4],
                    Constants.termsConditions[4]),
              ],
            ),
          ),
        ),
      ),
      isAppBarColored: true,
      titleText: 'Terms & Conditions',
    );
  }
}
