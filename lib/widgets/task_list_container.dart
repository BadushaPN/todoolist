import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';
import 'package:todoolist/colo/color.dart';
import 'package:todoolist/db/db_function.dart';
// import 'package:todoolist/screens/home_screen.dart';
import 'package:todoolist/widgets/task_editing_bottumsheet.dart';
import 'package:todoolist/widgets/text_widget.dart';

import '../model/data_model.dart';

class TaskListContainer extends StatelessWidget {
  int index;
  TaskListContainer({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    List<Widget> prioritys = [
      PrioirtyIcons(colors: Colors.red),
      PrioirtyIcons(colors: Colors.orange),
      PrioirtyIcons(colors: Colors.green)
    ];
    getAllTask();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: globalColor(),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        child: TaskValueListnerBuilder(
          newindex: index,
          prioritys: prioritys,
        ),
      ),
    );
  }
}

class TaskValueListnerBuilder extends StatelessWidget {
  int newindex;
  TaskValueListnerBuilder(
      {super.key, required this.prioritys, required this.newindex});

  final List<Widget> prioritys;

  @override
  Widget build(BuildContext context) {
    print('{$newindex}task');
    List<TaskModel> datad = [];
    // List<TaskModel> highPriority = [];
    return ValueListenableBuilder(
      valueListenable: taskListNotifier,
      builder: ((context, List<TaskModel> taskList, child) {
        getAllTask();
        datad = taskList
            .where((element) => element.taskDate
                .isAfter(DateTime.now().subtract(const Duration(days: 1))))
            .toList();

        return datad.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  final sortedtaskList = datad
                    ..sort((a, b) {
                      return a.taskDate.compareTo(b.taskDate);
                    });
                  final data = sortedtaskList[index];

                  return TaskBlocks(
                    data: data,
                    prioritys: prioritys,
                  );
                },
                itemCount: datad.length,
              )
            : Center(
                child: TextWidget(
                  text: 'No tasks',
                  fontWeight: FontWeight.w500,
                  fontsize: 30,
                  color: Colors.black38,
                ),
              );
      }),
    );
  }
}

class TaskBlocks extends StatelessWidget {
  const TaskBlocks({
    super.key,
    required this.data,
    required this.prioritys,
  });

  final TaskModel data;
  final List<Widget> prioritys;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: TaskSlidable(data: data, prioritys: prioritys),
    );
  }
}

class TaskSlidable extends StatelessWidget {
  const TaskSlidable({
    super.key,
    required this.data,
    required this.prioritys,
  });

  final TaskModel data;
  final List<Widget> prioritys;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            icon: Icons.done,
            backgroundColor: Colors.green,
          )
        ],
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              deleteTask(data.id!);
              Fluttertoast.showToast(
                msg: "'${data.task}' Task Deleted",
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 2,
                textColor: Colors.white,
                backgroundColor: Colors.black,
                fontSize: 12,
              );
            },
            icon: Icons.delete,
            backgroundColor: Colors.red,
          )
        ],
      ),
      child: TaskCardList(data: data, prioritys: prioritys),
    );
  }
}

class TaskCardList extends StatelessWidget {
  const TaskCardList({
    super.key,
    required this.data,
    required this.prioritys,
  });

  final TaskModel data;
  final List<Widget> prioritys;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Card(
        color: Colors.white,
        child: ListTile(
          title: TextWidget(text: data.task),
          // subtitle: TextWidget(text: data.description),
          trailing: Column(
            children: [
              prioritys[data.toggle],
              Text(
                DateFormat('dd-MMM-yyyy').format(data.taskDate),
              ),
              Text(
                DateFormat('hh:mm a').format(data.taskTime),
                style: const TextStyle(fontSize: 11),
              )
            ],
          ),
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return TaskEditingBottumSheet(passvalue: data);
              },
            );
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PrioirtyIcons extends StatelessWidget {
  Color? colors;
  PrioirtyIcons({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.label_important,
      color: colors,
    );
  }
}
