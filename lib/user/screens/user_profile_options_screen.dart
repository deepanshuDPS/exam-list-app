import 'package:exam_list/controllers/auth_user_controller.dart';
import 'package:exam_list/options/screens/terms_conditions_screen.dart';
import 'package:exam_list/user/screens/user_edit_profile_screen.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_scaffold.dart';
import 'package:exam_list/widgets/illustration_svg.dart';
import 'package:get/get.dart';

import 'notification_listing_screen.dart';

class UserProfileOptionsScreen extends GetWidget<AuthUserController> {

  final Function onRefresh;

  const UserProfileOptionsScreen({Key? key, required this.onRefresh}) : super(key: key);

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
        action: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: IconButton(
            icon: const Icon(
              Icons.notifications_active_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Get.toNamed(NotificationListingScreen.routeName);
            },
          ),
        ),
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
              _horizontalOption('Edit Profile', () async {
                var result = await Get.toNamed(UserEditProfileScreen.routeName);
                if (result != null) {
                  onRefresh();
                }
              }),
              _horizontalOption(
                  'Terms & Conditions',
                  () => Get.toNamed(
                      TermsConditionsScreen.routeName,
                      arguments: 0)),
              _horizontalOption(
                  'Privacy Policy',
                  () => Get.toNamed(
                      TermsConditionsScreen.routeName,
                      arguments: 1)),
              const Divider(
                height: 1,
                color: Colors.black,
                indent: 24,
                endIndent: 24,
              ),
              _horizontalOption('Logout', () {
                showGetProgressDialog();
                controller.logoutUser()
                    .then((value) {
                  Get.offAllNamed("/");
                }).onError((error, stackTrace) {
                  Get.offAllNamed("/");
                });
              }),
            ],
          ),
        ));
  }
}
