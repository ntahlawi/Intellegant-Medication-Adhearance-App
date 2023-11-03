import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Container(
            child: Center(
              child: Text(
                'home',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            color: Theme.of(context).colorScheme.primary,
            width: 300,
            height: 300,
          ),
        ),
      ),
    );
  }
}
