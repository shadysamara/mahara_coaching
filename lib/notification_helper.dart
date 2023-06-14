import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotHelper {
  static NotHelper notHelper = NotHelper();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  configureNotification() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  onDidReceiveLocalNotification(int x, String? y, String? z, String? w) {}
  showNotification(String title, String body) {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('com.example.mahara_last', 'com.example.mahara_last',
            channelDescription: 'com.example.mahara_last',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    flutterLocalNotificationsPlugin.show(1, title, body, NotificationDetails(android: AndroidNotificationDetails(
                "com.example.mahara_last", "com.example.mahara_last")));
  }
}
