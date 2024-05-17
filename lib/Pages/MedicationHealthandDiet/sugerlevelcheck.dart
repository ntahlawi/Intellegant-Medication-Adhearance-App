// ignore_for_file: invalid_return_type_for_catch_error, camel_case_types

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:intl/intl.dart';

import '../../components/Themes/Sizing.dart';

class slevelcheck extends StatefulWidget {
  final Function(double) updateSugarLevel; // Define the callback function
  final Function(String, String)
      updateDateAndTime; // Define the callback function

  const slevelcheck(
      {Key? key,
      required this.updateSugarLevel,
      required this.updateDateAndTime})
      : super(key: key);

  @override
  State<slevelcheck> createState() => _slevelcheckState();
}

final User? user = FirebaseAuth.instance.currentUser;
final String? userId = user?.uid;
//store select bs lever here
DateTime now = DateTime.now(); // get the curent date

String formattedDate = DateFormat('dd/MM/yyyy')
    .format(now); //store the add date here in dd/mm/yy format

final formattedTime = DateFormat('hh:mm')
    .format(now); //store the add time here in hh/mm/pm/am format

//controller
RulerPickerController? _rulerPickerController;
num currentValue = 120;
List<RulerRange> ranges = const [
  RulerRange(begin: 0, end: 2500, scale: 1),
];

class _slevelcheckState extends State<slevelcheck> {
  @override
  void initState() {
    super.initState();
    _rulerPickerController = RulerPickerController(value: currentValue);
  }

  void addSugarLevelReading(double sugarLevel) {
    // Add a new document to the subcollection 'readings' with the incremented count as the document name
    // Get the current count or initialize it to 1 if it doesn't exist
    FirebaseFirestore.instance
        .collection('SugarLevelReadings')
        .doc(userId)
        .get()
        .then((DocumentSnapshot? document) {
      int count = (document?.data() as Map<String, dynamic>?)?['count'] ?? 0;
      count++;

      // Add a new document to the subcollection 'readings' with the incremented count as the document name
      FirebaseFirestore.instance
          .collection('SugarLevelReadings')
          .doc(userId)
          .collection('readings')
          .doc(count.toString())
          .set({
        'sugarLevelReading': sugarLevel,
        'date': formattedDate,
        'time': formattedTime,
      }).then((value) {
        // Update the count in the main document
        FirebaseFirestore.instance
            .collection('SugarLevelReadings')
            .doc(userId)
            .set({'count': count}, SetOptions(merge: true));
        widget.updateDateAndTime(
            formattedDate, formattedTime); // Update date and time
        widget.updateSugarLevel(sugarLevel);
      // ignore: avoid_print
      }).catchError((error) => print("Failed to add reading: $error"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.03,
          ),

          //text to say Enter your reading
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                'Enter your reading',
                maxLines: 1,
                minFontSize: 18,
                maxFontSize: 24,
                style: TextStyle(
                  color: Theme.of(context).textTheme.labelSmall!.color,
                ),
              ),
            ],
          ),

          //a  wheel to select the blood suger level, it starts at 120 and it uses mg/dL as it's mesurment system
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  currentValue.toStringAsFixed(1),
                  style: TextStyle(
                      color: _getColorBasedOnValue(currentValue.toDouble()),
                      fontWeight: FontWeight.bold),
                  minFontSize: 80,
                  maxFontSize: 90,
                ),
                //mg/dL
                AutoSizeText(
                  'mg/dL',
                  minFontSize: 12,
                  maxFontSize: 16,
                  maxLines: 1,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.labelSmall!.color,
                  ),
                ),

                SizedBox(height: SizeConfig.screenHeight * 0.05),
                RulerPicker(
                  controller: _rulerPickerController!,
                  onBuildRulerScaleText: (index, value) {
                    return value.toInt().toString();
                  },
                  rulerBackgroundColor:
                      Theme.of(context).colorScheme.background,
                  ranges: ranges,
                  scaleLineStyleList: [
                    ScaleLineStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        width: SizeConfig.screenWidth * 0.0050,
                        height: SizeConfig.screenHeight * 0.04,
                        scale: 0),
                    ScaleLineStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        width: SizeConfig.screenWidth * 0.0030,
                        height: SizeConfig.screenHeight * 0.03,
                        scale: 5),
                    ScaleLineStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        width: SizeConfig.screenWidth * 0.0015,
                        height: SizeConfig.screenHeight * 0.02,
                        scale: -1)
                  ],
                  onValueChanged: (value) {
                    setState(() {
                      currentValue = value;
                    });
                  },
                  width: MediaQuery.of(context).size.width,
                  height: SizeConfig.screenHeight * 0.08,
                  rulerMarginTop: SizeConfig.screenHeight * 0.008,
                  rulerScaleTextStyle: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .color
                          ?.withOpacity(0.5)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.03,
          ),
          //text
          AutoSizeText(
            _getTextBasedOnValue(currentValue.toDouble()),
            minFontSize: 16,
            maxFontSize: 24,
            maxLines: 1,
            style: TextStyle(
                color: _getColorBasedOnValue(currentValue.toDouble()),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.03,
          ),
          //submit reading button
          InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              addSugarLevelReading(currentValue.toDouble());
              Navigator.of(context).pop();
              widget.updateSugarLevel(currentValue.toDouble());
            },
            child: Center(
              child: Container(
                height: SizeConfig.screenHeight * 0.05,
                width: SizeConfig.screenWidth * 0.8,
                padding: EdgeInsets.all(SizeConfig.pointFifteenWidth),
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.pointFifteenWidth),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Center(
                  child: Text('Add Your Reading'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Color _getColorBasedOnValue(double value) {
  if (value <= 69) {
    return Colors.red;
  } else if (value > 69 && value <= 180) {
    return Colors.green;
  } else if (value > 180 && value <= 250) {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}

String _getTextBasedOnValue(double value) {
  if (value <= 54) {
    return "Reading is too low";
  } else if (value > 54 && value <= 69) {
    return 'Reading is low';
  } else if (value >= 400) {
    return "Reading is too high";
  } else {
    return "";
  }
}
