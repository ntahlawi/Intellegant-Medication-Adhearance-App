// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/widgets.dart';

class SizeConfig {
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double logoSize = 0;
  static double pointThreeHeight = 0;
  static double pointFifteenHeight = 0;
  static double pointThreeWidth = 0;
  static double pointFifteenWidth = 0;

  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    logoSize = screenWidth * 0.2;
    pointThreeHeight = screenHeight * 0.03;
    pointFifteenHeight = screenHeight * 0.015;
    pointThreeWidth = screenWidth * 0.03;
    pointFifteenWidth = screenWidth * 0.015;
  }
}
