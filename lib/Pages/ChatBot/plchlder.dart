import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../components/Themes/Sizing.dart';

class plchld extends StatelessWidget {
  const plchld({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.03),
        child: FloatingActionButton(
          onPressed: null,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            EvaIcons.plus,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
          color: Theme.of(context).textTheme.titleSmall!.color,
        ),
        title: Text(
          "BOOOOOOOOOOOOT",
          style: TextStyle(
              color: Theme.of(context).textTheme.titleSmall!.color,
              fontWeight: FontWeight.w500,
              fontSize: SizeConfig.screenWidth * 0.04),
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}