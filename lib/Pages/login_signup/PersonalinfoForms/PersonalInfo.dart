import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:medappfv/Pages/login_signup/PersonalinfoForms/HealthDataForms/regForm.dart';
import 'package:medappfv/Pages/login_signup/PersonalinfoForms/HealthDataForms/regForm1.dart';
import 'package:medappfv/Pages/login_signup/PersonalinfoForms/HealthDataForms/regForm2.dart';
import 'package:medappfv/Pages/login_signup/PersonalinfoForms/HealthDataForms/regForm2p1.dart';
import 'package:medappfv/Pages/login_signup/PersonalinfoForms/HealthDataForms/regForm3.dart';

import 'package:medappfv/components/Themes/Sizing.dart';

// ignore_for_file: file_names, camel_case_types

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

// page controller

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: CarouselSlider(
          slideIndicator: CircularSlideIndicator(
              currentIndicatorColor: Theme.of(context).colorScheme.primary,
              padding: EdgeInsets.only(bottom: SizeConfig.pointThreeHeight)),
          slideTransform: CubeTransform(),
          unlimitedMode: true,
          initialPage: 2,
          children: [
            regF(),
            regF1(),
            regF2(),
            regF2p1(),
            regF3(),
          ],
        ),
      ),
    );
  }
}
