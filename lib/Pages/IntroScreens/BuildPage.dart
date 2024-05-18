// ignore_for_file: file_names

import 'package:auto_size_text/auto_size_text.dart';
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
      backgroundColor: Theme.of(context).colorScheme.surface,
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
            AutoSizeText(
              widget.title,
              maxLines: 1,
              minFontSize: 32,
              maxFontSize: 36,
              style:
                  const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: SizeConfig.pointFifteenHeight,
            ),
            AutoSizeText(
              widget.subtitle,
              maxLines: 1,
              minFontSize: 18,
              maxFontSize: 24,
              style:
                  const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
