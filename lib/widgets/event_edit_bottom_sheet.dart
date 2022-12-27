import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:todoolist/colo/color.dart';
import 'package:todoolist/db/date_time_function.dart';
import 'package:todoolist/db/db_function.dart';
import 'package:todoolist/model/data_model.dart';
import 'package:todoolist/widgets/bottom_navigation_bar.dart';
import 'package:todoolist/widgets/date_time_text_widgets.dart';
import 'package:todoolist/widgets/full_image_show.dart';
import 'package:todoolist/widgets/task_adding_done_discard.dart';
// import 'package:todoolist/widgets/text_form_fields.dart';
import 'package:todoolist/widgets/text_form_fields_edit.dart';
import 'package:todoolist/widgets/text_widget.dart';

class EventEditScreen extends StatefulWidget {
  final EventModel passvalue;
  const EventEditScreen({super.key, required this.passvalue});

  @override
  State<EventEditScreen> createState() => _EventEditScreenState();
}

class _EventEditScreenState extends State<EventEditScreen> {
  late DateTime currentDate = widget.passvalue.eventDate;

  late DateTime currentTime = widget.passvalue.eventTime;

  late final _eventNameController =
      TextEditingController(text: widget.passvalue.eventName);
  late final _eventDescriptionController =
      TextEditingController(text: widget.passvalue.eventDescription);
  String? image;
  late int? newindex = widget.passvalue.toggle;
  List<bool> isSelected = [false, false, false];
  @override
  void initState() {
    super.initState();
    isSelected[widget.passvalue.toggle] = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            color: blueColor(), borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return FullImage(image: widget.passvalue.image);
                          }));
                        },
                        child: Container(
                          color: Colors.black87,
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          child: ClipRect(
                            clipBehavior: Clip.antiAlias,
                            child: widget.passvalue.image == null
                                ? Image.asset('lib/assests/Events.jpg')
                                : Image.file(File(widget.passvalue.image!)),
                          ),
                        ),
                      ),
                      // CircleAvatar(
                      //   backgroundImage: image == null
                      //       ? FileImage(File(widget.passvalue.image))
                      //       : FileImage(File(image!)),
                      //   radius: 80,
                      // ),
                      Positioned(
                        left: MediaQuery.of(context).size.width / 1.4,
                        bottom: 5,
                        child: InkWell(
                          onTap: () async {
                            await getImage();
                          },
                          child: const Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.camera_alt,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextWidget(text: 'Event'),
                ),
                TextFormFieldsEdit(
                  myController: _eventNameController,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextWidget(text: 'Event Description'),
                ),
                TextFormFieldsEdit(
                  myController: _eventDescriptionController,
                  maxlines: 3,
                  height: 120,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: DateTimeTextWidget(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        DatePicker(context).then(
                          (date) {
                            if (date == null) {
                              return;
                            }
                            setState(
                              () {
                                print('Date');
                                currentDate = date;
                              },
                            );
                          },
                        );
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              text:
                                  DateFormat('dd-MMM-yyyy').format(currentDate),
                              fontsize: 12,
                            ),
                            const Icon(Icons.calendar_month)
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        TimePicker(context).then(
                          (time) {
                            if (time == null) {
                              return;
                            }
                            final newTime = DateTime(
                                currentDate.day,
                                currentDate.year,
                                currentDate.month,
                                time.hour,
                                time.minute);

                            setState(
                              () {
                                currentTime = newTime;
                              },
                            );
                          },
                        );
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              text: DateFormat('hh:mm a').format(currentTime),
                              fontsize: 12,
                            ),
                            const Icon(Icons.lock_clock_outlined)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Center(
                    child: ToggleButtons(
                      borderRadius: BorderRadius.circular(10),
                      isSelected: isSelected,
                      onPressed: (newIndex) {
                        setState(
                          () {
                            // looping through the list of booleans values
                            for (int index = 0;
                                index < isSelected.length;
                                index++) {
                              // checking for the index value
                              if (index == newIndex) {
                                newindex = newIndex;
                                // one button is always set to true
                                print(newIndex);
                                isSelected[index] = true;
                              } else {
                                // other two will be set to false and not selected
                                isSelected[index] = false;
                              }
                            }
                          },
                        );
                      },
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'HIGH',
                            style: TextStyle(
                                fontSize: 12, color: Colors.redAccent),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text('MEDIUM',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.orangeAccent)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text('LOW',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.greenAccent)),
                        ),
                      ],
                    ),
                  ),
                ),
                TaskAddingDoneDiscard(
                  onPressed: () {
                    editEventeButtonClick(
                        widget.passvalue.id, context, widget.passvalue);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) =>
                                const MyBottomNavigationBar()),
                        (route) => false);

                    // Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = pickedFile.path;
      });
    }
  }

  editEventeButtonClick(index, context, EventModel value) async {
    final _eventName = _eventNameController.text.trim();
    final _eventDescription = _eventDescriptionController.text.trim();
    final _eventDate = currentDate;
    final _eventTime = currentTime;
    final _toggle = newindex;
    final _id = DateTime.now().toString();
    if (_eventName.isEmpty) {
      return;
    }
    final _events = EventModel(
        toggle: _toggle ?? widget.passvalue.toggle,
        eventName: _eventName,
        eventDescription: _eventDescription,
        eventDate: _eventDate,
        image: image ?? widget.passvalue.image,
        eventTime: _eventTime,
        id: _id);
    print('$_eventName');
    print('add');
    editEvents(index, context, _events);
  }
}
