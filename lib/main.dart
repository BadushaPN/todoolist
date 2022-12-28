import 'package:flutter/material.dart';
import 'package:todoolist/model/data_model.dart';
import 'package:todoolist/screens/splash_screen.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

late String userName;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // await Hive.openBox('TaskModel');
  if (!Hive.isAdapterRegistered(TaskModelAdapter().typeId)) {
    Hive.registerAdapter(TaskModelAdapter());
  }
  // await Hive.openBox('TaskModel');
  if (!Hive.isAdapterRegistered(EventModelAdapter().typeId)) {
    Hive.registerAdapter(EventModelAdapter());
  }
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
