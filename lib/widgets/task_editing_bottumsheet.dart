import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:todoolist/db/db_function.dart';
import 'package:todoolist/model/data_model.dart';
import 'package:todoolist/widgets/bottom_navigation_bar.dart';
import 'package:todoolist/widgets/task_adding_done_discard.dart';
import 'package:todoolist/widgets/text_form_fields.dart';
import 'package:todoolist/widgets/text_form_fields_edit.dart';
import 'package:todoolist/widgets/text_widget.dart';
import 'package:todoolist/widgets/uppercase_text_format.dart';

import '../colo/color.dart';
import '../db/date_time_function.dart';

class TaskEditingBottumSheet extends StatefulWidget {
  TaskModel passvalue;
  TaskEditingBottumSheet({super.key, required this.passvalue});

  @override
  State<TaskEditingBottumSheet> createState() => _TaskEditingBottumSheetState();
}

class _TaskEditingBottumSheetState extends State<TaskEditingBottumSheet> {
  late final _taskController =
      TextEditingController(text: widget.passvalue.task);
  late final _descriotionController =
      TextEditingController(text: widget.passvalue.description);
  late DateTime currentDate = widget.passvalue.taskDate;

  late DateTime currentTime = widget.passvalue.taskTime;
  late int? newindex = widget.passvalue.toggle;
  List<bool> isSelected = [false, false, false];
  @override
  void initState() {
    super.initState();
    isSelected[widget.passvalue.toggle] = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: blueColor(),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 20),
                child: WhatIsYourTaskText(),
              ),
              TextFormFieldsEdit(
                // inputFormatters: [UpperCaseTextFormatter()],
                // hintTexts: 'Your Task',
                myController: _taskController,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 20),
                child: TaskDescriptionText(),
              ),
              TextFormFieldsEdit(
                // inputFormatters: [UpperCaseTextFormatter()],
                maxlines: 3,
                hintTexts: 'Discreption',
                height: 120,
                myController: _descriotionController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextWidget(text: 'Date'),
                  TextWidget(text: 'Time'),
                ],
              ),
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
                            text: DateFormat('dd-MMM-yyyy').format(currentDate),
                            fontsize: 12,
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
                      for (int index = 0; index < isSelected.length; index++) {
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
                        style:
                            TextStyle(fontSize: 12, color: Colors.greenAccent)),
                  ),
                ],
              ),
              TaskAddingDoneDiscard(
                onPressed: () {
                  editTaskButtonClick(
                      widget.passvalue.id, context, widget.passvalue);
                  // Navigator.of(context).pushAndRemoveUntil(
                  //     MaterialPageRoute(
                  //         builder: (context) => const MyBottomNavigationBar()),
                  //     (route) => false);
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  editTaskButtonClick(index, context, TaskModel value) async {
    final _task = _taskController.text.trim();
    final _description = _descriotionController.text.trim();
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
        toggle: _toggle ?? widget.passvalue.toggle,
        id: _id);
    print('$_task');
    print('add');
    editTasks(index, context, _tasks);
  }
}

class TaskDescriptionText extends StatelessWidget {
  const TaskDescriptionText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft, child: TextWidget(text: 'Description >'));
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
      child: TextWidget(text: 'Your task >'),
    );
  }
}
