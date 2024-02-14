import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class MedCard extends StatefulWidget {
  final String medName;
  final String dosage;
  final String time;

  const MedCard({
    super.key,
    required this.medName,
    required this.dosage,
    required this.time,
  });

  @override
  State<MedCard> createState() => _MedCardState();
}

class _MedCardState extends State<MedCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.1, // Dynamic card height
      width: SizeConfig.screenWidth * 0.75, // Dynamic card width
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Theme.of(context).colorScheme.secondary, // Theme-based color
      ),
      child: Row(
        children: [
          Padding( 
            padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.04), // Dynamic left padding
            child: Image.asset(
              'lib/icons/hemoglobin.png', // Replace with specific medicine icon
              width: SizeConfig.screenWidth * 0.175,
              height: SizeConfig.screenHeight * 0.1, 
            ),
          ),
          SizedBox(width: SizeConfig.screenWidth * 0.04), // Dynamic spacing
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.01), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align text left
              children: [
                Text(widget.medName, style: Theme.of(context).textTheme.bodySmall), // Emphasize the med name
                Text(widget.dosage, style: Theme.of(context).textTheme.bodyMedium), 
              ],
            ),
          ),
          SizedBox(width: SizeConfig.screenWidth * 0.075), 
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.015), // Dynamic vertical padding
            child: VerticalDivider(
              thickness: 2,
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(.75), 
            ),
          ),
          Padding( 
            padding: EdgeInsets.only(right: SizeConfig.screenWidth * 0.02), // Optional right padding
            child: Text(widget.time, style: Theme.of(context).textTheme.titleSmall), 
          ),
        ],
      ),
    );
  }
}
