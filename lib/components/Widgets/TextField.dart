// ignore_for_file: file_names, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class CustomTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final IconName;
  final bool obscuretext;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.IconName,
    required this.obscuretext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.screenWidth * 0.05,
      ),
      child: TextField(
        style: TextStyle(
          color: Theme.of(context).textTheme.labelMedium!.color,
        ),
        textAlign: TextAlign.justify,
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.surface),
            borderRadius: BorderRadius.circular(24),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).textTheme.labelMedium!.color,
          ),
          prefixIcon: Container(
            margin: EdgeInsets.only(
              right: SizeConfig.screenWidth * 0.045, // hint rext distance
              top: SizeConfig.pointFifteenHeight,
              bottom: SizeConfig.pointFifteenHeight,
              left: SizeConfig.pointFifteenWidth,
            ),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(.8),
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(right: SizeConfig.pointFifteenWidth),
              child: Icon(
                IconName,
                color: Theme.of(context).iconTheme.color!.withOpacity(.7),
                size: MediaQuery.of(context).size.width * 0.055,
              ),
            ),
          ),
          prefixIconColor: Theme.of(context).iconTheme.color,
          prefixIconConstraints: const BoxConstraints(),
        ),
        obscureText: obscuretext,
        cursorColor: Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }
}
