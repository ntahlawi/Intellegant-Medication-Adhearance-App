// ignore_for_file: file_names, non_constant_identifier_names

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class ReminderCard extends StatelessWidget {
  final String bodyText;
  final String bodyText2;

  final String titleText;
  final String LottieAssetUrl;

  const ReminderCard({
    super.key,
    required this.LottieAssetUrl,
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
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // profile image

          SizedBox(
            width: 100,
            child: Lottie.network(LottieAssetUrl),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.screenHeight * 0.01,
                  right: SizeConfig.screenWidth * 0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleText,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Row(
                    children: [
                      Text(
                        bodyText,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.015),
                  Row(
                    children: [
                      Icon(
                        EvaIcons.clockOutline,
                        color:
                            Theme.of(context).iconTheme.color!.withOpacity(0.5),
                      ),
                      Text(
                        bodyText2,
                        style: TextStyle(
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
