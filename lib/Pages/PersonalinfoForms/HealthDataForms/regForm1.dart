// ignore_for_file: file_names, camel_case_types, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medappfv/FireBase/addingData.dart';
import 'package:medappfv/Pages/PersonalinfoForms/HealthDataForms/regForm1p1.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:medappfv/components/Widgets/txtbtwcheck.dart';

class regF1 extends StatefulWidget {
  const regF1({super.key});

  @override
  State<regF1> createState() => _regF1State();
}

class _regF1State extends State<regF1> {
  //retrive the gender
  String selectedGender = '';
  // Function to display the dialog
  void showerrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Ops!",
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .color!
                  .withOpacity(0.8),
            ),
          ),
          content: Text(
            "Make sure that you have selected a gender!",
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .color!
                  .withOpacity(0.8),
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "Got it!",
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .color!
                      .withOpacity(0.8),
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  //function to get email
  String userEmail = ''; // Declare global variable

  @override
  Widget build(BuildContext context) {
    //showErrorDialog

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.22),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            color: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.pointFifteenHeight),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: SizeConfig.screenWidth * 0.6,
                        child: selectedGender == 'male'
                            ? Lottie.asset('lib/icons/male.json')
                            : Lottie.asset('lib/icons/female.json'),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),

                  SizedBox(height: SizeConfig.screenHeight * 0.025),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Female
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          setState(() {
                            selectedGender = 'female';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary, // Main button color
                            borderRadius: BorderRadius.circular(24),
                            border: selectedGender == 'female'
                                ? Border.all(
                                    color: Colors.white,
                                    width: 2.0, // Adjust outline thickness
                                  )
                                : null, // No border if not selected
                          ),
                          height: SizeConfig.screenHeight * 0.05,
                          width: SizeConfig.screenWidth * 0.25,
                          child: Center(
                            child: Text(
                              'I\'m a Female',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .color!
                                    .withOpacity(0.8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Male
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          setState(() {
                            selectedGender = 'male';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary, // Main button color
                            borderRadius: BorderRadius.circular(24),
                            border: selectedGender == 'male'
                                ? Border.all(
                                    color: Colors.white,
                                    width: 2.0, // Adjust outline thickness
                                  )
                                : null, // No border if not selected
                          ),
                          height: SizeConfig.screenHeight * 0.05,
                          width: SizeConfig.screenWidth * 0.25,
                          child: Center(
                            child: Text(
                              'I\'m a Male',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .color!
                                    .withOpacity(0.8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  // ... (Your Next button code)
                  txtbtnwcheck(
                    Highet: SizeConfig.screenHeight * 0.05,
                    width: SizeConfig.screenWidth * 0.5,
                    txt: 'Let\'s move!',
                    newLocation: const regF1p1(),
                    condestion: selectedGender.isNotEmpty,
                    //error handeling
                    popupmsg: showerrorDialog,
                    functionifneeded: submitUserData({
                      'gender': selectedGender,
                      
                    }) // Update in Firestore
                    ,
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
