import 'dart:convert';
import 'dart:math';
import 'package:app/src/controllers/notification_manager/notification_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

var deviceToken;

class FirebaseMessageApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  @pragma('vm:entry-point')
  static Future<void> handleOnBackgroundMessage(RemoteMessage message) async {
    try {
      final data = message.data;

      final notification = RemoteNotification.fromMap(data);

      await NotificationHelper.simpleNotification(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        payload: jsonEncode(message.toMap()),
        // showImage: true,
      );
    } catch (e) {
      await NotificationHelper.simpleNotification(title: e.toString());
    }
  }

  void hanldeMessage(RemoteMessage? message) {
    if (message == null) {
      return;
    }
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await FirebaseMessaging.instance.getInitialMessage().then(hanldeMessage);
    await FirebaseMessaging.onMessageOpenedApp.listen(hanldeMessage);
    FirebaseMessaging.onBackgroundMessage(await handleOnBackgroundMessage);

    await FirebaseMessaging.onMessage.listen((message) async {
      final data = message.data;
      final notification = RemoteNotification.fromMap(data);
      try {
        if (data['schedule'] == 'true') {
          DateTime time =
              DateTime.fromMillisecondsSinceEpoch(int.parse(data['time']));
          NotificationHelper.scheduleNotification(
            id: Random().nextInt(20000),
            date: time,
            title: "Thông báo lịch hẹn",
            body: jsonEncode(message.toMap()),
            payload: jsonEncode(message.toMap()),
          );
        } else {
          await NotificationHelper.simpleNotification(
            id: notification.hashCode,
            title: notification.title,
            body: notification.body,
            payload: jsonEncode(message.toMap()),
            // showImage: true,
          );
        }
      } catch (e) {
        print(e);
      }
    });
  }

  //

  Future<void> initNotification() async {
    await NotificationHelper().initNotification();
    await _firebaseMessaging.requestPermission();
    await FirebaseMessaging.instance.subscribeToTopic("ALL");
    // deviceToken = await _firebaseMessaging.getToken();
    initPushNotification();
    // print(deviceToken);
  }
}
