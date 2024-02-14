import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class DateCard extends StatefulWidget {
  final String date; // Day number
  final String month;
  final bool isSelected; 
  final VoidCallback onTap; 

  const DateCard({
    super.key,
    required this.date,
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
      onTap: widget.onTap, // Respond to taps 
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent, // Keep background transparent
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            // Dynamic border based on selection status
            color: widget.isSelected
                ? Theme.of(context).colorScheme.primary 
                : Colors.transparent, 
          ),
        ),
        height: SizeConfig.screenHeight * 0.08,
        width: SizeConfig.screenWidth * 0.12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center text vertically
          children: [
            Text(
              widget.date, 
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: SizeConfig.screenWidth * 0.065,
                fontWeight: FontWeight.w100, 
              ),
            ),
            Text(
              widget.month,
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}