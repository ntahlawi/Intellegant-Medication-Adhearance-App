// ignore_for_file: file_names, non_constant_identifier_names, unused_import

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:medappfv/Pages/chatbotnew/chatbotpage.dart';
import 'package:medappfv/Pages/chatbotnew/keyp.dart';
import 'package:medappfv/Pages/Home.dart';
import 'package:medappfv/Pages/MedicationHealthandDiet/medicationspage.dart';
import 'package:medappfv/Pages/Settings/Settings.dart';
import 'package:medappfv/Pages/Social/Social.dart';
import 'package:unicons/unicons.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int sindex = 0;
  List Screens = [
    const Home(),
    const ChatWidget(apiKey: key),
    // ChatPage(chatApi: ChatApi()),
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
        backgroundColor: Theme.of(context).colorScheme.surface,
        onTap: (index) {
          setState(() {
            sindex = index;
          });
        },
        items: <Widget>[
          // ignore: prefer_const_constructors
          Icon(
            UniconsLine.home,
          ),
          Icon(
            UniconsLine.robot,
            color: Theme.of(context).iconTheme.color,
          ),
          Icon(
            UniconsLine.chat,
            color: Theme.of(context).iconTheme.color,
          ),
          Icon(
            UniconsLine.medkit,
            color: Theme.of(context).iconTheme.color,
          ),
          Icon(
            UniconsLine.setting,
            color: Theme.of(context).iconTheme.color,
          ),
        ],
      ),
      body: Screens[sindex],
    );
  }
}
