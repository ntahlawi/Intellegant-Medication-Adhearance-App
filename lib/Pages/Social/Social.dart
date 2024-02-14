// ignore_for_file: file_names

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:medappfv/Pages/Social/QuestionScreen.dart';
import 'package:medappfv/Pages/Social/Questions.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:medappfv/components/Widgets/TextBtn.dart';

class Social extends StatefulWidget {
  const Social({super.key});

  @override
  State<Social> createState() => _SocialState();
}

class _SocialState extends State<Social> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //appbar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome!,',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.titleSmall!.color,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.screenWidth * 0.035),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.0075,
                      ),
                      Text(
                        'Ask and Socialize and be Healthy!',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.titleSmall!.color,
                            fontSize: SizeConfig.screenWidth * 0.055,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            //search field

            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: SizeConfig.pointThreeWidth),
              child: Container(
                padding: EdgeInsets.only(left: SizeConfig.pointFifteenWidth),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12)),
                child: TextField(
                  cursorColor: Theme.of(context).textTheme.headlineSmall?.color,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search For Helpful Posts Here...',
                    hintStyle: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                    prefixIcon: const Icon(EvaIcons.search),
                    prefixIconColor: Theme.of(context).iconTheme.color,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: SizeConfig
                          .pointFifteenHeight, //align hint text with icon
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: SizeConfig.pointThreeHeight,
            ),

            txtbtn(
                Highet: SizeConfig.screenHeight * 0.05,
                width: SizeConfig.screenWidth * 0.5,
                txt: "click here to post a question",
                newLocation: PostQuestionScreen()),
            SizedBox(
              height: SizeConfig.pointThreeHeight,
            ),
            txtbtn(
                Highet: SizeConfig.screenHeight * 0.05,
                width: SizeConfig.screenWidth * 0.5,
                txt: "click here to view a question",
                newLocation: QuestionListScreen()),
          ],
        ),
      ),
    );
  }
}
