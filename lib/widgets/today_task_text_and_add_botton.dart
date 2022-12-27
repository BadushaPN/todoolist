import 'package:flutter/material.dart';
// import 'package:todoolist/screens/add_task_button.dart';
import 'package:todoolist/screens/home_screen.dart';
import 'package:todoolist/widgets/add_task_button.dart';

class TodayTaskTextAndAddTaskButton extends StatefulWidget {
  const TodayTaskTextAndAddTaskButton({
    super.key,
    required TextEditingController taskController,
    required TextEditingController descriotionController,
  })  : _taskController = taskController,
        _descriotionController = descriotionController;

  final TextEditingController _taskController;
  final TextEditingController _descriotionController;

  @override
  State<TodayTaskTextAndAddTaskButton> createState() =>
      _TodayTaskTextAndAddTaskButtonState();
}

class _TodayTaskTextAndAddTaskButtonState
    extends State<TodayTaskTextAndAddTaskButton> {
  int listItemIndex = 0;
  List<String> listitems = [
    "All Tasks",
    "High Priority Tasks",
    "Medium Priority Tasks",
    "Low Priority Tasks",
  ];
  String selectval = "All Tasks";
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DropdownButton(
          value: selectval,
          onChanged: (value) {
            setState(() {
              // print(listitems.indexOf(value!));
              selectval = value.toString();
              listItemIndex = listitems.indexOf(value!);
              print(listItemIndex);
            });
          },
          items: listitems.map((itemone) {
            return DropdownMenuItem(value: itemone, child: Text(itemone));
          }).toList(),
        ),
        // const TodayTaskText(),
        AddTaskButton(
            index: listItemIndex,
            taskController: widget._taskController,
            descriotionController: widget._descriotionController),
      ],
    );
  }
}
