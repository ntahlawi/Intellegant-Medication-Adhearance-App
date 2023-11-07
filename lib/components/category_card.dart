// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class categorycard extends StatelessWidget {
  final imageUrl;
  final String categoryname;
  const categorycard({super.key, required this.imageUrl, required this.categoryname});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        height: 80,
        width: 140,
        child: Row(
          children: [
            Lottie.network(
              imageUrl,
              height: 30,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(categoryname),
          ],
        ),
      ),
    );
  }
}
