import 'package:exam_list/user/screens/notification_listing_screen.dart';
import 'package:exam_list/user/screens/user_edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/widgets/illustration_svg.dart';
import 'package:provider/provider.dart';

class UserProfileOptionsScreen extends StatelessWidget {
  static const routeName = "/member-account";

  const UserProfileOptionsScreen({Key? key}) : super(key: key);

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
                      .pushNamed(UserEditProfileScreen.routeName)),
              _horizontalOption(
                  'Notifications',
                  () => Navigator.of(context)
                      .pushNamed(NotificationListingScreen.routeName)),
              /* _horizontalOption('My Requests', () async {
                Navigator.of(context).pushNamed(MemberFeedbackScreen.routeName,
                    arguments: (await PreferencesData.getUserData())?.id);
              }),*/
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
