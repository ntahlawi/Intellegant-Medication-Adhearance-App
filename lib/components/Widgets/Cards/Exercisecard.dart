import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class ExerciseCard extends StatefulWidget {
  final String ExerciseName;
  final String Time;
  final String exBurnedCalories;
  const ExerciseCard({
    super.key,
    required this.ExerciseName,
    required this.Time,
    required this.exBurnedCalories,
  });

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
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
                'lib/icons/apple.png',
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
                Text(widget.ExerciseName),
                //when and what PORTION
                Text(widget.Time),
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
          Text(widget.exBurnedCalories),
        ],
      ),
    );
  }
}
