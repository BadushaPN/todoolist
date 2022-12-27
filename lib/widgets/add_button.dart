import 'package:flutter/material.dart';
import 'package:todoolist/widgets/text_widget.dart';

class AddButton extends StatelessWidget {
  Function()? onPressed;
  String text;
  AddButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(foregroundColor: Colors.black),
      child: Row(
        children: [
          TextWidget(
            text: text,
            fontWeight: FontWeight.w700,
          ),
          const Icon(
            Icons.add,
            size: 14,
          )
        ],
      ),
    );
  }
}
