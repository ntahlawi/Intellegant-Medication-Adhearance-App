import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class ReminderCard extends StatelessWidget {
  final String bodyText;
  final String bodyText2;
  final String titleText;
  final String lottieAssetUrl; 

  const ReminderCard({
    super.key,
    required this.lottieAssetUrl,
    required this.titleText,
    required this.bodyText,
    required this.bodyText2,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Container(
      height: SizeConfig.screenHeight * 0.1,
      width: SizeConfig.screenWidth * 0.75,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
          SizedBox(
            width: 100, // Ensure Lottie anim has consistent space 
            child: Lottie.network(lottieAssetUrl),
          ),
          Expanded( 
            child: Padding(
              padding: EdgeInsets.only(
                top: SizeConfig.screenHeight * 0.01, 
                right: SizeConfig.screenWidth * 0.01,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleText,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith( // Emphasize title
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontWeight: FontWeight.bold,
                    ), 
                  ),
                  Text( // Consider wrapping in Expanded/Flexible in case of longer text
                    bodyText,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.015), 
                  Row(
                    children: [
                      Icon(
                        EvaIcons.clockOutline,
                        color: Theme.of(context) 
                               .iconTheme.color!
                               .withOpacity(0.5), // Softened clock icon
                      ),
                      SizedBox(width: SizeConfig.screenWidth * 0.01), // Consistent spacing
                      Text(
                        bodyText2,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith( 
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
