import 'package:exam_list/controllers/auth_user_controller.dart';
import 'package:exam_list/home/screens/home_screen.dart';
import 'package:exam_list/options/screens/splash_screen.dart';
import 'package:exam_list/user/screens/user_login_screen.dart';
import 'package:exam_list/user/screens/user_onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LaunchScreen extends GetWidget<AuthUserController> {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<AuthUserController>(
        initState: (_) {
          controller.initializeApp();
        },
        builder: (_) {
          if (_.checkState.value == AuthUserController.waiting) {
            return const SplashScreen();
          } else if (_.checkState.value == AuthUserController.error) {
            return const Text('Something Went Wrong');
          } else {
            if (_.checkState.value == 0) {
              return UserLoginScreen();
            } else if (_.checkState.value == 1) {
              return UserOnBoardingScreen();
            } else {
              return HomeScreen();
            }
          }
        });
  }
}
