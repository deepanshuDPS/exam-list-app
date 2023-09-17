import 'dart:math';

import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/exams/screens/exam_listing_screen.dart';
import 'package:exam_list/user/screens/user_profile_options_screen.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/utils/preferences_data.dart';
import 'package:exam_list/widgets/container_error.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  BaseState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late TabController _tabController; // Manages the tab index
  List<Widget> tabScreens = const [
    ExamListingScreen(),
    // const ExamListingScreen(),
    // const ResourcesScreen(),
    UserProfileOptionsScreen()
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: tabScreens.length,
        vsync: this,
        animationDuration: Duration.zero);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('drawable/ic_launcher');
    flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(android: initializationSettingsAndroid));
  }

  Future<PermissionStatus> requestNotificationPermissions() async {
    final PermissionStatus status = await Permission.notification.request();
    return status;
  }

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      requestNotificationPermissions().then((status) async {
        if (status.isGranted) {
          // showSnackBar(context, "Permission Granted");
        } else if (status.isDenied) {
          showSnackBar(context, "Permission Denied for Notifications");
        } else if (status.isPermanentlyDenied) {
          showSnackBar(
              context, "Permission Denied Permanently for Notifications");
          // await openAppSettings();
        }
      });
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.getAspirantUser();
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        printDebug('Got a message whilst in the foreground!');
        printDebug('Message data: ${message.data}');
        if (message.notification != null) {
          printDebug(
              'Message also contained a notification: ${message.notification}');
          PreferencesData.setCurrentVersion();
          const AndroidNotificationDetails androidPlatformChannelSpecifics =
              AndroidNotificationDetails(
            'exam_notifications',
            'Exam Notifications',
            styleInformation: BigTextStyleInformation(''),
          );
          const NotificationDetails platformChannelSpecifics =
              NotificationDetails(android: androidPlatformChannelSpecifics);
          flutterLocalNotificationsPlugin.show(
            Random().nextInt(12345), // Notification ID
            message.notification?.title ??
                'Hey, aspirant Something new for you',
            message.notification?.body ??
                'Please, be updated with the latest news',
            platformChannelSpecifics,
          );
        }
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Consumer<UserProvider>(
          child: const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context, user, ch) {
            if (user.aspirantRequestData.isLoading) {
              return ch!;
            }

            if (user.aspirantRequestData.isError) {
              return ContainerError(
                  jsonData: user.aspirantRequestData.data,
                  onTryAgain: () => user.getAspirantUser());
            }

            return Scaffold(
              backgroundColor: Colors.transparent,
              bottomNavigationBar: _buildBottomNavigationBar(),
              body: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: tabScreens,
              ),
            );
          }),
    );
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _tabController.index = index;
    });
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: _buildNavItemIcon(Icons.home, _selectedIndex == 0),
              label: '',
            ),
            // BottomNavigationBarItem(
            //   icon: _buildNavItemIcon(Icons.location_on, _selectedIndex == 1),
            //   label: '',
            // ),
            // BottomNavigationBarItem(
            //   icon: _buildNavItemIcon(Icons.menu_book, _selectedIndex == 2),
            //   label: '',
            // ),
            BottomNavigationBarItem(
              icon: _buildNavItemIcon(Icons.person, _selectedIndex == 1),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItemIcon(IconData iconData, bool isSelected) {
    return Container(
      padding:
          isSelected ? const EdgeInsets.all(7.0) : const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected
            ? Theme.of(context).colorScheme.secondary
            : Colors.transparent,
      ),
      child: Icon(
        iconData,
        color: isSelected ? Colors.white : Colors.grey,
        size: isSelected ? 26.0 : 24.0,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
