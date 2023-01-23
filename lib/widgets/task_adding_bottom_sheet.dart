// import 'dart:ffi';
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart';
import 'package:todoolist/db/db_function.dart';
import 'package:todoolist/model/data_model.dart';
import 'package:todoolist/services/notification_service.dart';
import 'package:todoolist/widgets/bottom_navigation_bar.dart';
import 'package:todoolist/widgets/event_add_bottomsheet.dart';
import 'package:todoolist/widgets/task_adding_done_discard.dart';
import 'package:todoolist/widgets/text_form_fields.dart';
import 'package:todoolist/widgets/text_widget.dart';

import '../db/date_time_function.dart';
import 'date_time_text_widgets.dart';

class TaskAddingBottomSheet extends StatefulWidget {
  const TaskAddingBottomSheet({
    super.key,
    required TextEditingController taskController,
    required TextEditingController descriotionController,
  })  : _taskController = taskController,
        _descriotionController = descriotionController;

  final TextEditingController _taskController;
  final TextEditingController _descriotionController;

  @override
  State<TaskAddingBottomSheet> createState() => _TaskAddingBottomSheetState();
}

class _TaskAddingBottomSheetState extends State<TaskAddingBottomSheet> {
  DateTime currentDate = DateTime.now();

  DateTime currentTime = DateTime.now();
  int? newindex = 0;
  List<bool> isSelected = [true, false, false];
  // late final LocalNotificationServices service;
  @override
  void initState() {
    // service = LocalNotificationServices();
    // service.intialize();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10, left: 20),
                  child: WhatIsYourTaskText(),
                ),
                TextFormFields(
                  maxlines: 1,
                  hintTexts: 'Enter Task',
                  myController: widget._taskController,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, left: 20),
                  child: TaskDescriptionText(),
                ),
                TextFormFields(
                  maxlines: 3,
                  hintTexts: 'Discreption',
                  height: 120,
                  myController: widget._descriotionController,
                ),
                const DateTimeTextWidget(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        DatePicker(context).then(
                          (date) {
                            if (date == null) {
                              return;
                            }
                            setState(
                              () {
                                print('Date');
                                currentDate = date;
                              },
                            );
                          },
                        );
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              text:
                                  DateFormat('dd-MMM-yyyy').format(currentDate),
                              fontsize: 12,
                              color: Colors.white,
                            ),
                            const Icon(Icons.calendar_month)
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        TimePicker(context).then(
                          (time) {
                            if (time == null) {
                              return;
                            }
                            final newTime = DateTime(
                                currentDate.day,
                                currentDate.year,
                                currentDate.month,
                                time.hour,
                                time.minute);

                            setState(
                              () {
                                currentTime = newTime;
                              },
                            );
                          },
                        );
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              text: DateFormat('hh:mm a').format(currentTime),
                              fontsize: 12,
                              color: Colors.white,
                            ),
                            const Icon(Icons.lock_clock_outlined)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(text: 'Priority'),
                ),
                ToggleButtons(
                  borderRadius: BorderRadius.circular(10),
                  isSelected: isSelected,
                  onPressed: (newIndex) {
                    setState(
                      () {
                        // looping through the list of booleans values
                        for (int index = 0;
                            index < isSelected.length;
                            index++) {
                          // checking for the index value
                          if (index == newIndex) {
                            newindex = newIndex;
                            // one button is always set to true
                            print(newIndex);
                            isSelected[index] = true;
                          } else {
                            // other two will be set to false and not selected
                            isSelected[index] = false;
                          }
                        }
                      },
                    );
                  },
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'HIGH',
                        style: TextStyle(fontSize: 12, color: Colors.redAccent),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('MEDIUM',
                          style: TextStyle(
                              fontSize: 12, color: Colors.orangeAccent)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('LOW',
                          style: TextStyle(
                              fontSize: 12, color: Colors.greenAccent)),
                    ),
                  ],
                ),
                TaskAddingDoneDiscard(
                  onPressed: () async {
                    addTaskButtonClick();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) =>
                                const MyBottomNavigationBar()),
                        (route) => false);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  addTaskButtonClick() async {
    final _task = widget._taskController.text.trim();
    final _description = widget._descriotionController.text.trim();
    final _taskDate = currentDate;
    final _taskTime = currentTime;
    final _toggle = newindex;
    final _id = DateTime.now().toString();
    if (_task.isEmpty) {
      return;
    }
    final _tasks = TaskModel(
        description: _description,
        task: _task,
        taskDate: _taskDate,
        taskTime: _taskTime,
        toggle: _toggle ?? 0,
        id: _id,
        isCompleted: false);
    print('$_task');
    print('add');
    addTasks(_tasks);
  }
}

class TaskDescriptionText extends StatelessWidget {
  const TaskDescriptionText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: TextWidget(text: 'Task description'));
  }
}

class WhatIsYourTaskText extends StatelessWidget {
  const WhatIsYourTaskText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: TextWidget(text: 'Whate is your task?'),
    );
  }
}
