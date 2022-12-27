import 'package:flutter/material.dart';
import 'package:todoolist/widgets/text_widget.dart';

class DateTimeTextWidget extends StatelessWidget {
  const DateTimeTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextWidget(text: 'Date'),
        TextWidget(text: 'Time'),
      ],
    );
  }
}
