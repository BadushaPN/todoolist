import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoolist/db/db_function.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:todoolist/colo/color.dart';
import 'package:todoolist/main.dart';
import 'package:todoolist/model/data_model.dart';
import 'package:todoolist/screens/search_screen.dart';
import 'package:todoolist/screens/welcome_screen.dart';
import 'package:todoolist/services/notification_service.dart';
import 'package:todoolist/widgets/event_home_screen.dart';

import 'package:todoolist/widgets/text_widget.dart';

import '../widgets/task_home_screen copy.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // dynamic _value;

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    // getUserName();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<dynamic>(
            future: getUserName(),
            builder: (
              BuildContext context,
              AsyncSnapshot<dynamic> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return Column(
                    children: [
                      UserName(userName: userName.trim()),
                      const WeekBalance(),
                      const EventHomeScreen(),
                      const TasksHomeScreen()
                    ],
                  );
                } else {
                  return const SingleChildScrollView(
                    child: Column(
                      children: [
                        UserNameAndSearchButton(),
                        WeekBalance(),
                        EventHomeScreen(),
                        TasksHomeScreen(),
                      ],
                    ),
                  );
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          ),
        ),
      ),
    );
  }
}

class UserNameAndSearchButton extends StatelessWidget {
  const UserNameAndSearchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        UserName(userName: userName.trim()),
        const SizedBox(
          width: 55,
        ),
        IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const SearchScreen();
                  },
                ),
              );
            },
            icon: const Icon(Icons.search))
      ],
    );
  }
}

class TodayTaskText extends StatefulWidget {
  const TodayTaskText({
    super.key,
  });

  @override
  State<TodayTaskText> createState() => _TodayTaskTextState();
}

class _TodayTaskTextState extends State<TodayTaskText> {
  @override
  Widget build(BuildContext context) {
    return TextWidget(
      text: 'Tasks',
      fontWeight: FontWeight.w700,
    );
  }
}

class WeekBalance extends StatelessWidget {
  const WeekBalance({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextWidget(
        text: 'How is your work life balance this week?',
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class UserName extends StatelessWidget {
  const UserName({
    super.key,
    required this.userName,
  });

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(
          text: 'Hello ',
          fontWeight: FontWeight.w500,
          fontsize: 30,
        ),
        TextWidget(
          text: '$userName!',
          fontWeight: FontWeight.w700,
          fontsize: 30,
        ),
      ],
    );
  }
}
