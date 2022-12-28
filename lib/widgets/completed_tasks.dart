import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todoolist/colo/color.dart';
import 'package:todoolist/db/db_function.dart';
import 'package:todoolist/model/data_model.dart';
import 'package:todoolist/widgets/task_list_container.dart';
import 'package:todoolist/widgets/text_widget.dart';

class CompletedTasks extends StatelessWidget {
  const CompletedTasks({super.key});

  @override
  Widget build(BuildContext context) {
    List<TaskModel> datad = [];
    List<Widget> prioritys = [
      PrioirtyIcons(colors: Colors.red),
      PrioirtyIcons(colors: Colors.orange),
      PrioirtyIcons(colors: Colors.green)
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: globalColor(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ValueListenableBuilder(
            valueListenable: taskListNotifier,
            builder: ((context, List<TaskModel> taskList, child) {
              getAllTask();
              datad = taskList
                  .where((element) => element.isCompleted == true)
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
                        text: 'No tasks completed',
                        fontWeight: FontWeight.w500,
                        fontsize: 30,
                        color: Colors.black38,
                      ),
                    );
            }),
          ),
        ),
      ),
    );
  }
}
