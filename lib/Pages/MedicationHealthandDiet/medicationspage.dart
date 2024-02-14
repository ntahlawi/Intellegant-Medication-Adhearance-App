import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:medappfv/components/Widgets/Cards/date_card.dart';

import '../../components/Widgets/Cards/medication_card.dart';

class Mtracking extends StatefulWidget {
  const Mtracking({Key? key}) : super(key: key);

  @override
  _MtrackingState createState() => _MtrackingState();
}

final User? user = FirebaseAuth.instance.currentUser;
final String? userId = user?.uid;

class _MtrackingState extends State<Mtracking> {
  TextEditingController medNameController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  List<bool> selectedDates =
      List.filled(90, false); // Initialize with all false
  List<MedCard> medicationCards = []; // List to store generated MedCards

  @override
  void initState() {
    super.initState();
    fetchMedications();
  }

  Future<void> fetchMedications() async {
    try {
      DocumentReference userDoc = userInfoCollection.doc(userId);
      DocumentSnapshot snapshot = await userDoc.get();

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic> ?? {};
      Map<String, dynamic> medicationsData =
          data['Medications'] as Map<String, dynamic> ?? {};

      medicationCards = medicationsData.entries.map((entry) {
        String medicationId = entry.key;
        Map<String, dynamic> medicationData = entry.value;
        return MedCard(
          medName: medicationData['medicationName'],
          dosage: medicationData['dosage'],
          time: medicationData['time'],
        );
      }).toList();

      setState(() {}); // Trigger UI update
    } catch (error) {
      print('Error fetching medications: $error');
      // Handle errors appropriately, e.g., display an error message to the user
    }
  }

  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    SizeConfig.init(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show the medication form dialog
          _showMedicationForm();
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
                      horizontal: SizeConfig.screenWidth * 0.075),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.pointFifteenHeight,
                        ),
                        // current medications
                        Text('Your medications for the day are:'),
                        SizedBox(
                          height: SizeConfig.pointFifteenHeight,
                        ),
                        // update the page and display the newly generated medcard here
                        Column(
                          children: medicationCards.map((medCard) {
                            return Column(
                              children: [
                                medCard, // Add the MedCard
                                SizedBox(
                                    height: SizeConfig
                                        .pointThreeHeight), // Add spacing
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

// Function to show a dialog for adding medications
  void _showMedicationForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add Medication',
            style:
                TextStyle(color: Theme.of(context).textTheme.titleSmall!.color),
          ),
          content: Form(
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(
                      color: Theme.of(context).textTheme.titleSmall!.color),
                  controller: medNameController,
                  decoration: InputDecoration(labelText: 'Medication Name'),
                ),
                TextFormField(
                  style: TextStyle(
                      color: Theme.of(context).textTheme.titleSmall!.color),
                  controller: dosageController,
                  decoration: InputDecoration(labelText: 'Dosage'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  style: TextStyle(
                      color: Theme.of(context).textTheme.titleSmall!.color),
                  controller: timeController,
                  decoration:
                      InputDecoration(labelText: 'Intervals (e.g., 8 hours)'),
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
                // Save the medication details and update UI
                addMedicationToFirestore(
                  medNameController.text,
                  dosageController.text,
                  timeController.text,
                );
                Navigator.of(context).pop();
                print(userId);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  //a function to get the current day and month from the device and generates cards accordingly
  List<Widget> generateDateCards() {
    List<Widget> dateCards = [];
    // Get the current date and time
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
          // date selection logic
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
  Future<void> addMedicationToFirestore(
      String medicationName, String dosage, String time) async {
    try {
      DocumentReference userDoc = userInfoCollection.doc(userId);

      // Ensure a Medications map exists, create it if necessary
      final snapshot = await userDoc.get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic> ?? {};
      if (!data.containsKey('Medications')) {
        data['Medications'] = {};
      }

      // Get the next available medication ID (e.g., "Medication1", "Medication2")
      int medicationIndex = 1;
      String medicationId = "Medication $medicationIndex";
      while (data['Medications'].containsKey(medicationId)) {
        medicationIndex++;
        medicationId = "Medication $medicationIndex";
      }

      // Create a new medication map
      Map<String, dynamic> medicationData = {
        'medicationName': medicationName,
        'dosage': dosage,
        'time': time,
      };

      // Update the document with the new medication map within the Medications map
      await userDoc.update({
        'Medications': {
          ...data['Medications'],
          medicationId: medicationData,
        },
      });
      // Create the new MedCard and add it to the list
      setState(() {
        medicationCards.add(MedCard(
          medName: medicationName,
          dosage: dosage,
          time: time,
        ));
      });
      print('Medication added successfully!');
    } catch (error) {
      print('Error adding medication: $error');
    }
  }

}
