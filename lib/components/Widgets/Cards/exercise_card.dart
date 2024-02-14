import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class ExerciseCard extends StatefulWidget {
  final String exerciseName; 
  final String duration; 
  final String caloriesBurned;

  const ExerciseCard({
    super.key,
    required this.exerciseName,
    required this.duration,
    required this.caloriesBurned,
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
          Padding( 
            padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.04), 
            child: Image.asset(
              'lib/icons/exercise.png', 
              width: SizeConfig.screenWidth * 0.175, 
              height: SizeConfig.screenWidth * 0.175, 
            ),
          ),
          SizedBox(width: SizeConfig.screenWidth * 0.04),
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.005), // Reduced vertical padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Text(widget.exerciseName, style: Theme.of(context).textTheme.headline6), 
                Text(widget.duration, style: Theme.of(context).textTheme.bodyMedium), 
              ],
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
          Padding( // Optional adjustment if desired
            padding: EdgeInsets.only(right: SizeConfig.screenWidth * 0.02), 
            child: Text(widget.caloriesBurned, style: Theme.of(context).textTheme.headline6), 
          ),
        ],
      ),
    );
  }
}
