// ignore: must_be_immutable
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:todoolist/colo/color.dart';
import 'package:todoolist/widgets/uppercase_text_format.dart';

class TextFormFields extends StatelessWidget {
  // List<TextInputFormatter> inputFormatters;
  int? maxlines;
  String? hintTexts;
  double? height;
  TextEditingController myController;
  TextFormFields({
    super.key,
    required this.myController,
    this.height,
    this.hintTexts,
    this.maxlines,
    // required this.inputFormatters this.this
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: height ?? 60,
        decoration: BoxDecoration(
            color: globalColor(), borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextFormField(
            inputFormatters: [UpperCaseTextFormatter()],
            maxLines: maxlines,
            controller: myController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintTexts ?? 'Name',
            ),
          ),
        ),
      ),
    );
  }
}
