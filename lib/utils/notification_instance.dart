import 'dart:math';
import 'dart:convert';

import 'package:exam_list/models/NotificationData.dart';
import 'package:exam_list/utils/extras_utils.dart';
import 'package:exam_list/utils/preferences_data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationInstance {
  FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;
  static NotificationInstance? _notificationInstance;

  NotificationInstance._();

  static NotificationInstance? instance() {
    if (_notificationInstance == null) {
      _notificationInstance ??= NotificationInstance._();
      _notificationInstance?._flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('drawable/ic_notification');
      _notificationInstance?._flutterLocalNotificationsPlugin?.initialize(
          const InitializationSettings(android: initializationSettingsAndroid));
    }
    return _notificationInstance;
  }

  void onNotificationMessage(RemoteMessage message) {
    printDebug('Message data: ${message.data}');
    if (message.notification != null) {
      PreferencesData.setCurrentVersion();
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'exam_notifications',
        'Exam Notifications',
        styleInformation: BigTextStyleInformation(''),
      );
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      // user based notifications
      var notData = NotificationData.fromJson(jsonDecode(message.data['data'].toString()));
      String id = (notData.id ?? "_id");
      int notificationIdBySum = 0;
      for (int i = 0; i < id.length; i++) {
        notificationIdBySum += id.codeUnitAt(i);
      }
      if (notData.notificationType != null) {
        PreferencesData.getUserData().then((user) {
          if (user != null) {
            _flutterLocalNotificationsPlugin?.show(
              notificationIdBySum, // Notification ID
              message.notification?.title ??
                  'Hey, aspirant Something new for you',
              message.notification?.body ??
                  'Please, be updated with the latest news',
              platformChannelSpecifics,
            );
          } else {
            _flutterLocalNotificationsPlugin?.show(
              notificationIdBySum, // Notification ID
              'You are missing some updates',
              'Please login to see the latest updates',
              platformChannelSpecifics,
            );
          }
        });
      } else {
        _flutterLocalNotificationsPlugin?.show(
          Random().nextInt(12345), // Notification ID
          message.notification?.title ?? 'Hey, aspirant Something new for you',
          message.notification?.body ??
              'Please, be updated with the latest news',
          platformChannelSpecifics,
        );
      }
    }
    else{
      printDebug('In else');
    }
  }
}
