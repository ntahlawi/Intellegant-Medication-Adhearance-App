import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medappfv/Pages/login_signup/login_page.dart';
import 'package:medappfv/components/Widgets/NavBar.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is signed in

          if (snapshot.hasData) {
            return NavBar();
          }

          //user is not logged in
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
