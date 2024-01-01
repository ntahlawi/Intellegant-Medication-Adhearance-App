// ignore_for_file: file_names

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:medappfv/components/Widgets/Cards/Feed_Card.dart';

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
                      const SizedBox(
                        height: 4,
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
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                padding: const EdgeInsets.only(left: 10),
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
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15, //align hint text with icon
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Feed',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.titleSmall!.color,
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Icon(
                    EvaIcons.menuArrowOutline,
                    color: isDarkMode ? Colors.white : Colors.black,
                  )
                ],
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: const [
                    FeedCard(
                        LottieAssetUrl: 'lib/icons/av1.json',
                        titleText: 'My First Post, Need Your Opinions!',
                        bodyText:
                            'i haven\'t been feeling well lately and i think that my mental health is not at its best ....'),
                    SizedBox(
                      height: 25,
                    ),
                    FeedCard(
                      LottieAssetUrl: 'lib/icons/av2.json',
                      titleText: 'I need help !',
                      bodyText:
                          'Where can i find the best doctor to treat my sickness....',
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    FeedCard(
                      LottieAssetUrl: 'lib/icons/av3.json',
                      titleText: 'i need tips!',
                      bodyText:
                          'whats the best way to use the journal in this app?....',
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    FeedCard(
                      LottieAssetUrl: 'lib/icons/av2.json',
                      titleText: 'I need help !',
                      bodyText:
                          'Where can i find the best doctor to treat my sickness....',
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    FeedCard(
                      LottieAssetUrl: 'lib/icons/av2.json',
                      titleText: 'I need help !',
                      bodyText:
                          'Where can i find the best doctor to treat my sickness....',
                    ),
                  ],
                ),
              ),
            ),

            //cards
          ],
        ),
      ),
    );
  }
}
