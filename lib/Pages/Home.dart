// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medappfv/components/category_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
                    Container(
                      height: 100,
                      width: 100,
                      child: Lottie.network(
                          'https://lottie.host/343b0307-0cc8-4a4d-a351-51e0a90fc0d5/0bbG8l9l4D.json'),
                    ),

                    // your next dose is in :
                    SizedBox(
                      width: 25,
                    ),
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
                                'go to my medications',
                                style: TextStyle(
                                    fontSize: 14,
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

            Container(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  categorycard(
                      imageUrl:
                          'https://lottie.host/2f2ec972-c3a6-4a22-8195-314d85d0ac37/wJAbWtplSp.json',
                      categoryname: 'health'),
                  SizedBox(
                    width: 25,
                  ),
                  categorycard(
                      imageUrl:
                          'https://lottie.host/2f2ec972-c3a6-4a22-8195-314d85d0ac37/wJAbWtplSp.json',
                      categoryname: 'rewards'),
                  SizedBox(
                    width: 25,
                  ),
                  categorycard(
                      imageUrl:
                          'https://lottie.host/2f2ec972-c3a6-4a22-8195-314d85d0ac37/wJAbWtplSp.json',
                      categoryname: 'diet'),
                  SizedBox(
                    width: 25,
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
