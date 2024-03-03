// ignore_for_file: camel_case_types, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class pfp extends StatefulWidget {
  const pfp({super.key});

  @override
  State<pfp> createState() => _pfpState();
}

String points = '';
String realName = '';
final User? user = FirebaseAuth.instance.currentUser;
final String? userId = user?.uid;
final CollectionReference userInfoCollection =
    FirebaseFirestore.instance.collection('UserInfo');

class _pfpState extends State<pfp> {
  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch data on initialization
  }

  void _fetchUserData() async {
    if (userId != null) {
      final CollectionReference userInfoCollection =
          FirebaseFirestore.instance.collection('UserInfo');

      userInfoCollection.doc(userId).get().then((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          points = data['points'] as String;
          realName = data['Name'] as String;
          setState(() {
            points = data['points'] as String;
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
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          //editable profile picture logic
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //adding outline to profile picture
              GestureDetector(
                onTap: () {
                  //function to replce the profile picture and save it to the database
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black, // Adjust the outline color
                      width: 2.0, // Adjust the outline thickness
                    ),
                  ),
                  child: CircleAvatar(
                    radius: SizeConfig.screenWidth * 0.25,
                    backgroundImage: const AssetImage('lib/icons/diet.png'),
                  ),
                ),
              ),
            ],
          ),
          //  given points and name
          Text(
            realName,
            style: TextStyle(
                fontSize: SizeConfig.screenWidth * 0.075,
                color: Theme.of(context).textTheme.titleSmall!.color),
          ),
          Text(
            points,
            style: TextStyle(
                fontSize: SizeConfig.screenWidth * 0.05,
                color: Theme.of(context).textTheme.titleSmall!.color),
          ),

          //edit your name
          //Username + can be changed by adding a dialog box when the username is pressed
        ],
      ),
    );
  }
}
