import 'package:exam_list/controllers/auth_user_controller.dart';
import 'package:exam_list/controllers/info_controller.dart';
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
import 'package:exam_list/exams/screens/exam_screen.dart';
import 'package:exam_list/user/screens/notification_listing_screen.dart';
import 'package:exam_list/utils/colors.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

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
  Hive.init((await getApplicationDocumentsDirectory()).path);
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
    return GetMaterialApp(
        title: 'ExamU',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'OpenSans',
            colorScheme: const ColorScheme.light()
                .copyWith(secondary: appRed, secondaryContainer: appDarkBlue)),
        onInit: () {
          Get.put<AuthUserController>(
            AuthUserController(),
            permanent: true,
          );
          Get.put<InfoController>(
            InfoController(),
            permanent: true,
          );
        },
        getPages: [
          GetPage(name: '/', page: () => const LaunchScreen()),
          GetPage(name: HomeScreen.routeName, page: () => const HomeScreen()),
          GetPage(name: ExamScreen.routeName, page: () => const ExamScreen()),
          GetPage(
              name: UserLoginScreen.routeName, page: () => UserLoginScreen()),
          GetPage(
              name: UserEditProfileScreen.routeName,
              page: () => const UserEditProfileScreen()),
          GetPage(
              name: UserOnBoardingScreen.routeName,
              page: () => const UserOnBoardingScreen()),
          GetPage(
              name: NotificationListingScreen.routeName,
              page: () => const NotificationListingScreen()),
          GetPage(
              name: TermsConditionsScreen.routeName,
              page: () => const TermsConditionsScreen()),
        ]);
  }
}
