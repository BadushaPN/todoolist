import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todoolist/colo/color.dart';
import 'package:todoolist/widgets/uppercase_text_format.dart';

class TextFormFieldsEdit extends StatelessWidget {
  int? maxlines;
  String? hintTexts;
  double? height;
  TextEditingController myController;
  TextFormFieldsEdit({
    super.key,
    required this.myController,
    this.height,
    this.hintTexts,
    this.maxlines,
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
