import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class ReminderCardSmall extends StatelessWidget {
  final IconData lottieAssetUrl; // Suitable for simple icons 
  final String duration;

  const ReminderCardSmall({
    super.key,
    required this.lottieAssetUrl,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // Initialize your sizing class

    return Container(
      height: SizeConfig.screenHeight * 0.12,
      width: SizeConfig.screenWidth * 0.17,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12), 
      ),
      child: Padding(
        padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.04), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center column's content
          children: [
            Icon(lottieAssetUrl, color: Theme.of(context).colorScheme.onPrimary), // Match theme
            SizedBox(height: SizeConfig.screenHeight * 0.03), 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  duration,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith( //  Consistent styling
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ), 
                ),
                SizedBox(width: SizeConfig.screenWidth * 0.005), 
                Text(
                  'Min', 
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
