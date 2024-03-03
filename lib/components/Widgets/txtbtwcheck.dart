// ignore_for_file: file_names, camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class txtbtnwcheck extends StatelessWidget {
  final newLocation;
  final functionifneeded;
  final condestion;
  final popupmsg;
  final Highet;
  final width;
  final String txt;
  const txtbtnwcheck(
      {super.key,
      required this.Highet,
      required this.width,
      required this.txt,
      required this.newLocation,
      required this.condestion,
      required this.popupmsg,
      required this.functionifneeded});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        if (condestion) {
          functionifneeded;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => newLocation),
          );
        } else {
          popupmsg();
          // Show a message like "Please select your gender"
        }
      },
      child: Center(
        child: Container(
          height: (Highet),
          width: (width),
          padding: EdgeInsets.all(SizeConfig.pointFifteenWidth),
          margin:
              EdgeInsets.symmetric(horizontal: SizeConfig.pointFifteenWidth),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: Text(
              txt,
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .color!
                    .withOpacity(0.8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
