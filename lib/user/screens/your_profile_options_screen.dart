import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/user/screens/change_password_screen.dart';
import 'package:exam_list/user/screens/user_onboarding_screen.dart';
import 'package:exam_list/user/screens/member_feedback_screen.dart';
import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/styles/app_styles.dart';
import 'package:exam_list/utils/preferences_data.dart';
import 'package:exam_list/widgets/illustration_svg.dart';
import 'package:provider/provider.dart';

class YourProfileOptionsScreen extends StatelessWidget {
  static const routeName = "/member-account";

  const YourProfileOptionsScreen({Key? key}) : super(key: key);

  Widget _horizontalOption(String text, Function onClick) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 14),
        width: double.infinity,
        child: Text(
          text,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      onTap: () => onClick(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      titleText: 'Your Profile',
        isBackRequired: false,
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const IllustrationSVG(
                  image: 'assets/svg/ill_aspirant_account.svg'),
              const SizedBox(
                height: 24,
              ),
              _horizontalOption(
                  'Edit Profile',
                  () => Navigator.of(context)
                      .pushNamed(UserOnBoardingScreen.routeName)),
              _horizontalOption(
                  'Notifications',
                  () => Navigator.of(context)
                      .pushNamed(ChangePasswordScreen.routeName)),
              _horizontalOption('My Requests', () async {
                Navigator.of(context).pushNamed(MemberFeedbackScreen.routeName,
                    arguments: (await PreferencesData.getUserData())?.id);
              }),
              const Divider(
                height: 1,
                color: Colors.black,
                indent: 24,
                endIndent: 24,
              ),
              _horizontalOption('Logout', () {
                Provider.of<UserProvider>(context, listen: false).logoutUser();
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/");
              }),
            ],
          ),
        ));
  }
}
