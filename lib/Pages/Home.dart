// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medappfv/components/Widgets/Pie_Chart.dart';
import 'package:medappfv/components/Widgets/category_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // app bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello,',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.titleSmall!.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Nawaf Aljohani',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.titleSmall!.color,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  //profile pic
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(
                      EvaIcons.personOutline,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),

            //card

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    //animation + picture

                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Lottie.network(isDarkMode
                          ? 'https://lottie.host/be9947b0-4738-4baf-b18d-36a667dcbb32/3xmsLxc01a.json'
                          : 'https://lottie.host/416836f1-1622-4d5b-8aca-378b3911a36d/N8ZAZodBz1.json'),
                    ),

                    SizedBox(
                      width: 25,
                    ),

                    // your next dose is in :

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'How Are You Feeling Today?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .color),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Your next dose is in xx hours',
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .color),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            child: Center(
                              child: Text(
                                'Go to My Medications',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .color),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 25,
            ),

            // horizontal listview --> prbably

            SizedBox(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  categorycard(
                      imageUrl: 'lib/icons/first-aid-kit.png',
                      categoryname: 'health'),
                  SizedBox(
                    width: 10,
                  ),
                  categorycard(
                      imageUrl: 'lib/icons/gift.png', categoryname: 'rewards'),
                  SizedBox(
                    width: 10,
                  ),
                  categorycard(
                      imageUrl: 'lib/icons/diet.png', categoryname: 'diet'),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(
            //       decoration: BoxDecoration(
            //           color: Theme.of(context).colorScheme.primary,
            //           borderRadius: BorderRadius.circular(12)),
            //       height: 110,
            //       width: 110,
            //     ),
            //     SizedBox(
            //       width: 25,
            //     ),
            //     Container(
            //       decoration: BoxDecoration(
            //           color: Theme.of(context).colorScheme.primary,
            //           borderRadius: BorderRadius.circular(12)),
            //       height: 110,
            //       width: 110,
            //     ),
            //     SizedBox(
            //       width: 25,
            //     ),
            //     Container(
            //       decoration: BoxDecoration(
            //           color: Theme.of(context).colorScheme.primary,
            //           borderRadius: BorderRadius.circular(12)),
            //       height: 110,
            //       width: 110,
            //     ),
            //   ],
            // ),

            SizedBox(
              height: 25,
            ),

            // // bottom 2 cards

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(12)),
                      height: 175,
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: mypiechart(),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(12)),
                      height: 175,
                      width: 200,
                      child: Lottie.network(
                          'https://lottie.host/548401de-281b-462f-bd4b-de933850b57f/PmTNZvnDSU.json'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(12)),
                      height: 175,
                      width: 200,
                      child: Lottie.network(
                          'https://lottie.host/42356826-3521-4774-97e2-ad20958673fe/E8LjkNoe7y.json'),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(12)),
                      height: 175,
                      width: 200,
                      child: Lottie.network(
                          'https://lottie.host/954fcca1-9977-4b0a-b310-c97d42c774c4/knkexFTsXT.json'),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
