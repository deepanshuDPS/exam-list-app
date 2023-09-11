import 'dart:math';

import 'package:exam_list/home/screens/home_screen.dart';
import 'package:exam_list/options/screens/launch_screen.dart';
import 'package:exam_list/user/screens/user_login_screen.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/utils/preferences_data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:exam_list/user/screens/your_profile_options_screen.dart';
import 'package:exam_list/user/screens/user_onboarding_screen.dart';
import 'package:exam_list/user/screens/member_feedback_screen.dart';
import 'package:exam_list/options/screens/payment_screen.dart';
import 'package:exam_list/options/screens/terms_conditions_screen.dart';
import 'package:exam_list/options/screens/voucher_screen.dart';
import 'package:exam_list/providers/download_provider.dart';
import 'package:exam_list/providers/exam_provider.dart';
import 'package:exam_list/providers/search_provider.dart';
import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/exams/screens/exam_screen.dart';
import 'package:exam_list/exams/screens/resorts_listing_screen.dart';
import 'package:exam_list/search/search_screen.dart';
import 'package:exam_list/utils/colors.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'user/screens/change_password_screen.dart';
import 'user/screens/exam_listing_screen.dart';
import 'user/screens/my_trips_screen.dart';
import 'options/screens/downloads_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  printDebug("Handling a background message: ${message.messageId}");
  // var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // await PreferencesData.setCurrentVersion();
  // const AndroidNotificationDetails androidPlatformChannelSpecifics =
  // AndroidNotificationDetails(
  //   'exam_notifications',
  //   'Exam Notifications',
  //   styleInformation: BigTextStyleInformation(''),
  // );
  // const NotificationDetails platformChannelSpecifics =
  // NotificationDetails(android: androidPlatformChannelSpecifics);
  // flutterLocalNotificationsPlugin.show(
  //   Random().nextInt(12345), // Notification ID
  //   message.notification?.title??'Hey, aspirant Something new for you',
  //   message.notification?.body?? 'Please, be updated with the latest news',
  //   platformChannelSpecifics,
  // );
}

Future<void> loadBeforeApp() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PreferencesData.checkFCMToken();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
        ChangeNotifierProvider(create: (ctx) => SearchProvider()),
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
        ChangeNotifierProvider(create: (ctx)=> DownloadProvider())
      ],
      child: MaterialApp(
          title: 'Exam List',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'OpenSans',
              colorScheme: const ColorScheme.light()
                  .copyWith(secondary: appRed, secondaryContainer: appDarkBlue)),
          routes: {
            '/': (ctx) => const LaunchScreen(),
            YourProfileOptionsScreen.routeName: (ctx) => const YourProfileOptionsScreen(),
            UserLoginScreen.routeName: (ctx) => const UserLoginScreen(),
            PaymentScreen.routeName: (ctx) => const PaymentScreen(),
            HomeScreen.routeName: (ctx) => const HomeScreen(),
            SearchScreen.routeName: (ctx) => const SearchScreen(),
            MemberFeedbackScreen.routeName: (ctx) =>
                const MemberFeedbackScreen(),
            ChangePasswordScreen.routeName: (ctx) =>
                const ChangePasswordScreen(),
            MyTripsScreen.routeName: (ctx) => const MyTripsScreen(),
            ResortsListingScreen.routeName: (ctx) =>
                const ResortsListingScreen(),
            ExamScreen.routeName: (ctx) => const ExamScreen(),
            VoucherScreen.routeName: (ctx) => const VoucherScreen(),
            UserOnBoardingScreen.routeName: (ctx) => const UserOnBoardingScreen(),
            ExamListingScreen.routeName: (ctx) => const ExamListingScreen(),
            TermsConditionsScreen.routeName: (ctx) => const TermsConditionsScreen(),
            DownloadsScreen.routeName: (ctx) => const DownloadsScreen(),
          }),
    );
  }
}
