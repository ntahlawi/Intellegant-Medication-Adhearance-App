// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:medappfv/components/Widgets/journalCard.dart';
import 'package:rich_readmore/rich_readmore.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MytimeLine extends StatelessWidget {
  const MytimeLine(
      {super.key,
      required this.Isfirst,
      required this.islast,
      required this.ispast,
      required this.journalText,
      required this.date});

  final bool islast;
  final bool Isfirst;
  final bool ispast;
  final String journalText;
  final String date;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return SizedBox(
      height: SizeConfig.screenHeight * 0.2,
      child: TimelineTile(
        isFirst: Isfirst,
        isLast: islast,
        //Decoration
        beforeLineStyle: LineStyle(
            color: ispast
                ? Theme.of(context).colorScheme.secondary.withOpacity(.6)
                : Theme.of(context).colorScheme.secondary.withOpacity(.2),
            thickness: 1.25),
        indicatorStyle: IndicatorStyle(
          color: Theme.of(context).colorScheme.primary,
          width: SizeConfig.screenWidth * 0.04,
        ),
        endChild: journalcard(
          ispast: ispast,
          date: date,
          child: RichReadMoreText.fromString(
            text: journalText,
            textStyle: TextStyle(
                color: Theme.of(context).textTheme.titleSmall!.color,
                fontWeight: FontWeight.w500),
            settings: LineModeSettings(
              trimLines: 3,
              trimCollapsedText: 'Show more...',
              trimExpandedText: 'Show less...',
              lessStyle: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
              moreStyle: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
