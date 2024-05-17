import 'package:flutter/material.dart';
import 'package:medappfv/Pages/IntroScreens/BuildPage.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({super.key});

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> {
  @override
  Widget build(BuildContext context) {
    return  const BuildOBpage(
      subtitle:
          'Your medications and save them !',
      title: 'Track',
      urlImage: 'lib/icons/OB1.jpg',
    );
  }
}
