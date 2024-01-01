import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medappfv/Pages/login_signup/PersonalinfoForms/signup.dart';
import 'package:medappfv/components/TextField.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:medappfv/components/Widgets/NavBar.dart';
import 'package:medappfv/components/Widgets/TextBtn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String quote = 'Loading...';
  late String author = '';

  @override
  void initState() {
    super.initState();
    fetchQuote();
  }

  Future<void> fetchQuote() async {
    final response =
        await http.get(Uri.parse('https://api.quotable.io/random'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        quote = data['content'];
        author = data['author'];
      });
    } else {
      throw Exception('Failed to load quote');
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailtextcontroller = TextEditingController();
    final passwordextcontroller = TextEditingController();
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
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
                                Theme.of(context).textTheme.titleSmall!.color,
                            fontSize: SizeConfig.screenWidth * 0.085,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.008,
                      ),
                      Text(
                        'We missed you around here',
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
                      height: SizeConfig.pointThreeHeight,
                    ),

                    // sign in button
                    txtbtn(
                        Highet: SizeConfig.screenHeight * 0.05,
                        width: SizeConfig.screenWidth * 0.8,
                        txt: 'Sign In',
                        newLocation: const NavBar()),

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
                              'or Sign In with',
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
                        //apple
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
                          'Not a part of our family? ',
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
                                  return const SignUpPage();
                                },
                              ),
                            );
                          },
                          child: Text(
                            'Join our family now ! ',
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
