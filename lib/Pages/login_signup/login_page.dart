// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medappfv/Pages/login_signup/signup.dart';
import 'package:medappfv/components/Widgets/NavBar.dart';
import 'package:medappfv/components/Widgets/TextField.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailtextcontroller = TextEditingController();
  final passwordextcontroller = TextEditingController();
  String userName = '';

  // sign in try
  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailtextcontroller.text,
        password: passwordextcontroller.text,
      );
      Navigator.pop(context); // Pop the loading indicator
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const NavBar();
          },
        ),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Pop the loading indicator
      // Show error message
      String message;
      if (e.code == 'user-not-found') {
        message = 'Wrong e-mail';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password';
      } else {
        message = 'An error occurred';
      }
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
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
                        'Welcome Back!',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.labelSmall!.color,
                            fontSize: SizeConfig.screenWidth * 0.085,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.008,
                      ),
                      Text(
                        'We missed you around here',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.labelSmall!.color,
                          fontSize: SizeConfig.screenWidth * 0.055,
                          fontWeight: FontWeight.bold,
                        ),
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
                      height: SizeConfig.pointThreeHeight,
                    ),

                    // sign in button
                    InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        signUserIn();
                      },
                      child: Center(
                        child: Container(
                          height: SizeConfig.screenHeight * 0.05,
                          width: SizeConfig.screenWidth * 0.8,
                          padding: EdgeInsets.all(SizeConfig.pointFifteenWidth),
                          margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.pointFifteenWidth),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Center(
                            child: AutoSizeText(
                              'Sign In',
                              maxLines: 1,
                              minFontSize: 12,
                              maxFontSize: 16,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .color,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // txtbtn(
                    //     Highet: SizeConfig.screenHeight * 0.05,
                    //     width: SizeConfig.screenWidth * 0.8,
                    //     txt: 'Sign In',
                    //     newLocation: signUserIn),

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
                                  .labelMedium!
                                  .color!
                                  .withOpacity(.5),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.pointFifteenWidth),
                            child: Text(
                              'or Sign In with',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
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
                                  .labelMedium!
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
                            width: (SizeConfig.screenWidth * 0.6),
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
                                AutoSizeText(
                                  'Google',
                                  maxLines: 1,
                                  minFontSize: 12,
                                  maxFontSize: 16,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .color),
                                ),
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
                        AutoSizeText(
                          'Not a part of our family? ',
                          maxLines: 1,
                          minFontSize: 12,
                          maxFontSize: 16,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .color!
                                  .withOpacity(0.5)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const SignUpPage();
                                },
                              ),
                            );
                          },
                          child: AutoSizeText(
                            'Join our family now ! ',
                            maxLines: 1,
                            minFontSize: 12,
                            maxFontSize: 16,
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
    );
  }
}
