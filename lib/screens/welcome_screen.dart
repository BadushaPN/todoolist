// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoolist/main.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:todoolist/colo/color.dart';
// import 'package:todoolist/screens/home_screen.dart';
import 'package:todoolist/widgets/bottom_navigation_bar.dart';
import 'package:todoolist/widgets/elevated_button.dart';
import 'package:todoolist/widgets/text_form_fields.dart';
import 'package:todoolist/widgets/text_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Welcome(),
            const Image(),
            const EnterYourName(),
            TextFormFields(myController: textController),
            ElevatedButtons(onPressed: () async {
              setState(() {
                setUserName(textController.text);
              });
            }),
          ],
        ),
      ),
    );
  }

  Future<void> setUserName(notValue) async {
    // await Future.delayed(const Duration(seconds: 3));
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('userName', notValue);
    if (notValue == null) {
      return;
    } else {
      // await Future.delayed(const Duration(seconds: 3));
      // ignore: use_build_context_synchronously
      await Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
        return const MyBottomNavigationBar();
      }));
    }
  }
}

getUserName() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  userName = pref.getString('userName')!;
  print(userName);
}

class Welcome extends StatelessWidget {
  const Welcome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Center(
        child: TextWidget(
          text: 'Welcome',
          fontsize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class EnterYourName extends StatelessWidget {
  const EnterYourName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextWidget(
      text: 'Enter your name',
      fontsize: 20,
      fontWeight: FontWeight.bold,
    );
  }
}

class Image extends StatelessWidget {
  const Image({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.12,
      height: 250,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('lib/assests/24770.jpg'), fit: BoxFit.fill),
      ),
    );
  }
}
