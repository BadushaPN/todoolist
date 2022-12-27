import 'package:flutter/material.dart';
import 'package:todoolist/widgets/bottom_navigation_bar.dart';

class TaskAddingDoneDiscard extends StatelessWidget {
  Function()? onPressed;
  TaskAddingDoneDiscard({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const MyBottomNavigationBar()),
                  (route) => false);
            },
            child: const Icon(Icons.close),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(),
            onPressed: onPressed,
            child: const Icon(Icons.done),
          ),
        ],
      ),
    );
  }
}
