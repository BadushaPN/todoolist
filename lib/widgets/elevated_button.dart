// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:todoolist/widgets/text_widget.dart';

class ElevatedButtons extends StatelessWidget {
  String? text;
  double? width;
  double? height;
  Function()? onPressed;
  ElevatedButtons(
      {super.key, required this.onPressed, this.height, this.width, this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Container(
        width: width ?? 70,
        height: height ?? 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: TextWidget(
            text: text ?? 'Done',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
