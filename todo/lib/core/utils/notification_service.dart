
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:intl/intl.dart';

class NotificationService {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Random random = Random();

  Future<void> showNotification(String date,String title,String body) async {

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      "TODO232",
      "TODO",
      importance: Importance.max,
      priority: Priority.high,
    );
    DateFormat inputFormat = DateFormat('yyyy-M-dd HH:mm');
    DateTime dateTime = inputFormat.parse(date);
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      random.nextInt(100000) + 1, // notification id
      title,
      body,
      tz.TZDateTime.from(dateTime, tz.local),// scheduled date and time
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }


}