// ignore_for_file: file_names

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:medappfv/components/Widgets/TimeLineTile.dart';

class Journal extends StatefulWidget {
  const Journal({super.key});

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.03),
        child: FloatingActionButton(
onPressed: null,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            EvaIcons.plus,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
          color: Theme.of(context).textTheme.titleSmall!.color,
        ),
        title: Text(
          "My Journal",
          style: TextStyle(
              color: Theme.of(context).textTheme.titleSmall!.color,
              fontWeight: FontWeight.w500,
              fontSize: SizeConfig.screenWidth * 0.04),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.04),
                child: ListView(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: SizeConfig.pointThreeHeight),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.05,
                            ),
                            child: Text(
                              '2023',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .color,
                                  fontSize: SizeConfig.screenWidth * 0.05),
                            ),
                          ),
                          Icon(
                            EvaIcons.calendar,
                            color:
                                Theme.of(context).textTheme.titleSmall!.color,
                          )
                        ],
                      ),
                    ),

                    // start
                    const MytimeLine(
                      Isfirst: true,
                      islast: false,
                      ispast: true,
                      journalText:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit',
                      date: 'Nov 20',
                    ),
                    //middle
                    const MytimeLine(
                      Isfirst: false,
                      islast: false,
                      ispast: true,
                      journalText:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit',
                      date: 'Nov 21',
                    ),
                    //end
                    const MytimeLine(
                      Isfirst: false,
                      islast: true,
                      ispast: true,
                      journalText:
                          'im sadd, Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit',
                      date: 'Nov 22',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
