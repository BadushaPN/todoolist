import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:todoolist/model/data_model.dart';
import 'package:todoolist/screens/home_screen.dart';
// import 'package:todoolist/screens/search_screen.dart';
// import 'package:todoolist/screens/search_screen.dart';
import 'package:todoolist/widgets/add_task_button.dart';
import 'package:todoolist/widgets/task_list_container.dart';
// import 'package:todoolist/widgets/text_widget.dart';
// import 'package:todoolist/screens/home_screen.dart';
// import 'package:todoolist/widgets/today_task_text_and_add_botton.dart';
// import 'package:todoolist/screens/today_task_text_and_add_botton.dart';

class TasksHomeScreen extends StatefulWidget {
  const TasksHomeScreen({
    super.key,
  });

  @override
  State<TasksHomeScreen> createState() => _TasksHomeScreenState();
}

class _TasksHomeScreenState extends State<TasksHomeScreen> {
  List<Widget> prioritys = [
    PrioirtyIcons(colors: Colors.red),
    PrioirtyIcons(colors: Colors.orange),
    PrioirtyIcons(colors: Colors.green)
  ];

  int listItemIndex = 0;

  @override
  @override
  Widget build(BuildContext context) {
    final _taskController = TextEditingController();
    final _descriotionController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TodayTaskText(),
              AddTaskButton(
                  index: listItemIndex,
                  taskController: _taskController,
                  descriotionController: _descriotionController),
            ],
          ),
          TaskListContainer(index: listItemIndex)
        ],
      ),
    );
  }
}
