// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types

import 'package:flutter/material.dart';

class categorycard extends StatelessWidget {
  final imageUrl;
  final String categoryname;
  const categorycard(
      {super.key, required this.imageUrl, required this.categoryname});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
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
            Image.asset(
              imageUrl,
              height: 40,
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
