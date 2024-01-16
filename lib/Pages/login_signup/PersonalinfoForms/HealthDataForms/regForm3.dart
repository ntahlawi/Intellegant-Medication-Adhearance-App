// ignore_for_file: unused_import

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:iconoir_flutter/regular/iconoir.dart';
import 'package:medappfv/components/TextField.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:medappfv/components/Widgets/NavBar.dart';
import 'package:medappfv/components/Widgets/TextBtn.dart';
import 'package:numberpicker/numberpicker.dart';
// ignore_for_file: file_names, camel_case_types

class regF3 extends StatefulWidget {
  const regF3({super.key});

  @override
  State<regF3> createState() => _regF3State();
}

class _regF3State extends State<regF3> {
  var _bloodsugarchecktimes = 4;

  @override
  Widget build(BuildContext context) {
    final bloodgccontroler = TextEditingController();
    final hab1clvlcontroller = TextEditingController();
    final caloriesintakecontroller = TextEditingController();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.pointFifteenHeight,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.075,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tell us more \nabout your diabetic condition.\nthis will help us personalise\nthe experiance for you.',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.titleSmall!.color,
                            fontSize: SizeConfig.screenWidth * 0.06,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              shadowColor: Theme.of(context).textTheme.titleSmall!.color,
              elevation: 5,
              color: Theme.of(context).colorScheme.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: SizeConfig.pointFifteenHeight,
                  ),
                  //blood gc  current level
                  Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.075,
                      right: SizeConfig.screenWidth * 0.05,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'What is your current glucose level?',
                          style: TextStyle(
                              fontSize: SizeConfig.screenWidth * 0.04,
                              color:
                                  Theme.of(context).textTheme.bodySmall!.color),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(EvaIcons.questionMarkCircleOutline))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.pointFifteenHeight,
                  ),
                  CustomTextField(
                      controller: bloodgccontroler,
                      hintText: 'type your latest glucose level here..',
                      IconName: Icons.bloodtype_outlined,
                      obscuretext: false),
                  SizedBox(
                    height: SizeConfig.pointFifteenHeight,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.075,
                      right: SizeConfig.screenWidth * 0.05,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'How often do you check your sugar level\nper day?',
                          style: TextStyle(
                              fontSize: SizeConfig.screenWidth * 0.04,
                              color:
                                  Theme.of(context).textTheme.bodySmall!.color),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(EvaIcons.questionMarkCircleOutline))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.pointFifteenHeight,
                  ),
                  //how many times per day do you check?
                  Center(
                    child: NumberPicker(
                      axis: Axis.horizontal,
                      minValue: 1,
                      maxValue: 20,
                      value: _bloodsugarchecktimes,
                      onChanged: (value) =>
                          setState(() => _bloodsugarchecktimes = value),
                      selectedTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          fontSize: SizeConfig.screenWidth * 0.075),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color:
                                Theme.of(context).colorScheme.primaryContainer),
                      ),
                      haptics: true,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.pointFifteenHeight,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.075,
                      right: SizeConfig.screenWidth * 0.05,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'What is your current hemoglobin level?',
                          style: TextStyle(
                              fontSize: SizeConfig.screenWidth * 0.04,
                              color:
                                  Theme.of(context).textTheme.bodySmall!.color),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(EvaIcons.questionMarkCircleOutline))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.pointFifteenHeight,
                  ),
                  // hba1c levels
                  CustomTextField(
                      controller: hab1clvlcontroller,
                      hintText: 'type your latest hemoglobin level here..',
                      IconName: Icons.bloodtype_outlined,
                      obscuretext: false),
                  SizedBox(
                    height: SizeConfig.pointFifteenHeight,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.075,
                      right: SizeConfig.screenWidth * 0.05,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'what\'s your calorie intake per day\n on average?',
                          style: TextStyle(
                              fontSize: SizeConfig.screenWidth * 0.04,
                              color:
                                  Theme.of(context).textTheme.bodySmall!.color),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(EvaIcons.questionMarkCircleOutline))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.pointFifteenHeight,
                  ),
                  //carb intake
                  CustomTextField(
                      controller: caloriesintakecontroller,
                      hintText: 'calorie intake per day on average..',
                      IconName: Icons.food_bank_outlined,
                      obscuretext: false),
                  SizedBox(
                    height: SizeConfig.pointFifteenHeight,
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(.6),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.01,
                  ),
                  Center(
                    child: InkWell(
                      splashColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      splashFactory: InkSplash.splashFactory,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        height: SizeConfig.screenHeight * 0.05,
                        width: SizeConfig.screenWidth * 0.65,
                        child: const Center(
                          child: Text(
                            'Next',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.01,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
