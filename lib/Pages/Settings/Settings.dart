
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medappfv/FireBase/addingData.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:medappfv/components/Cards/settings_card.dart';
import 'package:medappfv/components/Widgets/dialougecard.dart';
import 'package:medappfv/Pages/login_signup/login_page.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

String points = '';
String realName = '';
String userName = '';

final User? user = FirebaseAuth.instance.currentUser;
final String? userId = user?.uid;
final CollectionReference userInfoCollection =
    FirebaseFirestore.instance.collection('UserInfo');
String email = FirebaseAuth.instance.currentUser!.email!;
bool uploadWasSuccessful = false;

class _SettingsState extends State<Settings> {

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }



  void changePassword() {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  void _fetchUserData() async {
    if (userId != null) {
      userInfoCollection.doc(userId).get().then((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          final data = snapshot.data() as Map<String, dynamic>;
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
  }

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final newusernametxtcntrlr = TextEditingController();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.09,
                ),
                // Displaying name and points
                Text(
                  realName,
                  style: TextStyle(
                    fontSize: SizeConfig.screenWidth * 0.075,
                    color: Theme.of(context).textTheme.titleSmall!.color,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Text(
                  'You have $points points',
                  style: TextStyle(
                    fontSize: SizeConfig.screenWidth * 0.05,
                    color: Theme.of(context).textTheme.titleSmall!.color,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                // Account section
                _buildSectionHeader(context, EvaIcons.personOutline, 'Account'),
                SizedBox(height: SizeConfig.screenHeight * 0.005),
                _buildDivider(context),
                // Edit Profile card
                _buildSettingsCard(
                  context,
                  'Change username',
                  EvaIcons.chevronRightOutline,
                  () =>
                      _showChangeUsernameDialog(context, newusernametxtcntrlr),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.005),
                // Change Password card
                _buildSettingsCard(
                  context,
                  'Change password',
                  EvaIcons.chevronRightOutline,
                  changePassword,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.025),
                // Notifications section
                _buildSectionHeader(
                    context, EvaIcons.bellOutline, 'Notifications'),
                SizedBox(height: SizeConfig.screenHeight * 0.005),
                _buildDivider(context),
                SizedBox(height: SizeConfig.screenHeight * 0.005),
                // Notifications settings
                _buildSettingsCard(context, 'Medication notifications',
                    EvaIcons.toggleRightOutline, () {}),
                _buildSettingsCard(context, 'App notifications',
                    EvaIcons.toggleLeftOutline, () {}),
                SizedBox(height: SizeConfig.screenHeight * 0.025),
                // More section
                _buildSectionHeader(context, EvaIcons.personAddOutline, 'More'),
                _buildDivider(context),
                SizedBox(height: SizeConfig.screenHeight * 0.005),
                // Language Selection card
                _buildSettingsCard(context, 'Language selection',
                    EvaIcons.globe2Outline, () {}),
                SizedBox(height: SizeConfig.screenHeight * 0.015),
                // Logout button
                SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                  width: SizeConfig.screenWidth * 0.5,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: signUserOut,
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.labelMedium!.color,
                        fontSize: SizeConfig.screenWidth * 0.033,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.025),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showChangeUsernameDialog(
      BuildContext context, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            "Change your username",
            style: TextStyle(
              color: Theme.of(context).textTheme.titleSmall!.color,
              fontSize: SizeConfig.screenWidth * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Your current username is: $userName',
                style: TextStyle(
                  color: Theme.of(context).textTheme.titleSmall!.color,
                  fontSize: SizeConfig.screenWidth * 0.035,
                ),
              ),
              TextField(
                style: TextStyle(
                    color: Theme.of(context).textTheme.titleSmall!.color),
                decoration: const InputDecoration(hintText: "New Username"),
                controller: controller,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(dialogContext),
            ),
            TextButton(
              child: const Text("Submit"),
              onPressed: () {
                if (controller.text == userName) {
                  showErrorDialog(
                    context: context,
                    title: 'Oops!',
                    content:
                        'You are trying to use the same username! Try another name',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.titleSmall!.color,
                      fontSize: SizeConfig.screenWidth * 0.05,
                    ),
                    btncolor: Theme.of(context).textTheme.titleSmall!.color,
                  );
                } else {
                  submitUserData({'Username': controller.text});
                  setState(() {
                    userName = controller.text;
                  });
                  Navigator.pop(dialogContext);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, IconData icon, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.065),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).textTheme.titleSmall!.color,
            size: SizeConfig.screenWidth * 0.08,
          ),
          SizedBox(width: SizeConfig.screenWidth * 0.015),
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.00525),
            child: Text(
              title,
              style: TextStyle(
                color: Theme.of(context).textTheme.titleSmall!.color,
                fontSize: SizeConfig.screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.06),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 2,
              color: Theme.of(context).colorScheme.primary.withOpacity(.2),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSettingsCard(
      BuildContext context, String text, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: SettingsCard(
        cardText: text,
        icon: icon,
      ),
    );
  }
}
