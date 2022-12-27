// import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todoolist/db/db_function.dart';
import 'package:todoolist/model/data_model.dart';
import 'package:todoolist/widgets/event_container.dart';
import 'package:todoolist/widgets/event_edit_bottom_sheet.dart';
import 'package:todoolist/widgets/task_list_container.dart';
import 'package:todoolist/widgets/text_widget.dart';

class Tech {
  String label;
  Color color;
  bool isSelected;
  Tech(this.label, this.color, this.isSelected);
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool selected = false;
  final List<Tech> _chipsList = [
    Tech("High", Colors.red, false),
    Tech("Medium", Colors.green, false),
    Tech("Low", Colors.yellow, false),
  ];
  final textEditingController = TextEditingController();
  TabController? tabController;
  List<Widget> prioritys = [
    PrioirtyIcons(colors: Colors.red),
    PrioirtyIcons(colors: Colors.orange),
    PrioirtyIcons(colors: Colors.green)
  ];
  List<TaskModel> tasks = Hive.box<TaskModel>('TaskModel').values.toList();
  late List<TaskModel> searchedTasks = List<TaskModel>.from(tasks);
  List<EventModel> events = Hive.box<EventModel>('EventModel').values.toList();
  late List<EventModel> searchedEvents = List<EventModel>.from(events);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: TabBarView(
              children: [
                SearchTask(prioritys: prioritys, passvalue: searchedTasks),
                SearchEvent(eventList: searchedEvents, prioritys: prioritys)
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Wrap(
              spacing: 0,
              direction: Axis.horizontal,
              children: techChips(),
            ),
          )
        ]),
        appBar: AppBar(
          bottom: TabBar(
            tabs: const [
              Tab(icon: Icon(Icons.task)),
              Tab(icon: Icon(Icons.event))
            ],
            controller: tabController,
          ),
          title: Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: [
                Center(
                  child: TextField(
                    controller: textEditingController,
                    onChanged: (value) {
                      searchTask(value);
                      searchEvents(value);
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            textEditingController.clear();
                            setState(() {
                              searchedEvents = events;
                              searchedTasks = tasks;
                            });
                            /* Clear the search field */
                          },
                        ),
                        hintText: 'Search Task or Event Name',
                        border: InputBorder.none),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void searchEvents(String query) {
    setState(() {
      searchedEvents = events
          .where((element) =>
              element.eventName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void searchTask(String query) {
    setState(() {
      if (query == 'High') {
        searchedTasks = tasks
            .where((element) =>
                element.toggle == 0 &&
                element.task.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        searchedTasks = tasks
            .where((element) =>
                element.task.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  List<Widget> techChips() {
    List<Widget> chips = [];
    for (int i = 0; i < _chipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: FilterChip(
          label: Text(_chipsList[i].label),
          labelStyle: TextStyle(color: Colors.white),
          backgroundColor: _chipsList[i].color,
          selected: _chipsList[i].isSelected,
          onSelected: (bool value) {
            setState(() {
              searchTask(_chipsList[i].label);
              // print(value);
              print(_chipsList[i].label);
              _chipsList[i].isSelected = value;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}

class SearchTask extends StatelessWidget {
  List<TaskModel> passvalue;
  SearchTask({super.key, required this.prioritys, required this.passvalue});

  final List<Widget> prioritys;

  @override
  Widget build(BuildContext context) {
    return passvalue.isNotEmpty
        ? ListView.builder(
            itemBuilder: (context, index) {
              final data = passvalue[index];
              return TaskBlocks(
                data: data,
                prioritys: prioritys,
              );
            },
            itemCount: passvalue.length,
          )
        : Center(
            child: TextWidget(
              text: 'Nothing matched',
              fontWeight: FontWeight.w500,
              fontsize: 30,
              color: Colors.black38,
            ),
          );
  }
}

class SearchEvent extends StatelessWidget {
  List<Widget> prioritys;
  List<EventModel> eventList;
  SearchEvent({super.key, required this.eventList, required this.prioritys});

  @override
  Widget build(BuildContext context) {
    return eventList.isNotEmpty
        ? GridView.count(
            physics: const ScrollPhysics(),
            crossAxisCount: 2,
            // scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: List.generate(eventList.length, (index) {
              final data = eventList[index];
              return Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return EventEditScreen(
                          passvalue: data,
                        );
                      },
                    );
                  },
                  onLongPress: () {
                    deleteAlert(context, index);
                  },
                  child: EventBlock(data: data, prioritys: prioritys),
                ),
              );
            }),
          )
        : Center(
            child: TextWidget(
              text: 'Nothing matched',
              fontWeight: FontWeight.w500,
              fontsize: 30,
              color: Colors.black38,
            ),
          );
  }

  deleteAlert(BuildContext context, id) {
    showDialog(
        context: context,
        builder: ((ctx) => AlertDialog(
              content: const Text('Are you sure you want to delete'),
              actions: [
                TextButton(
                    onPressed: () {
                      deleteEvent(id);
                      Navigator.of(context).pop(ctx);
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    )),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(ctx),
                  child: const Text('Cancel'),
                )
              ],
            )));
  }
}
