import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TextWidget extends StatelessWidget {
  FontWeight? fontWeight;
  double? fontsize;
  Color? color;
  String text;
  TextWidget(
      {super.key,
      required this.text,
      this.color,
      this.fontsize,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lato(
        textStyle: TextStyle(
          fontSize: fontsize,
          fontWeight: fontWeight,
        ),
        color: color,
      ),
    );
  }
}
