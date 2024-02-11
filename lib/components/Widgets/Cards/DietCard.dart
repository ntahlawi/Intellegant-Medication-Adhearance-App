import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class DietCard extends StatefulWidget {
  final String Meal;
  final String Portion;
  final String Calories;
  const DietCard({
    super.key,
    required this.Meal,
    required this.Portion,
    required this.Calories,
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
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: SizeConfig.pointThreeWidth),
              child: Image.asset(
                'lib/icons/diet.png',
                width: SizeConfig.screenWidth * 0.175,
                height: SizeConfig.screenHeight * 0.175,
              ),
            ),
          ),
          SizedBox(
            width: SizeConfig.pointThreeWidth,
          ),
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.pointThreeHeight),
            child: Column(
              children: [
                // MEAL name
                Text(widget.Meal),
                //when and what PORTION
                Text(widget.Portion),
              ],
            ),
          ),
          SizedBox(
            width: SizeConfig.screenWidth * 0.075,
          ),
          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.pointFifteenHeight,
                bottom: SizeConfig.pointFifteenHeight),
            child: VerticalDivider(
              thickness: 2,
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(.75),
            ),
          ),
          Text(widget.Calories),
        ],
      ),
    );
  }
}
