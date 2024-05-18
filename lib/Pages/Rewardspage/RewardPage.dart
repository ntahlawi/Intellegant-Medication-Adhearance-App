// ignore_for_file: library_private_types_in_public_api, file_names, unused_element, non_constant_identifier_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PointPage extends StatelessWidget {
  const PointPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const RewardsPage(),
    );
  }
}

class RewardsPage extends StatefulWidget {
  const RewardsPage({Key? key}) : super(key: key);

  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  late FirebaseAuth _auth;
  late int _currentPoints;

  @override
  void initState() {
    super.initState();
    FirebaseService.initializeFirebase();
    _auth = FirebaseAuth.instance;
    _currentPoints = 0;
    _loadCurrentPoints();
  }

  Future<void> _loadCurrentPoints() async {
    User? user = await _getCurrentUser();
    if (user != null) {
      final userId = user.uid;
      final currentPoints = await FirebaseService.getCurrentPoints(userId);
      setState(() {
        _currentPoints = currentPoints;
      });
    }
  }

  Future<User?> _getCurrentUser() async {
    return _auth.currentUser;
  }

  void _incrementPoints() async {
    User? user = await _getCurrentUser();
    if (user != null) {
      final userId = user.uid;
      final newPoints = _currentPoints + 1;
      await FirebaseService.updatePoints(userId, newPoints);
      _updatePointsInPrefs(userId, newPoints);
    }
  }

  void _deductPoints(int deductionAmount) async {
    User? user = await _getCurrentUser();
    if (user != null) {
      final userId = user.uid;
      final currentPoints = await FirebaseService.getCurrentPoints(userId);
      final newPoints =
          (currentPoints - deductionAmount).clamp(0, currentPoints);
      await FirebaseService.deductPoints(userId, newPoints);
      _updatePointsInPrefs(userId, newPoints);
    }
  }

  void _updatePointsInPrefs(String userId, int newPoints) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(userId, newPoints);
    setState(() {
      _currentPoints = newPoints;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    var Black = Theme.of(context).textTheme.labelMedium!.color;
    var White = Theme.of(context).textTheme.labelSmall!.color;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: SizeConfig.pointFifteenHeight,
          ),
          // text for getting rewards
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                'Exchange your points for rewards!',
                maxLines: 1,
                minFontSize: 22,
                maxFontSize: 36,
                style: TextStyle(
                  color: White,
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.pointThreeHeight,
          ),
          AutoSizeText(
            'You have $_currentPoints points!',
            maxLines: 1,
            minFontSize: 22,
            maxFontSize: 36,
            style: TextStyle(
              color: White,
            ),
          ),
          SizedBox(
            height: SizeConfig.pointThreeHeight,
          ),
          //items
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.all(SizeConfig.screenHeight * 0.009),
                height: SizeConfig.screenHeight * 0.25,
                width: SizeConfig.screenWidth * 0.4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.primary),
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Image.asset(
                        'lib/icons/noon.jpg',
                        width: SizeConfig.screenWidth * 0.5,
                        alignment: Alignment.center,
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      AutoSizeText(
                        "50 SAR Noon Voucher",
                        style: TextStyle(
                            color: Black, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        minFontSize: 12,
                        maxFontSize: 16,
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(
                              Theme.of(context)
                                  .colorScheme
                                  .secondary), //button color
                        ),
                        onPressed: () {
                          if (_currentPoints >= 500) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Noon 50 SAR voucher'),
                                  content: Text(
                                    "Trade 500 Points?",
                                    style: TextStyle(
                                      color: White,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        _deductPoints(500);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Confirm'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Insufficient Points'),
                                  content: const Text(
                                    "You don't have enough points to trade for the voucher.",
                                    style: TextStyle(
                                      color: Colors
                                          .red, // or any other color you prefer
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Text(
                          "500 Points",
                          style: TextStyle(
                            color: Black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(SizeConfig.screenHeight * 0.009),
                height: SizeConfig.screenHeight * 0.25,
                width: SizeConfig.screenWidth * 0.4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.primary),
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Image.asset(
                        'lib/icons/amzn.jpg',
                        width: SizeConfig.screenWidth * 0.5,
                        alignment: Alignment.center,
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      AutoSizeText(
                        "50 SAR Amazon Voucher",
                        style: TextStyle(
                            color: Black, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        minFontSize: 12,
                        maxFontSize: 16,
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(
                              Theme.of(context)
                                  .colorScheme
                                  .secondary), //button color
                        ),
                        onPressed: () {},
                        child: AutoSizeText(
                          "500 Points",
                          style: TextStyle(
                              color: Black, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          minFontSize: 12,
                          maxFontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FirebaseService {
  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  static Future<int> getCurrentPoints(String userId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(userId)
        .get();

    if (snapshot.exists) {
      final data = snapshot.data();
      if (data != null) {
        return data['points'] ?? 0;
      }
    }
    return 0;
  }

  static Future<void> updatePoints(String userId, int newPoints) async {
    await FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(userId)
        .set({'points': newPoints}, SetOptions(merge: true));
  }

  static Future<void> deductPoints(String userId, int newPoints) async {
    await FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(userId)
        .set({'points': newPoints});
  }
}
