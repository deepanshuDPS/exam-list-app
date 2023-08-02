import 'package:exam_list/home/screens/home_screen.dart';
import 'package:exam_list/options/screens/launch_screen.dart';
import 'package:exam_list/user/screens/user_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:exam_list/home/screens/support_screen.dart';
import 'package:exam_list/user/screens/member_account_screen.dart';
import 'package:exam_list/user/screens/user_onboarding_screen.dart';
import 'package:exam_list/user/screens/member_feedback_screen.dart';
import 'package:exam_list/options/screens/payment_screen.dart';
import 'package:exam_list/options/screens/terms_conditions_screen.dart';
import 'package:exam_list/options/screens/voucher_screen.dart';
import 'package:exam_list/providers/download_provider.dart';
import 'package:exam_list/providers/home_provider.dart';
import 'package:exam_list/providers/resorts_provider.dart';
import 'package:exam_list/providers/search_provider.dart';
import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/resorts/screens/resort_screen.dart';
import 'package:exam_list/resorts/screens/resorts_listing_screen.dart';
import 'package:exam_list/search/search_screen.dart';
import 'package:exam_list/utils/colors.dart';
import 'package:provider/provider.dart';

import 'user/screens/change_password_screen.dart';
import 'user/screens/member_listing_screen.dart';
import 'user/screens/my_trips_screen.dart';
import 'options/screens/downloads_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> loadBeforeApp() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        ChangeNotifierProvider(create: (ctx) => HomeProvider()),
        ChangeNotifierProvider(create: (ctx) => SearchProvider()),
        ChangeNotifierProvider(create: (ctx) => ResortsProvider()),
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
            MemberAccountScreen.routeName: (ctx) => const MemberAccountScreen(),
            UserLoginScreen.routeName: (ctx) => const UserLoginScreen(),
            PaymentScreen.routeName: (ctx) => const PaymentScreen(),
            HomeScreen.routeName: (ctx) => const HomeScreen(),
            SearchScreen.routeName: (ctx) => const SearchScreen(),
            SupportScreen.routeName: (ctx) => const SupportScreen(),
            MemberFeedbackScreen.routeName: (ctx) =>
                const MemberFeedbackScreen(),
            ChangePasswordScreen.routeName: (ctx) =>
                const ChangePasswordScreen(),
            MyTripsScreen.routeName: (ctx) => const MyTripsScreen(),
            ResortsListingScreen.routeName: (ctx) =>
                const ResortsListingScreen(),
            ResortScreen.routeName: (ctx) => const ResortScreen(),
            VoucherScreen.routeName: (ctx) => const VoucherScreen(),
            UserOnBoardingScreen.routeName: (ctx) => const UserOnBoardingScreen(),
            MemberListingScreen.routeName: (ctx) => const MemberListingScreen(),
            TermsConditionsScreen.routeName: (ctx) => const TermsConditionsScreen(),
            DownloadsScreen.routeName: (ctx) => const DownloadsScreen(),
          }),
    );
  }
}
