import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:todoolist/widgets/text_widget.dart';
// import 'package:yourtodo2/Widgets/Texts/texts.dart';

class ProfileWidgets extends StatelessWidget {
  final String content;

  const ProfileWidgets({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextWidget(text: content),
    );
  }
}
