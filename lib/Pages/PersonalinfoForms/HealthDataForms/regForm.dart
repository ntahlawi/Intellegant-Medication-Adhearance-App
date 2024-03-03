// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medappfv/Pages/PersonalinfoForms/HealthDataForms/regForm1.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
// ignore_for_file: file_names, camel_case_types

class regF extends StatefulWidget {
  const regF({super.key});

  @override
  State<regF> createState() => _regFState();
}

class _regFState extends State<regF> {
  @override
  Widget build(BuildContext context) {
    const int splashScreenDuration = 3;

    // Start the timer
    Timer(const Duration(seconds: splashScreenDuration), () {
      // Navigate to another page when the timer is up
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const regF1(),
        ),
      );
    });
    // track if user is in last page
    bool showRegF = false;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: SizeConfig.pointThreeHeight,
            ),
            //Welcome! Now we will begin the setup proccess, it will take a few minutes but we promise that it's worth it and you will earn point as well!
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: SizeConfig.pointThreeWidth),
              child: Text(
                'Welcome! \n \n  Now we will begin the setup proccess, it will take a few minutes but we promise that it\'s worth it!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).textTheme.titleSmall!.color,
                    fontSize: SizeConfig.screenWidth * 0.05,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // txtbtn(
            //   Highet: SizeConfig.screenHeight * 0.05,
            //   width: SizeConfig.screenWidth * 0.8,
            //   txt: 'Next',
            //   newLocation: regF1(),
            // ),
          ],
        ),
      ),
    );
  }
}
