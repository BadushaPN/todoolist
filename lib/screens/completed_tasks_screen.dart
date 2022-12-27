import 'package:flutter/material.dart';
import 'package:todoolist/widgets/completed_tasks.dart';
import 'package:todoolist/widgets/pending_tasks.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class CompletedAndPendingTasks extends StatefulWidget {
  const CompletedAndPendingTasks({super.key});

  @override
  State<CompletedAndPendingTasks> createState() =>
      _CompletedAndPendingTasksState();
}

class _CompletedAndPendingTasksState extends State<CompletedAndPendingTasks> {
  TabController? _tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                // give the tab bar a height [can change hheight to preferred height]
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    // give the indicator a decoration (color and border radius)
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                      color: Colors.green,
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: const [
                      Tab(
                        text: 'Completed Tasks',
                      ),
                      // first tab [you can add an icon using the icon property]
                      Tab(
                        text: 'Pending Tasks',
                      ),

                      // second tab [you can add an icon using the icon property]
                    ],
                  ),
                ),
                // tab bar view here
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      CompletedTasks(),
                      // first tab bar view widget
                      PendingTasks(),
                      // second tab bar view widget
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
