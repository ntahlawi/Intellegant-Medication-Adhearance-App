import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class DietCard extends StatefulWidget {
  final String meal; 
  final String portion;
  final String calories; 

  const DietCard({
    super.key,
    required this.meal,
    required this.portion,
    required this.calories,
  });

  @override
  State<DietCard> createState() => _DietCardState();
}


class _DietCardState extends State<DietCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.1,
      width: SizeConfig.screenWidth * 0.75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24), 
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.04), 
            child: Image.asset(
              // Replace with meal specific icon path if desired
              'lib/icons/diet.png',
              width: SizeConfig.screenWidth * 0.2, 
              height: SizeConfig.screenWidth * 0.2,
            ),
          ),
          SizedBox(width: SizeConfig.screenWidth * 0.04), 
          Expanded( // Let the column have available space
            child: Padding(
              padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.01), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  Text(widget.meal, style: Theme.of(context).textTheme.headline6),
                  Text(widget.portion, style: Theme.of(context).textTheme.bodyMedium), 
                ],
              ),
            ),
          ),
          SizedBox(width: SizeConfig.screenWidth * 0.075), 
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.015), 
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
            padding: EdgeInsets.only(right: SizeConfig.screenWidth * 0.04),
            child: Text(
              widget.calories, 
              style: TextStyle(fontSize: SizeConfig.screenWidth * 0.06),
            ),
          ), 
        ],
      ),
    );
  }
}
