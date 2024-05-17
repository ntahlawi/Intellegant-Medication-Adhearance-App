
// ignore_for_file: unused_local_variable, file_names, library_private_types_in_public_api, empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:medappfv/components/Cards/date_card.dart';
import 'package:medappfv/components/Cards/diet_card.dart';

class DietTracking extends StatefulWidget {
  const DietTracking({Key? key}) : super(key: key);

  @override
  _DietTrackingState createState() => _DietTrackingState();
}
 // Firebase references
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userId = user?.uid;
  final CollectionReference userInfoCollection = 
      FirebaseFirestore.instance.collection('UserInfo'); 
class _DietTrackingState extends State<DietTracking> {
  // Controllers for form fields
  TextEditingController mealController = TextEditingController();
  TextEditingController portionController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();

  // State variables
  List<bool> selectedDates = List.filled(90, false); 
  List<DietCard> dietCards = []; 

 


  @override
  void initState() {
    super.initState();
    fetchDiet(); // Load diet on screen initialization
  }

  // Fetch diet for the user from Firestore
  Future<void> fetchDiet() async {
    try {
      DocumentReference userDoc = userInfoCollection.doc(userId);
      DocumentSnapshot snapshot = await userDoc.get();

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      Map<String, dynamic> dietData = data['Diet'] as Map<String, dynamic>;

      setState(() {
        dietCards = dietData.entries.map((entry) {
          return DietCard(
            meal: entry.value['Meal'],
            portion: entry.value['Portion'],
            calories: entry.value['Calories'],
          );
        }).toList();
      }); 
    } catch (error) {
    }
  }

  // UI Build Method
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    SizeConfig.init(context); 

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showDietForm,
        backgroundColor: Theme.of(context).colorScheme.primary, 
        child: const Icon(Icons.add),
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
              // Date Cards
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: generateDateCards(),
                ),
              ),
              SizedBox(height: SizeConfig.pointThreeHeight),

              // Diet Card
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
                        SizedBox(height: SizeConfig.pointFifteenHeight),
                        const Text('Your diet for the day is:'),
                        SizedBox(height: SizeConfig.pointFifteenHeight),

                        // Display diet cards here
                        Column(
                          children: dietCards.map((dietCard) => Column(
                              children: [
                                dietCard,
                                SizedBox(height: SizeConfig.pointThreeHeight), 
                              ],
                            )).toList(), 
                        ),
                        SizedBox(height: SizeConfig.pointThreeHeight),
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
          title: const Text('Add Diet'),
          content: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: mealController,
                  decoration: const InputDecoration(labelText: 'Meal'),
                ),
                TextFormField(
                  controller: portionController,
                  decoration: const InputDecoration(labelText: 'Portion'),
                ),
                TextFormField(
                  controller: caloriesController,
                  decoration: const InputDecoration(labelText: 'Calories'),
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
              child: const Text('Cancel'),
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
              child: const Text('Save'),
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
        date: day.toString(),
        month: getMonthAbbreviation(month),
        isSelected: selectedDates[i],
        onTap: () {
          setState(() {
            for (int j = 0; j < selectedDates.length; j++) {
              selectedDates[j] = (j == i);
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
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
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
          meal: meal,
          portion: portion,
          calories: calories,
        ));
      });
    } catch (error) {
    }
  }
}
