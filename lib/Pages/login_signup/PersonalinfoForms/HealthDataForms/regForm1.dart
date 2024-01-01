// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class regF1 extends StatefulWidget {
  const regF1({
    super.key,
  });

  @override
  State<regF1> createState() => _regF1State();
}

class _regF1State extends State<regF1> {
  bool isGuy = true; // Default to guy

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.22,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: SizeConfig.screenWidth * 0.6,
                        child: isGuy
                            ? Lottie.asset('lib/icons/male.json')
                            : Lottie.asset('lib/icons/female.json'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.01,
                  ),
                  Text(
                    'Tell us your Gender!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.titleLarge!.color,
                      fontSize: SizeConfig.screenWidth * 0.055,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.025,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Female
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          setState(() {
                            isGuy = false; // Set the state to represent female
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(24),
                            border: isGuy == false
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
                              'I\'m a Female',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      // Male
                      InkWell(
                        onTap: () {
                          setState(() {
                            isGuy = true; // Set the state to represent male
                          });
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(24),
                            border: isGuy == true
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
                              'I\'m a Male',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.06,
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
