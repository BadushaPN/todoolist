// ignore: depend_on_referenced_packages
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class TaskModel {
  @HiveField(0)
  late final String? id;
  @HiveField(1)
  final String task;
  @HiveField(2)
  final String description;
  @HiveField(3)
  late final DateTime taskDate;
  @HiveField(4)
  final int toggle;
  @HiveField(5)
  final DateTime taskTime;
  TaskModel(
      {required this.toggle,
      required this.task,
      required this.description,
      this.id,
      required this.taskDate,
      required this.taskTime});
}

@HiveType(typeId: 2)
class EventModel {
  @HiveField(0)
  late final String? id;
  @HiveField(1)
  final String eventName;
  @HiveField(2)
  final String eventDescription;
  @HiveField(3)
  final DateTime eventDate;
  @HiveField(4)
  late final String? image;
  @HiveField(5)
  final DateTime eventTime;
  @HiveField(6)
  final int toggle;
  EventModel(
      {required this.eventName,
      required this.eventDescription,
      required this.eventDate,
      required this.image,
      required this.eventTime,
      required this.toggle,
      this.id});
}
