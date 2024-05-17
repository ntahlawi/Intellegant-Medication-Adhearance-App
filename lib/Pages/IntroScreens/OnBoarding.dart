// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:medappfv/Pages/IntroScreens/intro_page_1.dart';
import 'package:medappfv/Pages/IntroScreens/intro_page_2.dart';
import 'package:medappfv/Pages/IntroScreens/intro_page_3.dart';
import 'package:medappfv/Pages/login_signup/signup.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // track if user is in last page
  bool isLastPage = false;

  // page controller
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // page view
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  isLastPage = (index == 2);
                });
              },
              children: [
                IntroPage1(),
                IntroPage2(),
                IntroPage3(),
              ],
            ),
            SizedBox(
              height: SizeConfig.pointFifteenHeight,
            ),
            // dot indicators
            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //skip
                  GestureDetector(
                    onTap: () {
                      _controller.jumpToPage(2);
                    },
                    child: Text(
                      'skip',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: SizeConfig.screenWidth * 0.045,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                  ),

                  // next or done
                  isLastPage
                      ? GestureDetector(
                          onTap: () async {
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setBool('showHome', true);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SignUpPage();
                                },
                              ),
                            );
                          },
                          child: Text('Done',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: SizeConfig.screenWidth * 0.045,
                                  fontWeight: FontWeight.bold)),
                        )
                      : GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.screenWidth * 0.045,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
