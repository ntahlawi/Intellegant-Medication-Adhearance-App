// ignore_for_file: file_names, camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class journalcard extends StatefulWidget {
  final bool ispast;
  final child;
  final String date;
  const journalcard(
      {super.key,
      required this.child,
      required this.ispast,
      required this.date});

  @override
  State<journalcard> createState() => _journalcardState();
}

class _journalcardState extends State<journalcard> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.06),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.035,
                ),
                child: Text(
                  widget.date,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.titleSmall!.color,
                      fontSize: SizeConfig.screenWidth * 0.035,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(.4)),
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.all(SizeConfig.pointFifteenHeight),
            padding: EdgeInsets.all(SizeConfig.pointFifteenHeight),
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
