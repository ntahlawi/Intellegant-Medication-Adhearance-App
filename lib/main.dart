// ignore_for_file: camel_case_types

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medappfv/FireBase/auth_signupin.dart';
import 'package:medappfv/Pages/IntroScreens/OnBoarding.dart';
import 'package:medappfv/components/Themes/darktheme.dart';
import 'package:medappfv/components/Themes/lighttheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Pages/login_signup/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  final showRegF = prefs.getBool('showRegF') ?? false;

  runApp(
    OBcheck(
      showHome: showHome,
    ),
  );
}

class OBcheck extends StatelessWidget {
  final bool showHome;
  const OBcheck({
    Key? key,
    required this.showHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: showHome ? const AuthPage() : const OnBoardingScreen(),
      );
}
