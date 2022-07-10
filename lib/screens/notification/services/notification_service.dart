import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> backgroundMessage(RemoteMessage message) async {
  log("message received! ${message.notification!.title}");
}

class NotificationService {
  static Future<void> initializeNotification() async {
    NotificationSettings notificationSettings =
        await FirebaseMessaging.instance.requestPermission();
    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      String? token = await FirebaseMessaging.instance.getAPNSToken();
      if (token != null) {
        log(token);
      }
      FirebaseMessaging.onBackgroundMessage(backgroundMessage);
      log("Notifications Initialized!");
    }
  }
}
