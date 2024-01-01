// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types

import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class categorycard extends StatelessWidget {
  final imageUrl1;
  final String categoryname;
  const categorycard(
      {super.key, required this.imageUrl1, required this.categoryname});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Padding(
      padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.06),
      child: Container(
        padding: EdgeInsets.all(
          (SizeConfig.screenWidth * 0.015) + (SizeConfig.screenHeight * 0.015),
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.asset(
              imageUrl1,
              color: Theme.of(context).colorScheme.background,
            ),
            SizedBox(
              width: SizeConfig.screenWidth * 0.02,
            ),
            Text(categoryname),
          ],
        ),
      ),
    );
  }
}
