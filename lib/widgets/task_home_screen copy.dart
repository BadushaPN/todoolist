import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoolist/model/data_model.dart';
import 'package:todoolist/screens/home_screen.dart';
import 'package:todoolist/screens/search_screen.dart';
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
  // List<TaskModel> tasks = Hive.box<TaskModel>('TaskModel').values.toList();
  // late List<TaskModel> lowPriority = List<TaskModel>.from(tasks);
  // late List<TaskModel> mediumPriority = List<TaskModel>.from(tasks);
  // late List<TaskModel> highPriority = List<TaskModel>.from(tasks);
  int listItemIndex = 0;
  List<String> listitems = [
    "All Tasks",
    "High Priority Tasks",
    "Medium Priority Tasks",
    "Low Priority Tasks",
  ];
  String selectval = "All Tasks";
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
              // DropdownButton(
              //   value: selectval,
              //   onChanged: (value) {
              //     setState(() {
              //       // allTask();
              //       // print(listitems.indexOf(value!));
              //       selectval = value.toString();
              //       listItemIndex = listitems.indexOf(value!);
              //       print("{$listItemIndex}");
              //       print('hlo');
              //     });
              //   },
              //   items: listitems.map((itemone) {
              //     return DropdownMenuItem(value: itemone, child: Text(itemone));
              //   }).toList(),
              // ),
              const TodayTaskText(),
              AddTaskButton(
                  index: listItemIndex,
                  taskController: _taskController,
                  descriotionController: _descriotionController),
            ],
          ),
          // ListView.builder(
          //   itemBuilder: (context, index) {
          //     var alldata = [highPriority, mediumPriority, lowPriority];
          //     final sorteddata = alldata[listItemIndex];
          //     final data = sorteddata[index];
          //     return TaskBlocks(
          //       data: data,
          //       prioritys: prioritys,
          //     );
          //   },
          //   itemCount: highPriority.length,
          // )
          // TaskValueListnerBuilder(prioritys: prioritys, newindex: listItemIndex)
          // SearchTask(prioritys: prioritys, passvalue: alltasks[listItemIndex])
          TaskListContainer(index: listItemIndex)
        ],
      ),
    );
  }

  // void alltasks() {
  //   highPriority = tasks.where((element) => element.toggle == 0).toList();
  //   mediumPriority = tasks.where((element) => element.toggle == 1).toList();
  //   lowPriority = tasks.where((element) => element.toggle == 2).toList();
  // }

  // void allTask() {
  //   setState(() {
  //     allTasks = tasks
  //         .where((element) => element.taskDate
  //             .isAfter(DateTime.now().subtract(const Duration(days: 1))))
  //         .toList();
  //   });
  // }
}
