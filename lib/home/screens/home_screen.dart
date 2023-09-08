import 'package:exam_list/providers/user_provider.dart';
import 'package:exam_list/user/screens/exam_listing_screen.dart';
import 'package:exam_list/user/screens/your_profile_options_screen.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/widgets/container_error.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:exam_list/containers/base_state.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  BaseState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> {
  final screens = [
    const ExamListingScreen(),
    // const ExamListingScreen(),
    // const ResourcesScreen(),
    const YourProfileOptionsScreen()
  ];

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(android: initializationSettingsAndroid));
  }

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      Provider.of<UserProvider>(context, listen: false).getAspirantUser();
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        printDebug('Got a message whilst in the foreground!');
        printDebug('Message data: ${message.data}');
        if (message.notification != null) {
          printDebug(
              'Message also contained a notification: ${message.notification}');
          const AndroidNotificationDetails androidPlatformChannelSpecifics =
              AndroidNotificationDetails(
            'exam_notifications',
            'Exam Notifications',
          );

          const NotificationDetails platformChannelSpecifics =
              NotificationDetails(android: androidPlatformChannelSpecifics);

          flutterLocalNotificationsPlugin.show(
            0, // Notification ID
            'Notification Title',
            'Notification Body',
            platformChannelSpecifics,
          );
        }
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        child: Container(
          color: Colors.white,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
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
            bottomNavigationBar: _buildBottomNavigationBar(),
            body: _getPage(_selectedIndex),
          );
        });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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

  Widget _getPage(int index) {
    // Return your different content pages based on the selected index
    // Example: Return a Text widget for demonstration purposes
    return screens[index];
  }
}
