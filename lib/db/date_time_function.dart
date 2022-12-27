import 'package:flutter/material.dart';

Future<TimeOfDay?> TimePicker(BuildContext context) async {
  return showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
}

// ignore: non_constant_identifier_names
Future<DateTime?> DatePicker(BuildContext context) async {
  return showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2001),
    lastDate: DateTime(2030),
  );
}
