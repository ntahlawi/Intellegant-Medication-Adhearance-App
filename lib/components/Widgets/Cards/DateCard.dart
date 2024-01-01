// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

class DateCard extends StatelessWidget {
  final String Date;
  final String month;
  final bool isSelected; // Add this line
  const DateCard(
      {super.key,
      required this.Date,
      required this.month,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Theme.of(context)
                    .colorScheme
                    .primary // Set the border color for selected date
                : Colors.transparent,
          )),
      height: 85,
      width: 60,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              Date,
              style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.w100),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            month,
            style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
