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
      body: StreamBuilder<User?>( // Core authentication logic
        stream: FirebaseAuth.instance.authStateChanges(), // Stream of auth changes
        builder: (context, snapshot) {
          if (snapshot.hasData) { // If user data exists (User is signed in)
            return const NavBar(); // Show the main app (or a loading indicator while fetching additional data)
          } else { 
            return const LoginPage(); // User signed out - show login
          }
        },
      ),
    );
  }
}
