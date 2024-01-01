// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
// ignore_for_file: file_names, camel_case_types

class DietPage extends StatefulWidget {
  const DietPage({super.key});

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
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
          "My Diet",
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
