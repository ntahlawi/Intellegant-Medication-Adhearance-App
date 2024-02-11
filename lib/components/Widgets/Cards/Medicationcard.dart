import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class MedCard extends StatefulWidget {
  final String medName;
  final String time;
  final String dosage;
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
                'lib/icons/hemoglobin.png',
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
                // medication name
                Text(widget.medName),
                //when and what dose
                Text(widget.dosage),
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
          Text(widget.time),
        ],
      ),
    );
  }
}
