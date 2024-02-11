// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class DateCard extends StatefulWidget {
  final String Date;
  final String month;
  final bool isSelected; // Add this line
  final VoidCallback onTap; // New line

  const DateCard({
    super.key,
    required this.Date,
    required this.month,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<DateCard> createState() => _DateCardState();
}

class _DateCardState extends State<DateCard> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: widget.onTap, // New line
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
          ),
        ),
        height: SizeConfig.screenHeight * 0.08,
        width: SizeConfig.screenWidth * 0.12,
        child: Column(
          children: [
            Text(
              widget.Date,
              style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: SizeConfig.screenWidth * 0.065,
                  fontWeight: FontWeight.w100),
            ),
            Text(
              widget.month,
              style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
 // check for medication interaction
                      // add button with selections
                      // show card on top
                      // adding info and updating the database after
                      // update the screen