// ignore_for_file: unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconoir_flutter/regular/weight.dart';
import 'package:medappfv/FireBase/addingData.dart';
import 'package:medappfv/components/Widgets/NavBar.dart';
import 'package:medappfv/components/Widgets/TextField.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:numberpicker/numberpicker.dart';
// ignore_for_file: file_names, camel_case_types

class regF2p1 extends StatefulWidget {
  const regF2p1({super.key});

  @override
  State<regF2p1> createState() => _regF2p1State();
}

// Choice enum for clarity
enum DiabeticStatus { notDiabetic, diabetic, preDiabetic }

DiabeticStatus selectedChoice =
    DiabeticStatus.notDiabetic; // Start with none selected

class _regF2p1State extends State<regF2p1> {
  var _currvalueH = 160;
  var _currvalueV = 60;
  bool isDiabetic = false;
  bool isPreDiabetic = false;
  @override
  Widget build(BuildContext context) {
    final nametextcontroller = TextEditingController();
    // final passwordextcontroller = TextEditingController();
    // final confirmpasswordextcontroller = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.05,
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
                      'Hey Username!',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.titleSmall!.color,
                          fontSize: SizeConfig.screenWidth * 0.085,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.008,
                    ),
                    Text(
                      'let\'s get to know you better.',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.titleSmall!.color,
                          fontSize: SizeConfig.screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          height: 0),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.05,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            color: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.pointFifteenHeight),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: SizeConfig.screenWidth * 0.075),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'How Tall are you? we use CM around here',
                          style: TextStyle(
                              fontSize: SizeConfig.screenWidth * 0.04,
                              color:
                                  Theme.of(context).textTheme.bodySmall!.color),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.pointThreeHeight,
                  ),
                  //height
                  NumberPicker(
                    axis: Axis.horizontal,
                    minValue: 120,
                    maxValue: 272,
                    value: _currvalueH,
                    onChanged: (value) => setState(() => _currvalueH = value),
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
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.05,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: SizeConfig.screenWidth * 0.075),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'How much do you weigh in KG? ',
                          style: TextStyle(
                              fontSize: SizeConfig.screenWidth * 0.04,
                              color:
                                  Theme.of(context).textTheme.bodySmall!.color),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.pointThreeHeight,
                  ),
                  //weight
                  NumberPicker(
                    axis: Axis.horizontal,
                    minValue: 30,
                    maxValue: 250,
                    value: _currvalueV,
                    onChanged: (value) => setState(() => _currvalueV = value),
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
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.05,
                  ),
                  //Are you a diabetic person?
                  Padding(
                    padding:
                        EdgeInsets.only(left: SizeConfig.screenWidth * 0.075),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Are you a diabetic person?',
                          style: TextStyle(
                              fontSize: SizeConfig.screenWidth * 0.04,
                              color:
                                  Theme.of(context).textTheme.bodySmall!.color),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: SizeConfig.pointThreeHeight,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Yes
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          setState(() {
                            selectedChoice = DiabeticStatus.diabetic;
                            isDiabetic = true;
                          });
                          print(isDiabetic);
                          print(isPreDiabetic);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(24),
                            border: selectedChoice ==
                                    DiabeticStatus
                                        .diabetic // Highlight if selected
                                ? Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    width: 1.0)
                                : null,
                          ),
                          height: SizeConfig.screenHeight * 0.05,
                          width: SizeConfig.screenWidth * 0.25,
                          child: const Center(
                            child: Text(
                              'Yes, i\'m ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),

                      //pre-diabetic
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedChoice = DiabeticStatus.preDiabetic;
                            isPreDiabetic = true;
                            isDiabetic = false;
                            print(isDiabetic);
                            print(isPreDiabetic);
                          });
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(24),
                            border: selectedChoice == DiabeticStatus.preDiabetic
                                ? Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    width: 1.0)
                                : null,
                          ),
                          height: SizeConfig.screenHeight * 0.05,
                          width: SizeConfig.screenWidth * 0.25,
                          child: const Center(
                            child: Text(
                              'pre-diabetic',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),

                      // No
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedChoice = DiabeticStatus.notDiabetic;
                            isPreDiabetic = false;
                            isDiabetic = false;
                          });
                          print(isDiabetic);
                          print(isPreDiabetic);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(24),
                            border: selectedChoice == DiabeticStatus.notDiabetic
                                ? Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    width: 1.0)
                                : null,
                          ),
                          height: SizeConfig.screenHeight * 0.05,
                          width: SizeConfig.screenWidth * 0.25,
                          child: const Center(
                            child: Text(
                              'No, i\'m not',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: SizeConfig.screenHeight * 0.01,
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(.6),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  InkWell(
                    onTap: () {
                      if (isDiabetic == true || isPreDiabetic == true) {
                        DiabeticStatus selectedStatus = selectedChoice;
                        submitUserData({
                          'Hieght': _currvalueH.toString(),
                          'Weight': _currvalueV.toString(),
                          'DiabeticStatus': selectedStatus.toString(),
                        });
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const NavBar();
                            },
                          ),
                        );
                      } else {
                        DiabeticStatus selectedStatus = selectedChoice;
                        submitUserData({
                          'Hieght': _currvalueH.toString(),
                          'Weight': _currvalueV.toString(),
                          'DiabeticStatus': selectedStatus.toString(),
                        });
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const NavBar();
                            },
                          ),
                        );
                      }
                    },
                    splashColor: Theme.of(context).colorScheme.primaryContainer,
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
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.01,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
