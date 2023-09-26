import 'package:exam_list/home/screens/home_screen.dart';
import 'package:exam_list/options/screens/launch_screen.dart';
import 'package:exam_list/user/screens/user_edit_profile_screen.dart';
import 'package:exam_list/user/screens/user_login_screen.dart';
import 'package:exam_list/utils/notification_instance.dart';
import 'package:exam_list/utils/preferences_data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:exam_list/user/screens/user_onboarding_screen.dart';
import 'package:exam_list/options/screens/terms_conditions_screen.dart';
import 'package:exam_list/providers/exam_provider.dart';
import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/exams/screens/exam_screen.dart';
import 'package:exam_list/user/screens/notification_listing_screen.dart';
import 'package:exam_list/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  NotificationInstance.instance()?.onNotificationMessage(message);
}

Future<void> loadBeforeApp() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await PreferencesData.checkFCMToken();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  loadBeforeApp().then((val) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ExamProvider()),
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
      ],
      child: MaterialApp(
          title: 'ExamU',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'OpenSans',
              colorScheme: const ColorScheme.light().copyWith(
                  secondary: appRed, secondaryContainer: appDarkBlue)),
          routes: {
            '/': (ctx) => const LaunchScreen(),
            UserLoginScreen.routeName: (ctx) => const UserLoginScreen(),
            UserEditProfileScreen.routeName: (ctx) =>
                const UserEditProfileScreen(),
            HomeScreen.routeName: (ctx) => const HomeScreen(),
            NotificationListingScreen.routeName: (ctx) =>
                const NotificationListingScreen(),
            ExamScreen.routeName: (ctx) => const ExamScreen(),
            UserOnBoardingScreen.routeName: (ctx) =>
                const UserOnBoardingScreen(),
            TermsConditionsScreen.routeName: (ctx) =>
                const TermsConditionsScreen(),
          }),
    );
  }
}
