import 'package:flutter/material.dart';
import 'package:medappfv/Pages/IntroScreens/BuildPage.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({super.key});

  @override
  State<IntroPage2> createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2> {
  @override
  Widget build(BuildContext context) {
    return const BuildOBpage(
      subtitle:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore',
      title: 'Check',
      urlImage: 'lib/icons/OB2.jpg',
    );
  }
}