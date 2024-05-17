// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

class dietpage extends StatefulWidget {
  const dietpage({super.key});

  @override
  State<dietpage> createState() => _dietpageState();
}

DateTime now = DateTime.now(); // get the curent date
String formattedDate =
    DateFormat('dd MMM yyyy').format(now); // convert to dd/MM/yyyy

// Firebase references
final User? user = FirebaseAuth.instance.currentUser;
final String? userId = user?.uid;
final CollectionReference userInfoCollection =
    FirebaseFirestore.instance.collection('UserInfo');

class _dietpageState extends State<dietpage> {
  @override
  void initState() {
    super.initState();
    //initialize the function to check if there is a diet plan or not here
  }

  //a void function to check if there is a diet plan or not
  // a void function to fetch all the diet data from fire base ( meals -  carbs consumed / carb goal - protie consumed / protien goal  - fat consumed / fat goal)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          'Your Daily Meals',
          style:
              TextStyle(color: Theme.of(context).textTheme.labelSmall!.color),
          minFontSize: 12,
          maxFontSize: 18,
          maxLines: 1,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: AutoSizeText(
                'Today, $formattedDate',
                style: TextStyle(
                  color: Theme.of(context).textTheme.labelSmall!.color,
                ),
                maxFontSize: 24,
                minFontSize: 16,
                maxLines: 1,
              ),
            ),

            //row for text
            Center(
              child: Container(
                height: SizeConfig.screenHeight * 0.1,
                width: SizeConfig.screenWidth * 0.9,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(24)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Carbs
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //text
                        AutoSizeText(
                          'Carbs',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .color),
                          minFontSize: 12,
                          maxFontSize: 18,
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.01,
                        ),
                        //progress bar
                        LinearPercentIndicator(
                          width: SizeConfig.screenWidth * 0.25,
                          lineHeight: SizeConfig.pointFifteenHeight,
                          percent:
                              0.4444, //<---- plugin the curren progress hear
                          barRadius: const Radius.circular(12),
                          backgroundColor: Colors.grey,
                          progressColor: Colors.blue,
                        ),
                        //cuurrent/goal
                        AutoSizeText(
                          '21/447g', //<---- plugin the current / goal instead of this static text
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .color),
                          minFontSize: 12,
                          maxFontSize: 18,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    //protien
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //text
                        AutoSizeText(
                          'Protien',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .color),
                          minFontSize: 12,
                          maxFontSize: 18,
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.01,
                        ),
                        //progress bar
                        LinearPercentIndicator(
                          width: SizeConfig.screenWidth * 0.25,
                          lineHeight: SizeConfig.pointFifteenHeight,
                          percent:
                              0.4444, //<---- plugin the curren progress hear
                          barRadius: const Radius.circular(12),
                          backgroundColor: Colors.grey,
                          progressColor: Colors.blue,
                        ),
                        //cuurrent/goal
                        AutoSizeText(
                          '21/447g', //<---- plugin the current / goal instead of this static text
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .color),
                          minFontSize: 12,
                          maxFontSize: 18,
                          maxLines: 1,
                        ),
                      ],
                    ),

                    //Fat
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //text
                        AutoSizeText(
                          'Fat',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .color),
                          minFontSize: 12,
                          maxFontSize: 18,
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.01,
                        ),
                        //progress bar
                        LinearPercentIndicator(
                          width: SizeConfig.screenWidth * 0.25,
                          lineHeight: SizeConfig.pointFifteenHeight,
                          percent:
                              0.4444, //<---- plugin the curren progress hear
                          barRadius: const Radius.circular(12),
                          backgroundColor: Colors.grey,
                          progressColor: Colors.blue,
                        ),
                        //cuurrent/goal
                        AutoSizeText(
                          '21/447g', //<---- plugin the current / goal instead of this static text
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .color),
                          minFontSize: 12,
                          maxFontSize: 18,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.pointThreeHeight,
            ),
            Center(
              child: Container(
                height: SizeConfig.screenHeight * 0.1,
                width: SizeConfig.screenWidth * 0.9,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(24)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Carbs
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //text
                        AutoSizeText(
                          'Today\'s calorie Intake',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .color),
                          minFontSize: 12,
                          maxFontSize: 18,
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.01,
                        ),
                        //progress bar
                        LinearPercentIndicator(
                          width: SizeConfig.screenWidth * 0.89,
                          lineHeight: SizeConfig.pointFifteenHeight,
                          percent:
                              0.4444, //<---- plugin the current progress here for daily calories intake
                          barRadius: const Radius.circular(12),
                          backgroundColor: Colors.grey,
                          progressColor: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.pointThreeHeight,
            ),
            Center(
              child: Container(
                height: SizeConfig.screenHeight * 0.1,
                width: SizeConfig.screenWidth * 0.9,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(24)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Carbs
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //text
                        AutoSizeText(
                          'Water Intake',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .color),
                          minFontSize: 12,
                          maxFontSize: 18,
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.01,
                        ),
                        //progress bar
                        LinearPercentIndicator(
                          width: SizeConfig.screenWidth * 0.89,
                          lineHeight: SizeConfig.pointFifteenHeight,
                          percent:
                              0.4444, //<---- plugin the current progress here for water intake
                          barRadius: const Radius.circular(12),
                          backgroundColor: Colors.grey,
                          progressColor: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.pointThreeHeight,
            ),
            // FoodCard(
            //   FoodNmae: 'Rice',
            //   Gm: 50,
            //   Kcals: 234,
            //   pic: 'lib/icons/carrot.svg',
            //   // onprsd: Function,
            // ),
          ],
        ),
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final String pic;
  final String FoodNmae;
  final double Kcals;
  final double Gm;
  final bool isEaten = false;
  final Function onprsd;
  const FoodCard({
    super.key,
    required this.FoodNmae,
    required this.Gm,
    required this.Kcals,
    required this.pic,
    required this.onprsd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.02),
      height: SizeConfig.screenHeight * 0.075,
      width: SizeConfig.screenWidth * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.primary),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // pic
          SvgPicture.asset(
            pic,
            height: SizeConfig.screenWidth * 0.1,
          ),
          SizedBox(
            width: SizeConfig.pointThreeWidth,
          ),
          //food name
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  AutoSizeText(
                    FoodNmae,
                    maxLines: 1,
                    minFontSize: 12,
                    maxFontSize: 16,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.labelMedium!.color),
                  ),
                ],
              ),
              Row(
                children: [
                  //kcal

                  AutoSizeText(
                    "${Kcals.toString()} Kcal",
                    maxLines: 1,
                    minFontSize: 12,
                    maxFontSize: 16,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.labelMedium!.color),
                  ),
                  SizedBox(
                    width: SizeConfig.pointFifteenWidth,
                  ),
                  Icon(
                    Icons.fiber_manual_record_rounded,
                    size: SizeConfig.pointFifteenWidth,
                  ),
                  SizedBox(
                    width: SizeConfig.pointFifteenWidth,
                  ),
                  //gm

                  AutoSizeText(
                    '${Gm.toString()} Gm',
                    maxLines: 1,
                    minFontSize: 12,
                    maxFontSize: 16,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.labelMedium!.color),
                  ),
                ],
              )
            ],
          ),
          // icon button
          IconButton(
              onPressed: () {
                // set the isEaten bool to true in the database
              },
              icon: Icon(
                Icons.add_circle_outline_rounded,
              ))
        ],
      ),
    );
  }
}
