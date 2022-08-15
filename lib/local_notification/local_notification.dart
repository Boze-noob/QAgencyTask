import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async =>
      _notifications.show(id, title, body, await _notificationDetails());

  static Future _notificationDetails() async {
    //TODO fix this
    return const NotificationDetails(
      android: AndroidNotificationDetails('channel id', 'channel name',
          channelDescription: 'channel description', importance: Importance.max),
      iOS: IOSNotificationDetails(),
    );
  }
}
