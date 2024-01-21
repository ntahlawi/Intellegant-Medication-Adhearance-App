import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medappfv/FireBase/UpdatingData.dart';
import 'package:medappfv/FireBase/addingData.dart';

import '../../../../components/Widgets/TextField.dart';
import '../../../../components/Themes/Sizing.dart';

class testForm extends StatefulWidget {
  const testForm({super.key});

  @override
  State<testForm> createState() => _testFormState();
}

class _testFormState extends State<testForm> {
  @override
  Widget build(BuildContext context) {
    final Nametextcntrlr = TextEditingController();
    final Height = TextEditingController();
    final weight = TextEditingController();
    final bloodslvl = TextEditingController();
    final targetweight = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //welcome text on top start

              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
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
                          'Welcome!',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.titleSmall!.color,
                              fontSize: SizeConfig.screenWidth * 0.085,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.008,
                        ),
                        Text(
                          'Our family is happy to see you',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.titleSmall!.color,
                              fontSize: SizeConfig.screenWidth * 0.055,
                              fontWeight: FontWeight.bold,
                              height: 0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //welcome text on top finish

              // info card start
              SizedBox(
                height: SizeConfig.screenHeight * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.02,
                ),
                child: Card(
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
                        height: SizeConfig.pointThreeHeight,
                      ),
                      //e-mail feild
                      CustomTextField(
                          controller: Nametextcntrlr,
                          hintText: 'Name',
                          IconName: EvaIcons.personOutline,
                          obscuretext: false),

                      SizedBox(
                        height: SizeConfig.pointFifteenHeight,
                      ),
                      // password
                      CustomTextField(
                          controller: Height,
                          hintText: "Height",
                          IconName: Icons.key_outlined,
                          obscuretext: false),
                      SizedBox(
                        height: SizeConfig.pointFifteenHeight,
                      ),
                      //confirm password
                      CustomTextField(
                          controller: weight,
                          hintText: 'weight',
                          IconName: Icons.key_outlined,
                          obscuretext: false),

                      SizedBox(
                        height: SizeConfig.pointFifteenHeight,
                      ),
                      CustomTextField(
                          controller: bloodslvl,
                          hintText: "bloodslvl",
                          IconName: Icons.key_outlined,
                          obscuretext: false),
                      SizedBox(
                        height: SizeConfig.pointFifteenHeight,
                      ),
                      CustomTextField(
                          controller: targetweight,
                          hintText: "targetweight",
                          IconName: Icons.key_outlined,
                          obscuretext: false),

                      SizedBox(
                        height: SizeConfig.pointThreeHeight,
                      ),
                      // submit info button
                      InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () {
                          //create a new file in the collection named userData and add all the fields needed with the user id as a primary key
                          submitUserData({
                            'name': Nametextcntrlr.text,
                            'height': Height.text,
                            'weight': weight.text,
                            'bloodslvl': bloodslvl.text,
                            'targetweight': targetweight.text,
                          });
                        },
                        child: Center(
                          child: Container(
                            height: SizeConfig.screenHeight * 0.05,
                            width: SizeConfig.screenWidth * 0.8,
                            padding:
                                EdgeInsets.all(SizeConfig.pointFifteenWidth),
                            margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.pointFifteenWidth),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Text('Submit'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.pointThreeHeight,
                      ),

                      InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () {
                          //create a new file in the collection named userData and add all the fields needed with the user id as a primary key
                          updateUserDataField('Weight', '80');
                        },
                        child: Center(
                          child: Container(
                            height: SizeConfig.screenHeight * 0.05,
                            width: SizeConfig.screenWidth * 0.8,
                            padding:
                                EdgeInsets.all(SizeConfig.pointFifteenWidth),
                            margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.pointFifteenWidth),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Text('update Weight to 80'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.pointThreeHeight,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
