import 'package:exam_list/containers/base_state.dart';
import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/responseModels/user/terms_policy_response.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_image_container.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:provider/provider.dart';

class TermsConditionsScreen extends StatefulWidget {
  static String routeName = 'terms-conditions-screen';

  const TermsConditionsScreen({Key? key}) : super(key: key);

  @override
  BaseState<TermsConditionsScreen> createState() =>
      _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends BaseState<TermsConditionsScreen> {
  bool _isShowTerms = false;

  final List<String> _titles = [];
  final List<String> _information = [];
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      _isShowTerms =
          (ModalRoute.of(context)?.settings.arguments ?? 0) as int == 0;
      Provider.of<UserProvider>(context, listen: false)
          .getTermsPolicy()
          .then((value) {
        if (value is String) {
          setState(() {
            _isLoading = false;
          });
          showSnackBar(context, value);
        } else {
          setState(() {
            value as Data;
            _isLoading = false;
            if (_isShowTerms) {
              _titles.addAll(value.termsTitles ?? []);
              _information.addAll(value.termsConditions ?? []);
            } else {
              _titles.addAll(value.policyTitles ?? []);
              _information.addAll(value.privacyPolicy ?? []);
            }
          });
        }
      });
    }
    super.didChangeDependencies();
  }

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
    return BaseScaffold(
      isAppBarColored: true,
      titleText: _isShowTerms ? 'Terms & Conditions' : 'Privacy Policy',
      child: BaseImageContainer(
        opacity: 0.7,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.white.withAlpha(220)),
                  child: Column(
                    children: [
                      ..._titles.map((e) {
                        return Column(children: [
                          _contentWiseTerms(
                              e, _information[_titles.indexOf(e)]),
                          const SizedBox(
                            height: 8,
                          )
                        ]);
                      })
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
