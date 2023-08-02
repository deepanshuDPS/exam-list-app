import 'package:exam_list/home/screens/home_screen.dart';
import 'package:exam_list/options/screens/splash_screen.dart';
import 'package:exam_list/user/screens/user_login_screen.dart';
import 'package:exam_list/user/screens/user_onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Provider.of<UserProvider>(context, listen: false).initializeApp(),
      builder: (context, snapshot) {
        // future is in progress
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        } else if (snapshot.hasError) {
          // Future returned an error, show an error message
          return Text('Error: ${snapshot.error}');
        } else {
          if (snapshot.data == 0) {
            return const UserLoginScreen();
          } else if (snapshot.data == 1) {
            return const UserOnBoardingScreen();
          } else {
            return const HomeScreen();
          }
        }
      },
    );
  }
}
