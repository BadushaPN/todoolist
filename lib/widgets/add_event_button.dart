import 'package:flutter/material.dart';
import 'package:todoolist/widgets/add_button.dart';
import 'package:todoolist/widgets/event_add_bottomsheet.dart';
// import 'package:todoolist/widgets/task_adding_bottom_sheet.dart';
// import 'package:todoolist/screens/home_screen.dart';
import 'package:todoolist/widgets/text_widget.dart';

class EventsAddButtonAndEventsTextWidget extends StatelessWidget {
  const EventsAddButtonAndEventsTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
          text: 'Events',
          fontWeight: FontWeight.w700,
        ),
        AddButton(
          text: 'Add event',
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return EventAddBottomSheet();
                });
          },
        ),
      ],
    );
  }
}
