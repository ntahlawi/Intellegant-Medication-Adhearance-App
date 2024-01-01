// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:medappfv/components/Widgets/Cards/DateCard.dart';
import 'package:medappfv/components/Widgets/Cards/reminders_card.dart';
import 'package:medappfv/components/Widgets/Cards/reminders_card_small.dart';

class Mtracking extends StatefulWidget {
  const Mtracking({Key? key}) : super(key: key);

  @override
  _MtrackingState createState() => _MtrackingState();
}

class _MtrackingState extends State<Mtracking> {
  int selectedDateIndex = -1; // Initialize to no date selected

  // Function to handle date card selection
  void selectDate(int index) {
    setState(() {
      selectedDateIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.03),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Theme.of(context).colorScheme.primary,
          splashColor: Colors.white,
          child: Icon(
            EvaIcons.plus,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(12)),
                  height: SizeConfig.screenHeight * 0.13,
                  width: SizeConfig.screenWidth * 0.9,
                  child: Padding(
                    padding: EdgeInsets.all(SizeConfig.screenHeight * 0.00125),
                    child: Row(
                      children: [
                        //animation + picture

                        SizedBox(
                          width: SizeConfig.screenWidth * 0.225,
                          child: Lottie.network(isDarkMode
                              ? 'https://lottie.host/be9947b0-4738-4baf-b18d-36a667dcbb32/3xmsLxc01a.json'
                              : 'https://lottie.host/416836f1-1622-4d5b-8aca-378b3911a36d/N8ZAZodBz1.json'),
                        ),

                        SizedBox(
                          width: SizeConfig.screenWidth * 0.0225,
                        ),

                        // Medication Interaction Check

                        Padding(
                          padding: EdgeInsets.only(
                            top: SizeConfig.screenHeight * 0.005,
                          ),
                          child: Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Medication Interaction Check',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .color),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.0125,
                                ),
                                Text(
                                  'Not Sure that your medications \nInteract with eachother?',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .color),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.005,
                                ),
                                Container(
                                  padding: EdgeInsets.all(
                                      SizeConfig.screenHeight * 0.0125),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Go to Interaction Check ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .color),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            //sized
            SizedBox(
              height: SizeConfig.screenHeight * 0.005,
            ),

            //scrollable dates + logic Start
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  31,
                  (index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.0125),
                      child: GestureDetector(
                        onTap: () {
                          selectDate(index);
                        },
                        child: DateCard(
                          Date: (index + 1).toString(),
                          month: 'NOV',
                          isSelected: selectedDateIndex == index,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            //scrollable dates + logic End

            SizedBox(
              height: SizeConfig.screenHeight * 0.003,
            ),

            // Medications for the day card
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.06),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Medications for the Day',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 24,
                    ),
                  )
                ],
              ),
            ),

            SizedBox(
              height: SizeConfig.screenHeight * 0.009,
            ),

            SizedBox(
              height: SizeConfig.screenHeight * 0.1,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: SizeConfig.screenWidth * 0.06),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReminderCard(
                            LottieAssetUrl: isDarkMode
                                ? 'https://lottie.host/be9947b0-4738-4baf-b18d-36a667dcbb32/3xmsLxc01a.json'
                                : 'https://lottie.host/416836f1-1622-4d5b-8aca-378b3911a36d/N8ZAZodBz1.json',
                            titleText: 'med 1 ',
                            bodyText: 'bodyText',
                            bodyText2: 'body2Text'),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.05,
                        ),
                        ReminderCard(
                            LottieAssetUrl: isDarkMode
                                ? 'https://lottie.host/be9947b0-4738-4baf-b18d-36a667dcbb32/3xmsLxc01a.json'
                                : 'https://lottie.host/416836f1-1622-4d5b-8aca-378b3911a36d/N8ZAZodBz1.json',
                            titleText: 'titleText',
                            bodyText: 'bodyText',
                            bodyText2: 'body2Text'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: SizeConfig.screenHeight * 0.025,
            ),
            // excercises for the day card

            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.06),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Health and Nutrition for the Day',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 24,
                    ),
                  )
                ],
              ),
            ),

            SizedBox(
              height: SizeConfig.screenHeight * 0.009,
            ),

            Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.06,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ReminderCardsmall(
                      LottieAssetUrl: EvaIcons.activity,
                      // LottieAssetUrl: isDarkMode
                      //     ? 'https://lottie.host/be9947b0-4738-4baf-b18d-36a667dcbb32/3xmsLxc01a.json'
                      //     : 'https://lottie.host/416836f1-1622-4d5b-8aca-378b3911a36d/N8ZAZodBz1.json',

                      Duration: '60'),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.05,
                  ),
                  ReminderCardsmall(
                      LottieAssetUrl: Icons.cyclone_outlined,
                      // LottieAssetUrl: isDarkMode
                      //     ? 'https://lottie.host/be9947b0-4738-4baf-b18d-36a667dcbb32/3xmsLxc01a.json'
                      //     : 'https://lottie.host/416836f1-1622-4d5b-8aca-378b3911a36d/N8ZAZodBz1.json',
                      Duration: '60'),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.05,
                  ),
                  ReminderCardsmall(
                      LottieAssetUrl: Icons.sports_basketball_outlined,
                      // LottieAssetUrl: isDarkMode
                      //     ? 'https://lottie.host/be9947b0-4738-4baf-b18d-36a667dcbb32/3xmsLxc01a.json'
                      //     : 'https://lottie.host/416836f1-1622-4d5b-8aca-378b3911a36d/N8ZAZodBz1.json',
                      Duration: '60'),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.015,
            ),
            // Planned meals for the day card

            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12)),
              height: SizeConfig.screenHeight * 0.13,
              width: SizeConfig.screenWidth * 0.9,
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.screenHeight * 0.00125),
                child: Row(
                  children: [
                    //animation + picture

                    // SizedBox(
                    //   width: SizeConfig.screenWidth * 0.225,
                    //   // child: Lottie.network(isDarkMode
                    //   //     ? 'https://lottie.host/be9947b0-4738-4baf-b18d-36a667dcbb32/3xmsLxc01a.json'
                    //   //     : 'https://lottie.host/416836f1-1622-4d5b-8aca-378b3911a36d/N8ZAZodBz1.json'),
                    // ),

                    // SizedBox(
                    //   width: SizeConfig.screenWidth * 0.0225,
                    // ),

                    // Medication Interaction Check

                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.screenHeight * 0.005,
                          left: SizeConfig.screenWidth * 0.12),
                      child: Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Consumed calories for today: 2038',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .color),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.0125,
                            ),
                            Text(
                              'Your current burened calories for the day is: 779',
                              style: TextStyle(
                                  fontSize: SizeConfig.screenWidth * 0.03,
                                  color: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .color),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.005,
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  SizeConfig.screenHeight * 0.0125),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              child: Center(
                                child: Text(
                                  'Go to my excercises ',
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenWidth * 0.03,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .color),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
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
