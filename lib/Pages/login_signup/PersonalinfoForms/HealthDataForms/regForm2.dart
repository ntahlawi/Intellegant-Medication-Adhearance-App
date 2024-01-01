import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medappfv/components/TextField.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
// ignore_for_file: file_names, camel_case_types

class regF2 extends StatefulWidget {
  const regF2({super.key});

  @override
  State<regF2> createState() => _regF2State();
}

class _regF2State extends State<regF2> {
  @override
  Widget build(BuildContext context) {
    final nametextcontroller = TextEditingController();
    // final passwordextcontroller = TextEditingController();
    // final confirmpasswordextcontroller = TextEditingController();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.1,
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
                      'Hey there!',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.titleSmall!.color,
                          fontSize: SizeConfig.screenWidth * 0.085,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.008,
                    ),
                    Text(
                      'Tell us more about you.',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.titleSmall!.color,
                          fontSize: SizeConfig.screenWidth * 0.055,
                          fontWeight: FontWeight.bold,
                          height: 0),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.1,
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
                          'Tell us your wonderful name!',
                          style: TextStyle(
                              fontSize: SizeConfig.screenWidth * 0.04),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.015,
                  ),
                  //name
                  CustomTextField(
                      controller: nametextcontroller,
                      hintText: "Enter your name here..",
                      IconName: Icons.person_4_outlined,
                      obscuretext: false),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.03,
                  ),

                  //DOB
                  Padding(
                    padding:
                        EdgeInsets.only(left: SizeConfig.screenWidth * 0.075),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'What is your birthday?',
                          style: TextStyle(
                              fontSize: SizeConfig.screenWidth * 0.04),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: SizeConfig.screenHeight * 0.015,
                  ),

                  CustomTextField(
                      controller: nametextcontroller,
                      hintText: "Enter your birthday here..",
                      IconName: Icons.person_4_outlined,
                      obscuretext: false),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
