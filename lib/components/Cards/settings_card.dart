import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class SettingsCard extends StatelessWidget {
  final String cardText; 
  final IconData icon;

  const SettingsCard({
    super.key,
    required this.cardText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); 

    return Container(
      height: SizeConfig.screenHeight * 0.05,
      width: SizeConfig.screenWidth * 0.875,
      color: Colors.transparent, // Keep background transparent
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            cardText,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith( // Use theme styles
              color: Theme.of(context) 
                     .textTheme.titleSmall! 
                     .color!
                     .withOpacity(0.8),
              fontSize: SizeConfig.screenWidth * 0.04,
              fontWeight: FontWeight.w500,
            ),
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
