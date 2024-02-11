// ignore_for_file: file_names, camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class txtbtn extends StatelessWidget {
  final newLocation;
  final Highet;
  final width;
  final String txt;
  const txtbtn(
      {super.key,
      required this.Highet,
      required this.width,
      required this.txt,
      required this.newLocation});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return newLocation;
            },
          ),
        );
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
            child: Text(txt),
          ),
        ),
      ),
    );
  }
}
