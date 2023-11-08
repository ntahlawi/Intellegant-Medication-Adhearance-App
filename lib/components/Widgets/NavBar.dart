// ignore_for_file: file_names, non_constant_identifier_names

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:medappfv/Pages/ChatBot/chat_page.dart';
import 'package:medappfv/Pages/Home.dart';
import 'package:medappfv/Pages/MedicationTracking/Mtracking.dart';
import 'package:medappfv/Pages/Settings/Settings.dart';
import 'package:medappfv/Pages/Social/Social.dart';
import 'package:unicons/unicons.dart';
import '../../Pages/ChatBot/chat_api.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int sindex = 0;
  List Screens = [
    const Home(),
    ChatPage(chatApi: ChatApi()),
    const Social(),
    const Mtracking(),
    const Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: Theme.of(context).colorScheme.primary,
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Theme.of(context).colorScheme.background,
        onTap: (index) {
          setState(() {
            sindex = index;
          });
        },
        items: const <Widget>[
          // ignore: prefer_const_constructors
          Icon(
            UniconsLine.home,
          ),
          Icon(UniconsLine.robot),
          Icon(UniconsLine.chat),
          Icon(UniconsLine.medkit),
          Icon(UniconsLine.setting),
        ],
      ),
      body: Screens[sindex],
    );
  }
}
