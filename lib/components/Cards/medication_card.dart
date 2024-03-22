import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class MedCard extends StatefulWidget {
  final String medName;
  final String dosage;
  final String time;

  const MedCard({
    super.key,
    required this.medName,
    required this.dosage,
    required this.time,
  });

  @override
  State<MedCard> createState() => _MedCardState();
}

class _MedCardState extends State<MedCard> {
  void showerrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Are you sure?!",
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .color!
                  .withOpacity(0.8),
            ),
          ),
          content: Text(
            "Are you sure that you want to delete?!",
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .color!
                  .withOpacity(0.8),
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .color!
                      .withOpacity(0.8),
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text(
                "No",
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .color!
                      .withOpacity(0.8),
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: SizeConfig.screenHeight * 0.1,
          width: SizeConfig.screenWidth * 0.75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.04),
                child: Image.asset(
                  'lib/icons/hemoglobin.png',
                  width: SizeConfig.screenWidth * 0.175,
                  height: SizeConfig.screenHeight * 0.1,
                ),
              ),
              SizedBox(width: SizeConfig.screenWidth * 0.04),
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.medName,
                        style: Theme.of(context).textTheme.bodySmall),
                    Text(widget.dosage,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
              SizedBox(width: SizeConfig.screenWidth * 0.075),
              Padding(
                padding: EdgeInsets.only(right: SizeConfig.screenWidth * 0.02),
                child: Text(widget.time,
                    style: Theme.of(context).textTheme.titleSmall),
              ),
            ],
          ),
        ),
        Positioned(
          top: SizeConfig.screenHeight * 0.0000001,
          right: SizeConfig.screenWidth * 0.0000001,
          child: GestureDetector(
            onTap: () {
              showerrorDialog();
            },
            child: Icon(
              Icons.remove_circle_outline,
              size: SizeConfig.screenWidth * 0.06,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
