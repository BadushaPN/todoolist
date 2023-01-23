import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:todoolist/model/data_model.dart';
import 'package:todoolist/screens/splash_screen.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todoolist/services/notification_service.dart';

late String userName;
void main() async {
  checkTimeNotification();
  await Hive.initFlutter();
  // await Hive.openBox('TaskModel');
  if (!Hive.isAdapterRegistered(TaskModelAdapter().typeId)) {
    Hive.registerAdapter(TaskModelAdapter());
  }
  // await Hive.openBox('TaskModel');
  if (!Hive.isAdapterRegistered(EventModelAdapter().typeId)) {
    Hive.registerAdapter(EventModelAdapter());
  }
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'task',
        channelName: 'Proto Coders Point',
        channelDescription: "Notification example",
        defaultColor: Colors.blue,
        ledColor: Colors.white,
        playSound: true,
        // soundSource: '')
        enableLights: true,
        enableVibration: true),
  ]);
  runApp(
    const TodooList(),
  );
}

class TodooList extends StatelessWidget {
  const TodooList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodooList',
      theme:
          ThemeData(primarySwatch: Colors.green, brightness: Brightness.light),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
