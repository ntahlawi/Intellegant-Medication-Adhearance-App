// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:medappfv/FireBase/addingData.dart';
import 'package:medappfv/Pages/PersonalinfoForms/HealthDataForms/regForm2p1.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
// ignore_for_file: file_names, camel_case_types

class regF2 extends StatefulWidget {
  const regF2({super.key});

  @override
  State<regF2> createState() => _regF2State();
}

class _regF2State extends State<regF2> {
  String _selectedDate = ''; // Store the selected date

  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1900, 1, 1), // Optional
      maxTime: DateTime.now(), // Optional
      onConfirm: (date) {
        setState(() {
          _selectedDate = '${date.day}/${date.month}/${date.year}';
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
            //header
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
          //card for data entry
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            color: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.pointFifteenHeight),
              child: Column(
                children: [
                  //DOB
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * 0.075,
                        right: SizeConfig.screenWidth * 0.075),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'What is your birthday?',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .color!,
                                fontSize: SizeConfig.screenWidth * 0.04),
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.015),
                        TextField(
                          // Or a suitable widget for date display
                          controller: TextEditingController(
                              text: _selectedDate), // Display selected date
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            hintText: 'Enter your date of birth...',
                            hintStyle: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                            prefixIcon: Container(
                              margin: EdgeInsets.only(
                                right: SizeConfig.screenWidth *
                                    0.045, // hint rext distance
                                top: SizeConfig.pointFifteenHeight,
                                bottom: SizeConfig.pointFifteenHeight,
                                left: SizeConfig.pointFifteenWidth,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer
                                        .withOpacity(.8),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: SizeConfig.pointFifteenWidth),
                                child: Icon(
                                  EvaIcons.calendarOutline,
                                  color: Theme.of(context)
                                      .iconTheme
                                      .color!
                                      .withOpacity(.7),
                                  size:
                                      MediaQuery.of(context).size.width * 0.055,
                                ),
                              ),
                            ),
                            prefixIconColor: Theme.of(context).iconTheme.color,
                            prefixIconConstraints: const BoxConstraints(),
                          ),
                          onTap: _showDatePicker, // Show date picker on tap
                        ),
                      ],
                    ),
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
                      if (_selectedDate.isNotEmpty) {
                        // Check if a date is selected
                        submitUserData({
                          'Birthdate': _selectedDate,
                        });
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const regF2p1();
                            },
                          ),
                        );
                      } else {
                        // Handle the case where no date is selected (Example: show an error dialog)
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Oops!'),
                                content: const Text(
                                    'Please select your date of birth before continuing.'),
                                actions: [
                                  TextButton(
                                    child: const Text('Got it!'),
                                    onPressed: () => Navigator.pop(
                                        context), // Dismiss the dialog
                                  )
                                ],
                              );
                            });
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
