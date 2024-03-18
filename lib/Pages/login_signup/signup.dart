// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medappfv/FireBase/addingData.dart';
import 'package:medappfv/Pages/PersonalinfoForms/HealthDataForms/regForm1.dart';
import 'package:medappfv/Pages/login_signup/login_page.dart';
import 'package:medappfv/components/Widgets/TextField.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailtextcontroller = TextEditingController();
  final passwordextcontroller = TextEditingController();
  final confirmpasswordextcontroller = TextEditingController();

  void signUserUp() async {
    //show circle indicator
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try to create account if both passwords match
    if (passwordextcontroller.text == confirmpasswordextcontroller.text) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailtextcontroller.text,
        password: passwordextcontroller.text,
      );

      submitUserData({
        'Email': emailtextcontroller.text,
        'points': 0.toString(),
      });
    } else {
      print('Passwords Don\'t Match');
    }

    //pop circle indicator
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const regF1();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.1,
              ),
              //welcome text
              Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.075,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome!',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.titleSmall!.color,
                              fontSize: SizeConfig.screenWidth * 0.085,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.008,
                        ),
                        Text(
                          'Our family is happy to see you',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.titleSmall!.color,
                              fontSize: SizeConfig.screenWidth * 0.055,
                              fontWeight: FontWeight.bold,
                              height: 0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: SizeConfig.screenHeight * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.02,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  shadowColor: Theme.of(context).textTheme.titleSmall!.color,
                  elevation: 5,
                  color: Theme.of(context).colorScheme.primary,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: SizeConfig.pointThreeHeight,
                      ),
                      //e-mail feild
                      CustomTextField(
                          controller: emailtextcontroller,
                          hintText: 'E-mail',
                          IconName: EvaIcons.personOutline,
                          obscuretext: false),

                      SizedBox(
                        height: SizeConfig.pointFifteenHeight,
                      ),
                      // password
                      CustomTextField(
                          controller: passwordextcontroller,
                          hintText: "Password",
                          IconName: Icons.key_outlined,
                          obscuretext: true),
                      SizedBox(
                        height: SizeConfig.pointFifteenHeight,
                      ),
                      //confirm password
                      CustomTextField(
                          controller: confirmpasswordextcontroller,
                          hintText: 'Confirm Password',
                          IconName: Icons.key_outlined,
                          obscuretext: true),

                      SizedBox(
                        height: SizeConfig.pointFifteenHeight,
                      ),
                      SizedBox(
                        height: SizeConfig.pointThreeHeight,
                      ),
                      // sign in button
                      InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () {
                          signUserUp();
                        },
                        child: Center(
                          child: Container(
                            height: SizeConfig.screenHeight * 0.05,
                            width: SizeConfig.screenWidth * 0.8,
                            padding:
                                EdgeInsets.all(SizeConfig.pointFifteenWidth),
                            margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.pointFifteenWidth),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const Center(
                              child: Text('Sign up'),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: SizeConfig.pointThreeHeight,
                      ),

                      // dividor - or continue with
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.pointThreeWidth),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color!
                                    .withOpacity(.5),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.pointFifteenWidth),
                              child: Text(
                                'or Sign Up with',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color!
                                      .withOpacity(.5),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color!
                                    .withOpacity(.5),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: SizeConfig.pointThreeHeight,
                      ),
                      // google + apple icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //google
                          Center(
                            child: Container(
                              height: (SizeConfig.screenHeight * 0.05),
                              width: (SizeConfig.screenWidth * 0.3),
                              padding:
                                  EdgeInsets.all(SizeConfig.pointFifteenWidth),
                              margin: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.pointFifteenWidth),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(360),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(EvaIcons.google),
                                  SizedBox(
                                    width: SizeConfig.screenWidth * 0.009,
                                  ),
                                  const Text(
                                    'Google',
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //Apple
                          Center(
                            child: Container(
                              height: (SizeConfig.screenHeight * 0.05),
                              width: (SizeConfig.screenWidth * 0.3),
                              padding:
                                  EdgeInsets.all(SizeConfig.pointFifteenWidth),
                              margin: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.pointFifteenWidth),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.apple),
                                  SizedBox(
                                    width: SizeConfig.screenWidth * 0.009,
                                  ),
                                  const Text('Apple')
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.pointThreeHeight,
                      ),

                      // not logged in ? regester now
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already a part of our family? ',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .color!
                                  .withOpacity(.5),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const LoginPage();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              'Login now ! ',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.pointThreeHeight,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
