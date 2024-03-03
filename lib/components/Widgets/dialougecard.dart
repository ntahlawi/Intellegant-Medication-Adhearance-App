import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showErrorDialog({
  required BuildContext context,
  required String title,
  required String content,
  required TextStyle style,
  required  btncolor,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title, // Customizable title
          style: TextStyle(
            color: Theme.of(context).textTheme.titleLarge!.color!,
          ),
        ),
        content: Text(content, // Customizable content
            style: style),
        actions: [
          TextButton(
            child: Text(
              "Got it!",
              style: TextStyle(
                color: btncolor,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
    },
  );
}
