import 'package:flutter/material.dart';
import 'package:todoolist/widgets/add_button.dart';
// import 'package:todoolist/screens/home_screen.dart';
import 'package:todoolist/widgets/task_adding_bottom_sheet.dart';

class AddTaskButton extends StatelessWidget {
  int index;
  AddTaskButton(
      {super.key,
      required TextEditingController taskController,
      required TextEditingController descriotionController,
      required this.index})
      : _taskController = taskController,
        _descriotionController = descriotionController;

  final TextEditingController _taskController;
  final TextEditingController _descriotionController;

  @override
  Widget build(BuildContext context) {
    return AddButton(
      text: 'Add tasks',
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.only(top: 50),
                child: TaskAddingBottomSheet(
                    taskController: _taskController,
                    descriotionController: _descriotionController),
              );
            });
      },
    );
  }
}
