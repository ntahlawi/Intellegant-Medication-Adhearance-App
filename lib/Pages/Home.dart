// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, non_constant_identifier_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medappfv/Pages/Diet/dietpage.dart';
import 'package:medappfv/Pages/Journal/MainJournal.dart';
import 'package:medappfv/Pages/MedicationHealthandDiet/sugerlevelcheck.dart';
import 'package:medappfv/Pages/Rewardspage/RewardPage.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

Future<DocumentSnapshot?> getLatestReading() async {
  // Get the current user's ID
  String? userId = FirebaseAuth.instance.currentUser?.uid;

  if (userId != null) {
    // Query all readings for the current user
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('SugarLevelReadings')
        .doc(userId)
        .collection('readings')
        .get();

    // Sort readings by time in descending order
    List<DocumentSnapshot> readings = querySnapshot.docs;
    readings.sort((a, b) => b['time'].compareTo(a['time']));

    // Get the latest reading
    if (readings.isNotEmpty) {
      DocumentSnapshot latestReading = readings.first;
      latestSugarLevel =
          latestReading['sugarLevelReading']; // Save the value to the variable
      return latestReading;
    }
  }

  return null;
}

String ldate = '';
String ltime = '';
double latestSugarLevel = 0.0;
double currentProgress = 700; // fetch current steps
double goal = 100; // fetch the goal set by the user
double limitedProgress = currentProgress.clamp(0.0, goal);
double displayedPercent = limitedProgress / goal;

DateTime now = DateTime.now(); // get the curent date
String formattedDate =
    DateFormat('dd MMM yyyy').format(now); // convert to dd/MM/yyyy
