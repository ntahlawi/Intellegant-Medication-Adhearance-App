// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class FeedCard extends StatelessWidget {
  final String bodyText;
  final String titleText;
  final String LottieAssetUrl;

  const FeedCard({
    super.key,
    required this.LottieAssetUrl,
    required this.titleText,
    required this.bodyText,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      height: SizeConfig.screenHeight * 0.1425,
      width: SizeConfig.screenWidth * 0.085,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // profile image

          SizedBox(
            width: SizeConfig.screenWidth * 0.25,
            child: Lottie.asset(LottieAssetUrl),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: SizeConfig.screenHeight * 0.02,
                right: SizeConfig.screenWidth * 0.02,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleText,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  Text(
                    bodyText,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.015,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'See More..',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
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
