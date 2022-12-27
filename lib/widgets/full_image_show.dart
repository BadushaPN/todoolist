import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FullImage extends StatelessWidget {
  String? image;
  FullImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black87,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ClipRect(
            clipBehavior: Clip.antiAlias,
            child: image == null
                ? Image.asset('lib/assests/Events.jpg')
                : Image.file(File(image!)),
          ),
        ),
      ),
    );
  }
}
