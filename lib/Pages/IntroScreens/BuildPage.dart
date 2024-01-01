// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class BuildOBpage extends StatefulWidget {
  final String urlImage;
  final String title;
  final String subtitle;
  const BuildOBpage({
    super.key,
    required this.subtitle,
    required this.title,
    required this.urlImage,
  });

  @override
  State<BuildOBpage> createState() => _BuildOBpageState();
}

class _BuildOBpageState extends State<BuildOBpage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.urlImage,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            SizedBox(
              height: SizeConfig.pointThreeHeight,
            ),
            Text(
              widget.title,
              style: TextStyle(
                  color: Theme.of(context).textTheme.titleSmall!.color,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: SizeConfig.pointThreeHeight,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05),
              child: Text(
                widget.subtitle,
                style: TextStyle(
                    color: Theme.of(context).textTheme.titleSmall!.color),
              ),
            )
          ],
        ),
      ),
    );
  }
}
