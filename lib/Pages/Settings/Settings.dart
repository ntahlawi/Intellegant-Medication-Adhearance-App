// ignore_for_file: file_names

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:medappfv/Pages/login_signup/login_page.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:medappfv/components/Widgets/Cards/settingscard.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      //Logout button start
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.1),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const LoginPage();
                },
              ),
            );
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          splashColor: isDarkMode ? Colors.black.withOpacity(.3) : null,
          label: Text(
            'Logout',
            style: TextStyle(
                color: Theme.of(context).textTheme.titleMedium!.color,
                fontSize: SizeConfig.screenWidth * 0.033,
                fontWeight: FontWeight.w500),
          ),
          icon: Icon(
            EvaIcons.logOutOutline,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      //Logout button finish

      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.045,
              ),

              //Settings header
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.075),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.titleSmall!.color,
                          fontSize: SizeConfig.screenWidth * 0.099,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.025,
              ),
              //Account
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.065),
                child: Row(
                  children: [
                    Icon(
                      EvaIcons.personOutline,
                      color: Theme.of(context).textTheme.titleSmall!.color,
                      size: SizeConfig.screenWidth * 0.08,
                    ),
                    SizedBox(
                      width: SizeConfig.screenWidth * 0.015,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.screenHeight * 0.00525),
                      child: Text(
                        'Account',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.titleSmall!.color,
                            fontSize: SizeConfig.screenWidth * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: SizeConfig.screenHeight * 0.005,
              ),
              // Dividor
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.06),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(.2),
                      ),
                    )
                  ],
                ),
              ),

              //edit Profile card
              const settingscard(
                  cardtext: 'Edit Profile', icon: EvaIcons.chevronRightOutline),

              SizedBox(
                height: SizeConfig.screenHeight * 0.005,
              ),

              // Change Password card
              const settingscard(
                  cardtext: 'Change password',
                  icon: EvaIcons.chevronRightOutline),

              SizedBox(
                height: SizeConfig.screenHeight * 0.025,
              ),
              //Notifications
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.065),
                child: Row(
                  children: [
                    Icon(
                      EvaIcons.bellOutline,
                      color: Theme.of(context).textTheme.titleSmall!.color,
                      size: SizeConfig.screenWidth * 0.08,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.screenHeight * 0.00525),
                      child: Text(
                        'Notifications',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.titleSmall!.color,
                            fontSize: SizeConfig.screenWidth * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: SizeConfig.screenHeight * 0.005,
              ),
              // Dividor
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.06),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(.2),
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: SizeConfig.screenHeight * 0.005,
              ),

              // Medication notifications
              const settingscard(
                  cardtext: 'Medication notifications',
                  icon: EvaIcons.toggleRightOutline),
              // App notifications
              const settingscard(
                  cardtext: 'App notifications',
                  icon: EvaIcons.toggleLeftOutline),

              SizedBox(
                height: SizeConfig.screenHeight * 0.025,
              ),

              // More
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.065),
                child: Row(
                  children: [
                    Icon(
                      EvaIcons.personAddOutline,
                      color: Theme.of(context).textTheme.titleSmall!.color,
                      size: SizeConfig.screenWidth * 0.08,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.screenHeight * 0.00525),
                      child: Text(
                        'More',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.titleSmall!.color,
                            fontSize: SizeConfig.screenWidth * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              // Dividor
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.06),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(.2),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.005,
              ),
              //Language Selection card
              const settingscard(
                  cardtext: 'Language selection', icon: EvaIcons.globe2Outline)
            ],
          ),
        ),
      ),
    );
  }
}
