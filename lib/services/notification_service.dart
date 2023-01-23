// import 'dart:ffi';

// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/browser.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// class LocalNotificationServices {
//   LocalNotificationServices();
//   final _localNotificationService = FlutterLocalNotificationsPlugin();
//   Future<void> intialize() async {
//     tz.initializeTimeZone();
//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('@drwable/ic_stat_alarm_add');
//     final InitializationSettings settings =
//         InitializationSettings(android: androidInitializationSettings);
//     // await _localNotificationService.initialize(settings,
//     //     onDidReceiveBackgroundNotificationResponse: onSelectedNotification);
//     Future<NotificationDetails?> _notificationDetails() async {
//       const AndroidNotificationDetails androidNotificationDetails =
//           AndroidNotificationDetails(
//         'channel_id',
//         'channel_name',
//         channelDescription: 'description',
//         importance: Importance.max,
//         priority: Priority.max,
//         playSound: true,
//       );
//     }

//     Future<Void?> notification({
//       required int id,
//       required String title,
//       required String body,
//       required int seconds,
//     }) async {
//       final details = await _notificationDetails();
//       await _localNotificationService.zonedSchedule(
//         id,
//         title,
//         body,
//         tz.TZDateTime.from(
//             DateTime.now().add(Duration(seconds: seconds)), tz.local),
//         details!,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         androidAllowWhileIdle: true,
//       );
//     }

//     void onSelectedNotification(NotificationResponse details) {
//       print(details);
//     }
//   }
// }
import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:intl/intl.dart';

import '../db/db_function.dart';
import '../widgets/event_container.dart';
import '../widgets/task_list_container.dart';

void notify({required String? title, required DateTime body}) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          channelKey: 'task',
          title: title,
          body: DateFormat('hh:mm a').format(body)));
}

checkTimeNotification() {
  Timer.periodic(Duration(seconds: 5), (timer) {
    DateTime datetimeNow = DateTime.now();
    if (DateTime(notifyDate.year, notifyDate.month, notifyDate.day,
            notifytime.hour, notifytime.minute) ==
        (DateTime(datetimeNow.year, datetimeNow.month, datetimeNow.day,
            datetimeNow.hour, datetimeNow.minute))) {
      notify(title: notifydata!.task, body: notifydata!.taskDate);
      getAllTask();
    }
  });
}

checkTimeNotificationEvent() {
  Timer.periodic(Duration(seconds: 5), (timer) {
    DateTime datetimeNow = DateTime.now();
    if (DateTime(
            notifyeventdate.year,
            notifyeventdate.month,
            notifyeventdate.day,
            notifyeventtime.hour,
            notifyeventtime.minute) ==
        (DateTime(datetimeNow.year, datetimeNow.month, datetimeNow.day,
            datetimeNow.hour, datetimeNow.minute))) {
      notify(title: notifydataEvnt!.eventName, body: notifydataEvnt!.eventTime);
      getAllEvents();
    }
  });
}
