// ignore_for_file: file_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medappfv/FireBase/addingData.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:medappfv/components/Cards/settings_card.dart';
import 'package:medappfv/components/Widgets/dialougecard.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

String points = ''.toString();
String realName = '';
String userName = '';

final User? user = FirebaseAuth.instance.currentUser;
final String? userId = user?.uid;
final CollectionReference userInfoCollection =
    FirebaseFirestore.instance.collection('UserInfo');
String email = FirebaseAuth.instance.currentUser!.email!;
String? downloadedImageUrl;
bool uploadWasSuccessful = false;

class _SettingsState extends State<Settings> {
  String? _profilePictureURL; // To hold the URL

//sign user out

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch data on initialization
    fetchProfilePictureURL();
    _loadProfilePicture(); // Load URL on initialization
  }

  Future<void> _loadProfilePicture() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUrl = prefs.getString('profilePictureURL');
    setState(() {
      _profilePictureURL = savedUrl;
    });
  }

  void changePassword() {
    FirebaseAuth.instance.sendPasswordResetEmail(email: '$email');
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
          userName = data['Username'] as String;
          setState(() {
            points = data['points'] as String;
            realName = data['Name'] as String;
            userName = data['Username'] as String;
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

  Future<String?> fetchProfilePictureURL() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return null; // User not logged in

    try {
      final documentSnapshot = await userInfoCollection.doc(userId).get();
      if (documentSnapshot.exists) {
        final data = documentSnapshot.data() as Map<String, dynamic>;
        return data['profilePictureURL'] as String?;
      } else {
        return null; // No profile picture found
      }
    } on FirebaseException catch (e) {
      print('Error fetching profile picture URL: $e');
      return null;
    }
  }

  //uplaoding pfp
  Future<void> uploadProfilePicture(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    // 1. Pick an image
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (image == null) return;

    // 2. Save to persistent storage
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      final savedImage =
          await File(image.path).copy('${appDocDir.path}/profile_image.jpg');
      final imageFile = File(savedImage.path);

      // 3. Upload to Firebase Storage
      final storageRef =
          FirebaseStorage.instance.ref().child('profile_pictures/$userId.jpg');
      await storageRef.putFile(imageFile);

      // 4. Get Download URL
      final downloadURL = await storageRef.getDownloadURL();

      // 5. Update Firestore
      await userInfoCollection
          .doc(userId)
          .update({'profilePictureURL': downloadURL});

      // 6. Update State
      setState(() {
        downloadedImageUrl = downloadURL;
        uploadWasSuccessful = true;
      });
      //save the url to the shared preferences
      final prefs = await SharedPreferences.getInstance(); // Get instance
      await prefs.setString('profilePictureURL', downloadURL); // Store URL
    } on FirebaseException catch (e) {
      print('Upload failed: $e');
      print(e.message);
      // Handle upload errors gracefully
      return;
    } catch (e) {
      print('Error saving image or during upload: $e');
      // Handle other potential exceptions
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final newusernametxtcntrlr = TextEditingController();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                //editable profile picture logic
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //adding outline to profile picture
                    GestureDetector(
                      onTap: () async {
                        await uploadProfilePicture(context);
                      },
                      //function to replce the profile picture and save it to the database

                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black, // Adjust the outline color
                            width: 2.0, // Adjust the outline thickness
                          ),
                        ),
                        child: CircleAvatar(
                          radius: SizeConfig.screenWidth * 0.20,
                          backgroundImage: _profilePictureURL != null
                              ? NetworkImage(_profilePictureURL!)
                              : const AssetImage('lib/icons/diet.png')
                                  as ImageProvider,
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
                SizedBox(
                  height: SizeConfig.screenHeight * 0.01,
                ),

                //Account
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.065),
                  child: Row(
                    children: [
                      Icon(
                        EvaIcons.personOutline,
                        color: Theme.of(context).textTheme.titleSmall!.color,
                        size: SizeConfig.screenWidth * 0.08,
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth * 0.015,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.screenHeight * 0.00525),
                        child: Text(
                          'Account',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.titleSmall!.color,
                              fontSize: SizeConfig.screenWidth * 0.05,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: SizeConfig.screenHeight * 0.005,
                ),
                // Dividor
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.06),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(.2),
                        ),
                      )
                    ],
                  ),
                ),

                //edit Profile card
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          title: Text(
                            "Change your username",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .color,
                                fontSize: SizeConfig.screenWidth * 0.05,
                                fontWeight: FontWeight.bold),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Your current username is: $userName',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .color,
                                  fontSize: SizeConfig.screenWidth * 0.035,
                                ),
                              ),
                              TextField(
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .color),
                                decoration: InputDecoration(
                                  hintText: "New Username",
                                ),
                                controller: newusernametxtcntrlr,
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              child: Text("Cancel"),
                              onPressed: () => Navigator.pop(dialogContext),
                            ),
                            TextButton(
                              child: Text("Submit"),
                              onPressed: () {
                                if (newusernametxtcntrlr.text == userName) {
                                  showErrorDialog(
                                      context: context,
                                      title: 'Oops!',
                                      content:
                                          'You are trying to use the same username! Try another name',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .color,
                                        fontSize: SizeConfig.screenWidth * 0.05,
                                      ),
                                      btncolor: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .color);
                                } else {
                                  submitUserData({
                                    'Username': newusernametxtcntrlr.text,
                                  });
                                  setState(() {
                                    userName = newusernametxtcntrlr.text;
                                  });
                                  Navigator.pop(
                                      dialogContext); // Close the dialog
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: SettingsCard(
                      cardText: 'Change username',
                      icon: EvaIcons.chevronRightOutline),
                ),

                SizedBox(
                  height: SizeConfig.screenHeight * 0.005,
                ),

                // Change Password card
                InkWell(
                  onTap: () {
                    changePassword();
                  },
                  child: SettingsCard(
                      cardText: 'Change password',
                      icon: EvaIcons.chevronRightOutline),
                ),

                SizedBox(
                  height: SizeConfig.screenHeight * 0.025,
                ),
                //Notifications
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.065),
                  child: Row(
                    children: [
                      Icon(
                        EvaIcons.bellOutline,
                        color: Theme.of(context).textTheme.titleSmall!.color,
                        size: SizeConfig.screenWidth * 0.08,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.screenHeight * 0.00525),
                        child: Text(
                          'Notifications',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.titleSmall!.color,
                              fontSize: SizeConfig.screenWidth * 0.05,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: SizeConfig.screenHeight * 0.005,
                ),
                // Dividor
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.06),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(.2),
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(
                  height: SizeConfig.screenHeight * 0.005,
                ),

                // Medication notifications
                const SettingsCard(
                    cardText: 'Medication notifications',
                    icon: EvaIcons.toggleRightOutline),
                // App notifications
                const SettingsCard(
                    cardText: 'App notifications',
                    icon: EvaIcons.toggleLeftOutline),

                SizedBox(
                  height: SizeConfig.screenHeight * 0.025,
                ),

                // More
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.065),
                  child: Row(
                    children: [
                      Icon(
                        EvaIcons.personAddOutline,
                        color: Theme.of(context).textTheme.titleSmall!.color,
                        size: SizeConfig.screenWidth * 0.08,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.screenHeight * 0.00525),
                        child: Text(
                          'More',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.titleSmall!.color,
                              fontSize: SizeConfig.screenWidth * 0.05,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                // Dividor
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.06),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(.2),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.005,
                ),
                //Language Selection card
                const SettingsCard(
                    cardText: 'Language selection',
                    icon: EvaIcons.globe2Outline),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.015,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                  width: SizeConfig.screenWidth * 0.5,
                  //Logout button start

                  child: TextButton(
                    child: Text(
                      'Logout',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.titleMedium!.color,
                          fontSize: SizeConfig.screenWidth * 0.033,
                          fontWeight: FontWeight.w500),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: () {
                      signUserOut();
                    },
                  ),
                ),
                //Logout button finish

                SizedBox(
                  height: SizeConfig.screenHeight * 0.025,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
