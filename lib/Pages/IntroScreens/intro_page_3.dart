import 'package:flutter/material.dart';
import 'package:medappfv/Pages/IntroScreens/BuildPage.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({super.key});

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> {
  @override
  Widget build(BuildContext context) {
    return const BuildOBpage(
      subtitle: 'Swap your earned points with gifts!',
      title: 'Earn Rewards!',
      urlImage: 'lib/icons/OB3.jpg',
      
    );

  }
}
