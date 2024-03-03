// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medappfv/Pages/Diet/DIetpage.dart';
import 'package:medappfv/Pages/Diet/dailychallanges.dart';
import 'package:medappfv/Pages/Exercise/exercisePage.dart';
import 'package:medappfv/Pages/Journal/MainJournal.dart';
import 'package:medappfv/Pages/Profilepage/pfp.dart';
import 'package:medappfv/Pages/Rewardspage/RewardPage.dart';
import 'package:medappfv/Pages/PersonalinfoForms/HealthDataForms/regForm.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:medappfv/components/Widgets/Pie_Chart.dart';
import 'package:medappfv/components/Cards/category_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

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
  }
  //random quote genarator

  late String quote = 'Loading...';
  late String author = '';

  // void initState() {
  //   super.initState();
  //   fetchQuote();
  // }

  // Future<void> fetchQuote() async {
  //   final response =
  //       await http.get(Uri.parse('https://api.quotable.io/random'));

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> data = json.decode(response.body);
  //     setState(() {
  //       quote = data['content'];
  //       author = data['author'];
  //     });
  //   } else {
  //     throw Exception('Failed to load quote');
  //   }
  // }
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
    //add a check if the showRegF bool is false then go to the page named regF() if true then do nothing
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // app bar
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'Hello,',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.titleSmall!.color,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.003,
                      ),
                      AutoSizeText(
                        realName,
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.titleSmall!.color,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                        maxLines: 1,
                      ),
                    ],
                  ),
                  //profile picture
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return pfp();
                          },
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(SizeConfig.pointFifteenHeight),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(12)),
                      child: Icon(
                        EvaIcons.personOutline,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.03,
            ),

            //card

            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.035),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(SizeConfig.screenHeight * 0.015),
                child: Row(
                  children: [
                    //animation + picture

                    Expanded(
                      child: Column(
                        children: [
                          // Display the quote
                          Text(
                            quote,
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                          ),
                          // Display the author after the dash
                          Text(
                            '- $author',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(
              height: SizeConfig.screenHeight * 0.03,
            ),

            // horizontal listview --> prbably

            SizedBox(
              height: SizeConfig.screenHeight * 0.08,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    child: CategoryCard(
                        imageUrl: 'lib/icons/first-aid-kit.png',
                        categoryName: 'health'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return regF();
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.02,
                  ),
                  GestureDetector(
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
                    child: CategoryCard(
                        imageUrl: 'lib/icons/gift.png',
                        categoryName: 'rewards'),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.02,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return dailychllange();
                          },
                        ),
                      );
                    },
                    child: CategoryCard(
                      imageUrl: 'lib/icons/diet.png',
                      categoryName: 'challanges',
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.02,
                  ),
                ],
              ),
            ),

            SizedBox(
              height: SizeConfig.screenHeight * 0.03,
            ),

            // // bottom 2 cards

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(12)),
                      height: SizeConfig.screenHeight * 0.19,
                      width: SizeConfig.screenWidth * 0.45,
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: mypiechart(),
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.screenWidth * 0.05,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DietTracking();
                            },
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(12)),
                        height: SizeConfig.screenHeight * 0.19,
                        width: SizeConfig.screenWidth * 0.45,
                        child: Lottie.network(
                            'https://lottie.host/548401de-281b-462f-bd4b-de933850b57f/PmTNZvnDSU.json'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.025,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Extracking();
                            },
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(12)),
                        height: SizeConfig.screenHeight * 0.19,
                        width: SizeConfig.screenWidth * 0.45,
                        child: Lottie.network(
                            'https://lottie.host/42356826-3521-4774-97e2-ad20958673fe/E8LjkNoe7y.json'),
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.screenWidth * 0.05,
                    ),
                    GestureDetector(
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
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(12)),
                        height: SizeConfig.screenHeight * 0.19,
                        width: SizeConfig.screenWidth * 0.45,
                        child: Lottie.network(
                            'https://lottie.host/954fcca1-9977-4b0a-b310-c97d42c774c4/knkexFTsXT.json'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
