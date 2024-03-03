// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

import 'package:flutter/material.dart';
import 'package:medappfv/FireBase/addingData.dart';
import 'package:medappfv/Pages/PersonalinfoForms/HealthDataForms/regForm2.dart';
import 'package:medappfv/components/Widgets/TextField.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
// ignore_for_file: file_names, camel_case_types

class regF1p1 extends StatefulWidget {
  const regF1p1({super.key});

  @override
  State<regF1p1> createState() => _regF1p1State();
}

class _regF1p1State extends State<regF1p1> {
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
            "Make sure that you have filled all the fields!",
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

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _userNameController = TextEditingController();

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
                      controller: _nameController,
                      hintText: "Enter your name here..",
                      IconName: Icons.person_4_outlined,
                      obscuretext: false),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.015,
                  ),

                  Padding(
                    padding:
                        EdgeInsets.only(left: SizeConfig.screenWidth * 0.075),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Now let\'s pick a username!',
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
                      controller: _userNameController,
                      hintText: "Enter your username here..",
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
                    height: SizeConfig.screenHeight * 0.01,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () {
                      if (_nameController.text.isNotEmpty &&
                          _userNameController.text.isNotEmpty) {
                        submitUserData({
                          'Name': _nameController.text,
                          'Username': _userNameController.text
                        });
                     
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const regF2();
                            },
                          ),
                        );
                      } else {
                        print('error moving on!');
                      }
                    },
                    child: Center(
                      child: Container(
                        height: SizeConfig.screenHeight * 0.05,
                        width: SizeConfig.screenWidth * 0.5,
                        padding: EdgeInsets.all(SizeConfig.pointFifteenWidth),
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.pointFifteenWidth),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Center(
                          child: Text('Let\'s move on!'),
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
