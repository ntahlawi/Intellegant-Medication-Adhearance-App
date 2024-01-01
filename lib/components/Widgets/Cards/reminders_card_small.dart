// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class ReminderCardsmall extends StatelessWidget {
  final String Duration;
  final IconData LottieAssetUrl;

  const ReminderCardsmall({
    super.key,
    required this.LottieAssetUrl,
    required this.Duration,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      height: SizeConfig.screenHeight * 0.12,
      width: SizeConfig.screenWidth * 0.17,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.04),
        child: Column(
          children: [
            Icon(LottieAssetUrl),
            SizedBox(
              height: SizeConfig.screenHeight * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Duration,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.005,
                ),
                Text(
                  'Minutes',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
