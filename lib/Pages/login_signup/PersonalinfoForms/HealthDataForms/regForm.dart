import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:medappfv/components/TextField.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:medappfv/components/Widgets/NavBar.dart';
import 'package:medappfv/components/Widgets/TextBtn.dart';
// ignore_for_file: file_names, camel_case_types

class regF extends StatefulWidget {
  const regF({super.key});

  @override
  State<regF> createState() => _regFState();
}

class _regFState extends State<regF> {
  @override
  Widget build(BuildContext context) {
    final emailtextcontroller = TextEditingController();
    final passwordextcontroller = TextEditingController();
    final confirmpasswordextcontroller = TextEditingController();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: SizeConfig.pointThreeHeight,
            ),
            //Welcome! Now we will begin the setup proccess, it will take a few minutes but we promise that it's worth it and you will earn point as well!
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: SizeConfig.pointThreeWidth),
              child: Text(
                'Welcome! \n \n  Now we will begin the setup proccess, it will take a few minutes but we promise that it\'s worth it!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).textTheme.titleSmall!.color,
                    fontSize: SizeConfig.screenWidth * 0.05,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
