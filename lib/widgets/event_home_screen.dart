import 'package:flutter/material.dart';
import 'package:todoolist/widgets/add_event_button.dart';

import 'event_container.dart';

class EventHomeScreen extends StatelessWidget {
  const EventHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: const [
          EventsAddButtonAndEventsTextWidget(),
          EventContainer(),
        ],
      ),
    );
  }
}
