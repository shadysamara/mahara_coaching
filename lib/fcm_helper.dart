import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mahara_last/notification_helper.dart';

class FcmHelper {
  static FcmHelper fcmHelper = FcmHelper();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  configureFcm() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    getUserToken();
    turnOnMessageingStream();
  }

  getUserToken() async {
    String? fcmToken = await messaging.getToken();
    log(fcmToken ?? "no fcm found");
    // upload the token to firebase or api
  }

  turnOnMessageingStream() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String title = message.notification?.title ?? "";
      String body = message.notification?.body ?? "";
      NotHelper.notHelper.showNotification(title, body);
      log("new message has been recived, the title is $title, and the body is $body");
    });
    //  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  }

  sendNotificationToUser(String fcmToken, String title, String body) {
    Dio dio = Dio();
    dio.post("https://fcm.googleapis.com/fcm/send",
        data: {
          "to": fcmToken,
          "notification": {"body": body, "title": title},
        },
        options: Options(headers: {"Authorization":"key=AAAACBU5N8w:APA91bGtEohlqWI9Rg0f-zUzz1uoVRhYOiZoV5b0tYSzIyIgdvP8ZSb9Ysq10xRVpkNQAPSHXoUqxoWEPqoKeS-CDaKM2wdcNWj7yw8fX1tNj6dVK3_Ew2chfp2rnsoRlJ4Q4a47qNY7"}));
  }
}
