import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:medappfv/components/Widgets/Cards/DateCard.dart';

import '../../components/Widgets/Cards/DietCard.dart';

class DietTracking extends StatefulWidget {
  const DietTracking({Key? key}) : super(key: key);

  @override
  _DietTrackingState createState() => _DietTrackingState();
}

final User? user = FirebaseAuth.instance.currentUser;
final String? userId = user?.uid;

class _DietTrackingState extends State<DietTracking> {
  TextEditingController mealController = TextEditingController();
  TextEditingController portionController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();

  List<bool> selectedDates = List.filled(90, false);
  List<DietCard> dietCards = [];

  @override
  void initState() {
    super.initState();
    fetchDiet();
  }

  Future<void> fetchDiet() async {
    try {
      DocumentReference userDoc = userInfoCollection.doc(userId);
      DocumentSnapshot snapshot = await userDoc.get();

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic> ?? {};
      Map<String, dynamic> dietData = data['Diet'] as Map<String, dynamic> ?? {};

      dietCards = dietData.entries.map((entry) {
        String dietId = entry.key;
        Map<String, dynamic> dietInfo = entry.value;
        return DietCard(
          Meal: dietInfo['Meal'],
          Portion: dietInfo['Portion'],
          Calories: dietInfo['Calories'],
        );
      }).toList();

      setState(() {}); // Trigger UI update
    } catch (error) {
      print('Error fetching diet: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    SizeConfig.init(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show the diet form dialog
          _showDietForm();
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.screenHeight * 0.06,
            left: SizeConfig.screenWidth * 0.04,
            right: SizeConfig.screenWidth * 0.04,
          ),
          child: Column(
            children: [
              // cards display for each day
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: generateDateCards(),
                ),
              ),
              SizedBox(
                height: SizeConfig.pointThreeHeight,
              ),
              // card
              Card(
                color: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.075,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.pointFifteenHeight,
                        ),
                        // current diet
                        Text('Your diet for the day is:'),
                        SizedBox(
                          height: SizeConfig.pointFifteenHeight,
                        ),
                        // update the page and display the newly generated diet card here
                        Column(
                          children: dietCards.map((dietCard) {
                            return Column(
                              children: [
                                dietCard, // Add the DietCard
                                SizedBox(
                                  height: SizeConfig.pointThreeHeight,
                                ), // Add spacing
                              ],
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: SizeConfig.pointThreeHeight,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Function to show a dialog for adding diet
  void _showDietForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Diet'),
          content: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: mealController,
                  decoration: InputDecoration(labelText: 'Meal'),
                ),
                TextFormField(
                  controller: portionController,
                  decoration: InputDecoration(labelText: 'Portion'),
                ),
                TextFormField(
                  controller: caloriesController,
                  decoration: InputDecoration(labelText: 'Calories'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Save the diet details and update UI
                addDietToFirestore(
                  mealController.text,
                  portionController.text,
                  caloriesController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Function to generate date cards
  List<Widget> generateDateCards() {
    List<Widget> dateCards = [];
    DateTime currentDate = DateTime.now();
    for (int i = 0; i < 90; i++) {
      DateTime nextDate = currentDate.add(Duration(days: i));
      int day = nextDate.day;
      int month = nextDate.month;

      DateCard dateCard = DateCard(
        Date: day.toString(),
        month: getMonthAbbreviation(month),
        isSelected: selectedDates[i],
        onTap: () {
          setState(() {
            for (int j = 0; j < selectedDates.length; j++) {
              selectedDates[j] = (j == i);
              print("Tapped DateCard Index: $i");
            }
          });
        },
      );

      dateCards.add(dateCard);
    }

    return dateCards;
  }

  // Function to get the month abbreviation
  String getMonthAbbreviation(int month) {
    switch (month) {
      case 1:
        return 'JAN';
      case 2:
        return 'FEB';
      case 3:
        return 'MAR';
      case 4:
        return 'APR';
      case 5:
        return 'MAY';
      case 6:
        return 'JUN';
      case 7:
        return 'JUL';
      case 8:
        return 'AUG';
      case 9:
        return 'SEP';
      case 10:
        return 'OCT';
      case 11:
        return 'NOV';
      case 12:
        return 'DEC';
      default:
        return '';
    }
  }

  CollectionReference userInfoCollection =
      FirebaseFirestore.instance.collection('UserInfo');

  Future<void> addDietToFirestore(
      String meal, String portion, String calories) async {
    try {
      DocumentReference userDoc = userInfoCollection.doc(userId);

      // Ensure a Diet map exists, create it if necessary
      final snapshot = await userDoc.get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic> ?? {};
      if (!data.containsKey('Diet')) {
        data['Diet'] = {};
      }

      // Get the next available diet ID (e.g., "Diet1", "Diet2")
      int dietIndex = 1;
      String dietId = "Diet $dietIndex";
      while (data['Diet'].containsKey(dietId)) {
        dietIndex++;
        dietId = "Diet $dietIndex";
      }

      // Create a new diet map
      Map<String, dynamic> dietData = {
        'Meal': meal,
        'Portion': portion,
        'Calories': calories,
      };

      // Update the document with the new diet map within the Diet map
      await userDoc.update({
        'Diet': {
          ...data['Diet'],
          dietId: dietData,
        },
      });
      // Create the new DietCard and add it to the list
      setState(() {
        dietCards.add(DietCard(
          Meal: meal,
          Portion: portion,
          Calories: calories,
        ));
      });
      print('Diet added successfully!');
    } catch (error) {
      print('Error adding diet: $error');
    }
  }
}
