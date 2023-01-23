import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todoolist/colo/color.dart';
import 'package:todoolist/db/db_function.dart';
import 'package:todoolist/model/data_model.dart';
import 'package:todoolist/screens/search_screen.dart';
import 'package:todoolist/widgets/task_list_container.dart';
import 'package:todoolist/widgets/text_widget.dart';

class Screen_calender extends StatefulWidget {
  const Screen_calender({super.key});

  @override
  State<Screen_calender> createState() => _Screen_calenderState();
}

class _Screen_calenderState extends State<Screen_calender> {
  TabController? tabController;
  List<Widget> prioritys = [
    PrioirtyIcons(colors: Colors.red),
    PrioirtyIcons(colors: Colors.orange),
    PrioirtyIcons(colors: Colors.green)
  ];
  List<TaskModel> todomodelist =
      Hive.box<TaskModel>('TaskModel').values.toList();
  late List<TaskModel> todomodellistdisplay =
      List<TaskModel>.from(todomodelist);
  List<EventModel> todoEventlist =
      Hive.box<EventModel>('EventModel').values.toList();
  late List<EventModel> todoEventlistdisplay =
      List<EventModel>.from(todoEventlist);
  final index = [];
  List<TaskModel> _gettask(DateTime date) {
    // ignore: unnecessary_null_comparison
    if (todomodelist.where((element) => element.taskDate != null).isNotEmpty) {
      return todomodelist
          .where((element) => element.taskDate == element.taskDate)
          .toList();
    } else {
      return [];
    }
    // todomodellistdisplay = todomodelist.where((element) {
    //   return DateTime.parse(element.taskDate.toString()).day ==
    //           _selectedDay!.day &&
    //       DateTime.parse(element.taskDate.toString()).month ==
    //           _selectedDay!.month &&
    //       DateTime.parse(element.taskDate.toString()).year ==
    //           _selectedDay!.year;
    // }).toList();
    // return todomodellistdisplay;
  }

  DateTime today = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  @override
  void initState() {
    _selectedDay = _focusedDay;
    taskAndEvents();
    super.initState();
  }

  CalendarFormat format = CalendarFormat.month;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: globalColor(),
            child: Column(
              children: [
                TableCalendar(
                  // eventLoader: _gettask,
                  calendarFormat: format,
                  focusedDay: today,
                  onFormatChanged: (CalendarFormat _format) {
                    setState(() {
                      format = _format;
                      taskAndEvents();
                    });
                  },
                  firstDay: DateTime.utc(2010, 10, 11),
                  lastDay: DateTime.utc(2030, 3, 14),
                  headerStyle: const HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: true,
                      formatButtonShowsNext: false),
                  availableGestures: AvailableGestures.all,
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      taskAndEvents();
                      // update `_focusedDay` here as well
                    });
                  },
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                ),
                DefaultTabController(
                  length: 2,
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: 50,
                        color: Colors.green,
                        child: const TabBar(tabs: [
                          Tab(icon: Icon(Icons.task)),
                          Tab(icon: Icon(Icons.event))
                        ]),
                      ),
                      SizedBox(
                        //Add this to give height
                        height: MediaQuery.of(context).size.height,
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: SearchTask(
                                  prioritys: prioritys,
                                  passvalue: todomodellistdisplay),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: SearchEvent(
                                  prioritys: prioritys,
                                  eventList: todoEventlistdisplay),
                            )
                          ],
                        ),
                      ),
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

  taskAndEvents() {
    setState(() {
      todomodellistdisplay = todomodelist.where((element) {
        return DateTime.parse(element.taskDate.toString()).day ==
                _selectedDay?.day &&
            DateTime.parse(element.taskDate.toString()).month ==
                _selectedDay?.month &&
            DateTime.parse(element.taskDate.toString()).year ==
                _selectedDay?.year;
      }).toList();
      todoEventlistdisplay = todoEventlist.where((element) {
        return DateTime.parse(element.eventDate.toString()).day ==
                _selectedDay?.day &&
            DateTime.parse(element.eventDate.toString()).month ==
                _selectedDay?.month &&
            DateTime.parse(element.eventDate.toString()).year ==
                _selectedDay?.year;
      }).toList();
    });
  }
}
