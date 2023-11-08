// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
    return Container(
      height: 125,
      width: 400,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // profile image

          SizedBox(
            width: 125,
            child: Lottie.asset(LottieAssetUrl),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 25, right: 25),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    bodyText,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Read More..',
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
