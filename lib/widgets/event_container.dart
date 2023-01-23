// import 'dart:ffi';
// import 'dart:io';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:todoolist/colo/color.dart';
import 'package:todoolist/db/db_function.dart';
import 'package:todoolist/model/data_model.dart';
import 'package:todoolist/services/notification_service.dart';
import 'package:todoolist/widgets/event_add_bottomsheet.dart';
import 'package:todoolist/widgets/event_edit_bottom_sheet.dart';
import 'package:todoolist/widgets/task_list_container.dart';
import 'package:todoolist/widgets/text_widget.dart';

DateTime notifyeventtime = DateTime.now();
DateTime notifyeventdate = DateTime.now();
// List<TaskModel> upcomingtask = [];
EventModel? notifydataEvnt;

class EventContainer extends StatelessWidget {
  const EventContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> prioritys = [
      PrioirtyIcons(colors: Colors.red),
      PrioirtyIcons(colors: Colors.orange),
      PrioirtyIcons(colors: Colors.green)
    ];
    getAllEvents();
    checkTimeNotificationEvent();
    return Container(
      decoration: BoxDecoration(
        color: globalColor(),
        borderRadius: BorderRadius.circular(15),
      ),
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: ValueListenableBuilder(
        valueListenable: eventListNotifier,
        builder: (context, List<EventModel> eventLists, Widget? child) {
          getAllEvents();
          // List<EventModel> eventList = eventLists
          //     .where((element) => element.eventDate
          //         .isAfter(DateTime.now().subtract(const Duration(days: 1))))
          //     .toList();
          List<EventModel> eventList = eventLists.where((element) {
            return DateTime.parse(element.eventDate.toString()).day ==
                    DateTime.now().day &&
                DateTime.parse(element.eventDate.toString()).month ==
                    DateTime.now().month &&
                DateTime.parse(element.eventDate.toString()).year ==
                    DateTime.now().year;
          }).toList();
          return eventList.isNotEmpty
              ? GridView.count(
                  physics: const ScrollPhysics(),
                  crossAxisCount: 1,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: List.generate(eventList.length, (index) {
                    List<EventModel> sortedEventList = eventList
                      ..sort(
                        (a, b) => a.eventDate.compareTo(b.eventDate),
                      );
                    final data = sortedEventList[index];

                    for (int i = 0; i < sortedEventList.length; i++) {
                      final sortedtaskLists = sortedEventList[index];
                      print(sortedtaskLists.eventName);
                      notifyeventtime = sortedtaskLists.eventTime;
                      notifyeventdate = sortedtaskLists.eventDate;
                      notifydataEvnt = sortedtaskLists;
                      print(notifytime);
                    }
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
                          deleteAlert(context, index, data);
                        },
                        child: EventBlock(data: data, prioritys: prioritys),
                      ),
                    );
                  }),
                )
              : Center(
                  child: TextWidget(
                    text: 'No events',
                    fontWeight: FontWeight.w500,
                    fontsize: 30,
                    color: Colors.black38,
                  ),
                );
        },
      ),
    );
  }

  deleteAlert(BuildContext context, id, EventModel value) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: const Text('Are you sure you want to delete'),
        actions: [
          TextButton(
              onPressed: () {
                deleteEvent(id);
                Navigator.of(context).pop(ctx);
                Fluttertoast.showToast(
                  msg: "'${value.eventName}'  Deleted",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 2,
                  textColor: Colors.white,
                  backgroundColor: Colors.black,
                  fontSize: 12,
                );
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
      ),
    );
  }
}

class EventBlock extends StatelessWidget {
  const EventBlock({
    super.key,
    required this.data,
    required this.prioritys,
  });

  final EventModel data;
  final List<Widget> prioritys;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5),
      child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Expanded(
                  child: ClipRect(
                    child: data.image == null
                        ? Image.asset('lib/assests/Events.jpg')
                        : Image.file(File(data.image!)),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            TextWidget(
                              text: data.eventName,
                              fontWeight: FontWeight.w900,
                            ),
                            TextWidget(
                              text: '',
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            prioritys[data.toggle],
                            TextWidget(
                              text: DateFormat('dd-MMM-yyyy')
                                  .format(data.eventDate),
                              fontsize: 9,
                              color: Colors.black,
                            ),
                            TextWidget(
                              text:
                                  DateFormat('hh:mm a').format(data.eventTime),
                              fontsize: 9,
                              color: Colors.black,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
