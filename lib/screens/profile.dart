// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todoolist/colo/color.dart';
import 'package:todoolist/widgets/profile_widget.dart';
import 'package:todoolist/widgets/setting_pops.dart';
import 'package:todoolist/widgets/text_widget.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:yourtodo2/Widgets/ProfileWidgets/profileWidgets.dart';

// import '../../Widgets/CustomAppBar/customAppBar.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  final content = [
    'Settings',
    'Privacy and Policies',
    'About',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget(
          text: 'TodooList',
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Container(
          color: globalColor(),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.info_outline_rounded,
                  // color: Colors.black,
                  // size: 28,
                ),
                title: const Text(
                  'About',
                  // style: TextStyle(color: Colors.black, fontSize: 22),
                ),
                onTap: () => showAboutDialog(
                  context: context,
                  applicationName: "TodooList",
                  applicationVersion: '1.0',
                  // applicationIcon: Image.asset(
                  //   'assets/images/download.png',
                  //   height: 40,
                  //   width: 40,
                  // ),
                  children: [
                    const Text(
                        "TodooList. A kind of app that generally used to maintain our day-to-day tasks and schedule events. It is helpful in planning our daily routines and events and always reminds you with notification"),
                    const SizedBox(height: 18),
                    Row(
                      children: const [
                        Text("App developed by "),
                        Text(
                          'Badusha',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        Text('.')
                      ],
                    )
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.policy_outlined,
                  // color: Wh,
                  // size: 28,
                ),
                title: const Text(
                  'Privacy Policy',
                  // style: TextStyle(color: White(), fontSize: 22),
                ),
                onTap: () => showDialog(
                  context: context,
                  builder: (builder) {
                    // return SizedBox();
                    return settingmenupopup(mdFilename: 'privacy_policy.md');
                  },
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.library_books_outlined,
                  // color: White(),
                  // size: 28,
                ),
                title: const Text(
                  'Terms And Conditions',
                  // style: TextStyle(color: White(), fontSize: 22),
                ),
                onTap: () => showDialog(
                  context: context,
                  builder: (builder) {
                    // return SizedBox();
                    return settingmenupopup(
                        mdFilename: 'terms_and_conditions.md');
                  },
                ),
              ),
              ListTile(
                  leading: const Icon(
                    Icons.share_outlined,
                    // color: White(),
                    // size: 28,
                  ),
                  title: const Text(
                    'Share',
                    // style: TextStyle(color: White(), fontSize: 22),
                  ),
                  onTap: () => {}
                  // Share.share(" ",
                  //       subject: "Github Repo Of This App"),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