String realName = '';
final User? user = FirebaseAuth.instance.currentUser;
final String? userId = user?.uid;
final CollectionReference userInfoCollection =
    FirebaseFirestore.instance.collection('UserInfo');

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch data on initialization
    getLatestReading();
    setState(() {});
  }

  void _fetchUserData() async {
    if (userId != null) {
      final CollectionReference userInfoCollection =
          FirebaseFirestore.instance.collection('UserInfo');

      userInfoCollection.doc(userId).get().then((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          realName = data['Name'] as String;
          setState(() {
            realName = data['Name'] as String;
          });
        } else {
          print('User document does not exist');
        }
      }).catchError((error) {
        print('Error retrieving points: $error');
      });
    } else {
      print('User is not logged in');
    }
    // Update variables and trigger UI update
  }

  @override
  Widget build(BuildContext context) {
    getLatestReading().then((DocumentSnapshot? document) {
      if (document != null && document.exists) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        double sugarLevel = data['sugarLevelReading'];
        String date = data['date'];
        String time = data['time'];
        ldate = date; // Update ldate with the latest reading's date
        ltime = time; // Update ltime with the latest reading's time
        print('Latest Reading: Sugar Level $sugarLevel on $date at $time');
      } else {
        print('No readings found');
      }
    });
    void updateSugarLevel(double sugarLevel) {
      setState(() {
        latestSugarLevel = sugarLevel;
      });
    }

    void updateDateAndTime(String date, String time) {
      setState(() {
        ldate = date;
        ltime = time;
      });
    }

    SizeConfig.init(context);
    var Black = Theme.of(context).textTheme.labelMedium!.color;
    var White = Theme.of(context).textTheme.labelSmall!.color;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //App bar
              Padding(
                padding: EdgeInsets.only(left: SizeConfig.pointThreeWidth),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //hello, name
                    AutoSizeText(
                      'Hello, $realName',
                      style: TextStyle(
                        color: White,
                      ),
                      minFontSize: 16,
                      maxFontSize: 24,
                      maxLines: 1,
                    ),
                    //add a new reading
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return slevelcheck(
                                  updateSugarLevel: updateSugarLevel,
                                  updateDateAndTime: updateDateAndTime,
                                );
                              },
                            ),
                          );
                        },
                        icon: Icon(
                          EvaIcons.plusCircle,
                          size: SizeConfig.screenWidth * 0.1,
                        ))
                    //pfp
                  ],
                ),
              ),

              // box to show latest sugar level register
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: SizeConfig.screenHeight * 0.175,
                    width: SizeConfig.screenWidth * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Theme.of(context).colorScheme.primary),
                    child: Center(
                      child: Column(
                        children: [
                          //reading

                          AutoSizeText(
                            latestSugarLevel.toInt().toString(),
                            minFontSize: 75,
                            maxFontSize: 80,
                            maxLines: 1,
                            style: TextStyle(
                                color: Black, fontWeight: FontWeight.bold),
                          ),
                          //mg/dL
                          AutoSizeText(
                            'mg/dL',
                            minFontSize: 12,
                            maxFontSize: 16,
                            maxLines: 1,
                            style: TextStyle(
                              color: Black,
                            ),
                          ),
                          //last time was done
                          AutoSizeText(
                            '$ldate at $ltime',
                            minFontSize: 12,
                            maxFontSize: 16,
                            maxLines: 1,
                            style: TextStyle(
                              color: Black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(SizeConfig.screenHeight * 0.009),
                    height: SizeConfig.screenHeight * 0.175,
                    width: SizeConfig.screenWidth * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Theme.of(context).colorScheme.primary),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          'Glucose is in the zone!',
                          minFontSize: 16,
                          maxFontSize: 36,
                          style: TextStyle(
                            color: Black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              //show today's date
              Center(
                child: AutoSizeText(
                  'Today, $formattedDate',
                  style: TextStyle(
                    color: White,
                  ),
                  maxFontSize: 24,
                  minFontSize: 16,
                  maxLines: 1,
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              // three progress cirles to show how are you going with ur targets
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // steps Target
                  Column(
                    children: [
                      CircularPercentIndicator(
                        radius: SizeConfig.screenWidth *
                            0.12, // Adjust radius as needed
                        lineWidth: 9.0, // Adjust line width as needed
                        animation: true, // Enable animation (optional)
                        percent: displayedPercent, // Calculate percentage
                        progressColor: Colors.orange,

                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.directions_run,
                                size: SizeConfig.screenWidth * 0.085,
                                color: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .color),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.005,
                            ),
                            AutoSizeText(
                              "${currentProgress.toStringAsFixed(1)}%", // Display percentage
                              style: TextStyle(color: White),
                              maxLines: 1,
                              minFontSize: 12,
                              maxFontSize: 16,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.01,
                      ),
                      AutoSizeText(
                        "$currentProgress out of $goal", // Display percentage
                        style: TextStyle(color: White),
                        maxLines: 1,
                        minFontSize: 12,
                        maxFontSize: 16,
                      ),
                    ],
                  ),
                  //calories target
                  Column(
                    children: [
                      CircularPercentIndicator(
                        radius: SizeConfig.screenWidth *
                            0.12, // Adjust radius as needed
                        lineWidth: 9.0, // Adjust line width as needed
                        animation: true, // Enable animation (optional)
                        percent: displayedPercent, // Calculate percentage
                        progressColor: Colors.orange,

                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.whatshot,
                              size: SizeConfig.screenWidth * 0.085,
                              color:
                                  Theme.of(context).textTheme.labelSmall!.color,
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.005,
                            ),
                            AutoSizeText(
                              "${currentProgress.toStringAsFixed(1)}%", // Display percentage
                              style: TextStyle(color: White),
                              maxLines: 1,
                              minFontSize: 12,
                              maxFontSize: 16,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.01,
                      ),
                      AutoSizeText(
                        "$currentProgress out of $goal", // Display percentage
                        style: TextStyle(color: White),
                        maxLines: 1,
                        minFontSize: 12,
                        maxFontSize: 16,
                      ),
                    ],
                  ),
                  //idk target
                  Column(
                    children: [
                      CircularPercentIndicator(
                        radius: SizeConfig.screenWidth *
                            0.12, // Adjust radius as needed
                        lineWidth: 9.0, // Adjust line width as needed
                        animation: true, // Enable animation (optional)
                        percent: displayedPercent, // Calculate percentage
                        progressColor: Colors.orange,

                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.directions_run,
                              size: SizeConfig.screenWidth * 0.085,
                              color:
                                  Theme.of(context).textTheme.labelSmall!.color,
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.005,
                            ),
                            AutoSizeText(
                              "${currentProgress.toStringAsFixed(1)}%", // Display percentage
                              style: TextStyle(color: White),
                              maxLines: 1,
                              minFontSize: 12,
                              maxFontSize: 16,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.01,
                      ),
                      AutoSizeText(
                        "$currentProgress out of $goal", // Display percentage
                        style: TextStyle(color: White),
                        maxLines: 1,
                        minFontSize: 12,
                        maxFontSize: 16,
                      ),
                    ],
                  ),
                ],
              ),

              //optional: a chart
              SizedBox(
                height: SizeConfig.screenHeight * 0.005,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // excersize shortcut
                  Container(
                    padding: EdgeInsets.all(SizeConfig.screenHeight * 0.009),
                    height: SizeConfig.screenHeight * 0.125,
                    width: SizeConfig.screenWidth * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.primary),
                    child: GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'lib/icons/sport.svg',
                            width: SizeConfig.screenWidth * 0.175,
                            alignment: Alignment.center,
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.005,
                          ),
                          AutoSizeText(
                            "Exercise Activity", // Display percentage
                            style: TextStyle(
                                color: Black, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            minFontSize: 12,
                            maxFontSize: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //rewards page shortcut

                  Container(
                    padding: EdgeInsets.all(SizeConfig.screenHeight * 0.009),
                    height: SizeConfig.screenHeight * 0.125,
                    width: SizeConfig.screenWidth * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.primary),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PointPage();
                            },
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'lib/icons/surprise.svg',
                            width: SizeConfig.screenWidth * 0.22,
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.005,
                          ),
                          AutoSizeText(
                            "Rewards",
                            style: TextStyle(
                                color: Black, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            minFontSize: 12,
                            maxFontSize: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Food shortcut

                  Container(
                    padding: EdgeInsets.all(SizeConfig.screenHeight * 0.009),
                    height: SizeConfig.screenHeight * 0.125,
                    width: SizeConfig.screenWidth * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.primary),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DietPage();
                            },
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'lib/icons/diet-schedule.png',
                            width: SizeConfig.screenWidth * 0.174,
                            alignment: Alignment.center,
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.005,
                          ),
                          AutoSizeText(
                            "Diet",
                            style: TextStyle(
                                color: Black, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            minFontSize: 12,
                            maxFontSize: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.01,
              ),
              //second shortcut layer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Diary
                  Container(
                    padding: EdgeInsets.all(SizeConfig.screenHeight * 0.009),
                    height: SizeConfig.screenHeight * 0.125,
                    width: SizeConfig.screenWidth * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.primary),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Journal();
                            },
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'lib/icons/diary.svg',
                            width: SizeConfig.screenWidth * 0.15,
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.01,
                          ),
                          AutoSizeText(
                            "Diary",
                            style: TextStyle(
                                color: Black, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            minFontSize: 12,
                            maxFontSize: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
