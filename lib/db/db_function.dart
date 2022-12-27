// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:todoolist/model/data_model.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<TaskModel>> taskListNotifier = ValueNotifier([]);
Future addTasks(TaskModel value) async {
  final taskDB = await Hive.openBox<TaskModel>('TaskModel');
  final _id = taskDB.add(value);
  // value.id = _idas;
  taskListNotifier.value.add(value);
  taskListNotifier.notifyListeners();
}

void getAllTask() async {
  final taskDB = await Hive.openBox<TaskModel>('TaskModel');
  taskListNotifier.value.clear();
  taskListNotifier.value.addAll(taskDB.values);
  taskListNotifier.notifyListeners();
}

editTasks(index, context, TaskModel value) async {
  final taskDB = await Hive.openBox<TaskModel>('TaskModel');
  final Map<dynamic, TaskModel> taskMap = taskDB.toMap();
  dynamic desiredKey;
  taskMap.forEach((key, value) {
    if (value.id == index) {
      desiredKey = key;
    }
  });
  taskDB.put(desiredKey, value);
  getAllTask();
}

Future deleteTask(String index) async {
  final box = Hive.box<TaskModel>('TaskModel');

  final Map<dynamic, TaskModel> taskListMap = box.toMap();
  dynamic desiredKey;
  taskListMap.forEach((key, value) {
    if (value.id == index) {
      desiredKey = key;
    }
  });
  await box.delete(desiredKey);
  getAllTask();
}

ValueNotifier<List<EventModel>> eventListNotifier = ValueNotifier([]);
Future addEvents(EventModel value) async {
  final eventDB = await Hive.openBox<EventModel>('EventModel');
  final _id = eventDB.add(value);
  // value.id = _id as String;
  eventListNotifier.value.add(value);
  eventListNotifier.notifyListeners();
}

void getAllEvents() async {
  final eventDB = await Hive.openBox<EventModel>('EventModel');
  eventListNotifier.value.clear();
  eventListNotifier.value.addAll(eventDB.values);
  eventListNotifier.notifyListeners();
}

editEvents(index, context, EventModel value) async {
  final eventDB = await Hive.openBox<EventModel>('EventModel');
  final Map<dynamic, EventModel> taskMap = eventDB.toMap();
  dynamic desiredKey;
  taskMap.forEach((key, value) {
    if (value.id == index) {
      desiredKey = key;
    }
  });
  eventDB.put(desiredKey, value);
  getAllEvents();
}

void deleteEvent(int id) async {
  final eventDB = await Hive.openBox<EventModel>('EventModel');
  await eventDB.deleteAt(id);
  getAllEvents();
}
