// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class settingscard extends StatelessWidget {
  const settingscard({
    super.key,
    required this.cardtext,
    required this.icon,
  });

  final String cardtext;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      height: SizeConfig.screenHeight * 0.05,
      width: SizeConfig.screenWidth * 0.875,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            cardtext,
            style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .color!
                    .withOpacity(.8),
                fontSize: SizeConfig.screenWidth * 0.04,
                fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.005),
            child: Icon(
              icon,
              size: SizeConfig.screenWidth * 0.0675,
              color: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .color!
                  .withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
