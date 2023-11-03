import 'package:flutter/material.dart';
import 'package:medappfv/Pages/Hompage.dart';
import 'package:medappfv/Pages/IntroScreens/intro_page_1.dart';
import 'package:medappfv/Pages/IntroScreens/intro_page_2.dart';
import 'package:medappfv/Pages/IntroScreens/intro_page_3.dart';
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
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
          // dot indicators
          Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //skip
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: Text('skip'),
                ),

                SmoothPageIndicator(controller: _controller, count: 3),

                // next or done
                isLastPage
                    ? GestureDetector(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('showHome', true);

                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return Homepage();
                          }));
                        },
                        child: Text('Done'),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Text('Next'),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
