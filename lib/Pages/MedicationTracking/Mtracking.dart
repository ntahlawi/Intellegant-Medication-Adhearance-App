// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Mtracking extends StatelessWidget {
  const Mtracking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Container(
          color: Theme.of(context).colorScheme.primary,
          width: 300,
          height: 300,
          child: Center(
            child: Text(
              'Mtracking',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }
}
