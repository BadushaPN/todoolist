// import 'dart:html';

// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todoolist/db/db_function.dart';
import 'package:todoolist/model/data_model.dart';
import 'package:todoolist/widgets/event_container.dart';
import 'package:todoolist/widgets/event_edit_bottom_sheet.dart';
import 'package:todoolist/widgets/task_list_container.dart';
import 'package:todoolist/widgets/text_widget.dart';

DateTimeRange? newDateRange;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future pickDateRange() async {
    newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(2000),
      lastDate: DateTime(2300),
    );
    if (newDateRange == null) {
      return;
    }
    searchTask(textEditingController.text, newDateRange);
    searchEvents(textEditingController.text, newDateRange);
    // setState(() {
    //   dateRange = newDateRange;
    // });
  }

  DateTimeRange dateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  String _selectedOptions = '';

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
              spacing: 10,
              children: <Widget>[
                FilterChip(
                  label: const Text('High'),
                  selectedColor: Colors.red,
                  selected: (_selectedOptions == 'High') ? true : false,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        // print(_selectedOptions.indexOf(0));
                        _selectedOptions = 'High';
                        searchEvents(textEditingController.text, null);
                        searchTask(textEditingController.text, null);
                      } else {
                        _selectedOptions = 'Wrong';
                        searchEvents(textEditingController.text, null);
                        searchTask(textEditingController.text, null);
                      }
                    });
                  },
                ),
                FilterChip(
                  label: const Text('Medium'),
                  selectedColor: Colors.orange,
                  selected: (_selectedOptions == 'Medium') ? true : false,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        // print(_selectedOptions.indexOf(1));
                        _selectedOptions = 'Medium';
                        searchEvents(textEditingController.text, null);
                        searchTask(textEditingController.text, null);
                      } else {
                        _selectedOptions = 'Wrong';
                        searchEvents(textEditingController.text, null);
                        searchTask(textEditingController.text, null);
                      }
                    });
                  },
                ),
                FilterChip(
                  label: const Text('Low'),
                  selectedColor: Colors.green,
                  selected: (_selectedOptions == 'Low') ? true : false,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        // print(_select00edOption==;
                        _selectedOptions = 'Low';
                        searchEvents(textEditingController.text, null);
                        searchTask(textEditingController.text, null);
                      } else {
                        _selectedOptions = 'Wrong';
                        searchEvents(textEditingController.text, null);
                        searchTask(textEditingController.text, null);
                      }
                    });
                  },
                ),
                FilterChip(
                  label: const Text('Date'),
                  selectedColor: Colors.yellow,
                  selected: (_selectedOptions == 'Date') ? true : false,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        // print(_select00edOption==;
                        _selectedOptions = 'Date';
                        pickDateRange();
                        // searchEvents(textEditingController.text, null);
                        // searchTask(textEditingController.text, null);
                      } else {
                        _selectedOptions = 'Wrong';
                        searchEvents(textEditingController.text, null);
                        searchTask(textEditingController.text, null);
                        // pickDateRange();
                      }
                    });
                  },
                ),
              ],
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
                      searchTask(value, dateRange);
                      searchEvents(value, dateRange);
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

  void searchEvents(String query, newDate) {
    setState(() {
      switch (_selectedOptions) {
        case 'High':
          searchedEvents = events
              .where((element) =>
                  element.toggle == 0 &&
                  element.eventName.toLowerCase().contains(query.toLowerCase()))
              .toList();
          break;
        case 'Medium':
          searchedEvents = events
              .where((element) =>
                  element.toggle == 1 &&
                  element.eventName.toLowerCase().contains(query.toLowerCase()))
              .toList();
          break;
        case 'Low':
          searchedEvents = events
              .where((element) =>
                  element.toggle == 2 &&
                  element.eventName.toLowerCase().contains(query.toLowerCase()))
              .toList();
          break;
        case 'Date':
          searchedEvents = events
              .where((element) =>
                  element.eventDate.isAfter(DateTime(newDate.start.year,
                      newDate.start.month, newDate.start.day - 1)) &&
                  element.eventDate.isBefore(DateTime(newDate.end.year,
                      newDate.end.month, newDate.end.day + 1)) &&
                  element.eventName.toLowerCase().contains(query))
              .toList();
          break;
        default:
          searchedEvents = events
              .where((element) =>
                  element.eventName.toLowerCase().contains(query.toLowerCase()))
              .toList();
      }
    });
  }

  void searchTask(String query, newDate) {
    setState(() {
      switch (_selectedOptions) {
        case 'High':
          searchedTasks = tasks
              .where(
                (element) =>
                    element.toggle == 0 &&
                    element.task.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();

          break;
        case 'Medium':
          searchedTasks = tasks
              .where((element) =>
                  element.toggle == 1 &&
                  element.task.toLowerCase().contains(query.toLowerCase()))
              .toList();

          break;
        case 'Low':
          searchedTasks = tasks
              .where((element) =>
                  element.toggle == 2 &&
                  element.task.toLowerCase().contains(query.toLowerCase()))
              .toList();
          break;
        case 'Date':
          searchedTasks = tasks
              .where((element) =>
                  element.task.toLowerCase().contains(query) &&
                  element.taskDate.isAfter(DateTime(newDate.start.year,
                      newDate.start.month, newDate.start.day - 1)) &&
                  element.taskDate.isBefore(DateTime(newDate.end.year,
                      newDate.end.month, newDate.end.day + 1)))
              .toList();

          break;

        default:
          searchedTasks = tasks
              .where((element) =>
                  element.task.toLowerCase().contains(query.toLowerCase()))
              .toList();
      }
    });
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
