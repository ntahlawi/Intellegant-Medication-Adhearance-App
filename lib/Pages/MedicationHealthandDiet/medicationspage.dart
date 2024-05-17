// ignore_for_file: unused_local_variable, library_private_types_in_public_api, avoid_print, use_build_context_synchronously, prefer_const_constructors, sized_box_for_whitespace

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:medappfv/components/Themes/Sizing.dart';

import '../../components/Cards/medication_card.dart';

class Mtracking extends StatefulWidget {
  const Mtracking({Key? key}) : super(key: key);

  @override
  _MtrackingState createState() => _MtrackingState();
}

final User? user = FirebaseAuth.instance.currentUser;
final String? userId = user?.uid;
late bool isTaken;
// ignore: non_constant_identifier_names
String TornotT = 'Not taken';

class _MtrackingState extends State<Mtracking> {
  int? selectedInterval;
  double? selectedDosage; // Initialize as null
  DateTime? selectedStartDate;
  TimeOfDay? selectedStartTime;

  TextEditingController medNameController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  TextEditingController timeController = TextEditingController();

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

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      Map<String, dynamic> medicationsData =
          data['Medications'] as Map<String, dynamic>;

      medicationCards = medicationsData.entries.map((entry) {
        String medicationId = entry.key; // Extract the ID
        Map<String, dynamic> medicationData = entry.value;

        // Set default value for isTaken based on medicationData (if present)
        bool isTakenValue = medicationData.containsKey('isTaken')
            ? medicationData['isTaken'] as bool
            : false; // Set default to false

        return MedCard(
          medId: medicationId, // Pass the medId
          medName: medicationData['medicationName'],
          dosage: medicationData['dosage'],
          onDelete: _deleteMedication, // Pass the function
          onArchive: _arcmed,
          isTaken: isTakenValue, // Pass the initialized isTaken value
        );
      }).toList();

      setState(() {}); // Trigger UI update
    } catch (error) {
      print('Error fetching medications: $error');
      // Handle errors appropriately, e.g., display an error message to the user
    }
  }

  CollectionReference userInfoCollection =
      FirebaseFirestore.instance.collection('UserInfo');
  Future<void> addMedicationToFirestore(
    String medicationName,
    String type,
    String dosage,
    String interval,
    String intervalType,
    DateTime selectedStartDate,
    TimeOfDay selectedStartTime,
  ) async {
    try {
      bool isTaken = false;
      DocumentReference userDoc = userInfoCollection.doc(userId);

      // Ensure a Medications map exists, create it if necessary
      final snapshot = await userDoc.get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (!data.containsKey('Medications')) {
        data['Medications'] = {};
      }

      // Get next medication index
      int medicationIndex = 1;
      String medicationId = "Medication $medicationIndex";
      while (data['Medications'].containsKey(medicationId)) {
        medicationIndex++;
        medicationId = "Medication $medicationIndex";
      }
      String firestoreDocId = userDoc.collection('Medications').doc().id;

      // Create medication map
      Map<String, dynamic> medicationData = {
        'medicationName': medicationName,
        'type': type,
        'interval': interval,
        'dosage': dosage,
        'time': selectedStartTime.format(context),
        'startDate': selectedStartDate.toString(),
        'medId': firestoreDocId,
        'isTaken': isTaken,
      };
      // Update the document with the new medication map within the Medications map
      await userDoc.update({
        'Medications': {
          ...data['Medications'],
          firestoreDocId: medicationData, // Use firestoreDocId as the key
        },
      });
      // Create the new MedCard and add it to the list
      setState(() {
        medicationCards.add(MedCard(
          medName: medicationName,
          dosage: dosage,
          medId: firestoreDocId,
          onDelete: _deleteMedication, // Pass the function
          onArchive: _arcmed,
          isTaken: isTaken = false,
        ));
      });
      print('Medication added successfully!');
    } catch (error) {
      print('Error adding medication: $error');
    }
  }

  void _deleteMedication(String medId) async {
    try {
      await FirebaseFirestore.instance
          .collection('UserInfo')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({
        'Medications.$medId': FieldValue.delete(),
      });
      await fetchMedications();
    } catch (e) {
      print('Failed to delete medication: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete medication. Please try again.'),
        ),
      );
    }
  }

  void _arcmed(String medId) async {
    try {
      await FirebaseFirestore.instance
          .collection('UserInfo')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({
        'Medications.$medId.isTaken': true,
      });
      await fetchMedications();

      print(
          "Medication marked as taken successfully!"); // Optional success message
    } catch (e) {
      print("Error updating medication taken status: $e"); // Error handling
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    SizeConfig.init(context);

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Show the medication form dialog
            _showMedicationForm();
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.screenHeight * 0.02,
              left: SizeConfig.screenWidth * 0.04,
              right: SizeConfig.screenWidth * 0.04,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //
                    InkWell(
                      child: Container(
                        height: SizeConfig.screenHeight * 0.04,
                        width: SizeConfig.screenWidth * 0.3,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary, // Main button color
                          borderRadius: BorderRadius.circular(24),
                          border: TornotT == 'Not taken'
                              ? Border.all(
                                  color: Colors.black,
                                  width: 2.0, // Adjust outline thickness
                                )
                              : null, // No border if not selected
                        ),
                        child: Center(
                          child: AutoSizeText(
                            'Not taken',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .color,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          TornotT = 'Not taken';
                        });
                      },
                    ),
                    SizedBox(
                      width: SizeConfig.screenWidth * 0.04,
                    ),
                    InkWell(
                      child: Container(
                        height: SizeConfig.screenHeight * 0.04,
                        width: SizeConfig.screenWidth * 0.3,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary, // Main button color
                          borderRadius: BorderRadius.circular(24),
                          border: TornotT == 'Taken'
                              ? Border.all(
                                  color: Colors.black,
                                  width: 2.0, // Adjust outline thickness
                                )
                              : null, // No border if not selected
                        ),
                        child: Center(
                          child: AutoSizeText(
                            'Taken',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .color,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          TornotT = 'Taken';
                        });
                      },
                    ),
                  ],
                ),

                SizedBox(
                  height: SizeConfig.pointThreeHeight,
                ),
                // card
                Column(
                  children: medicationCards.where((medCard) {
                    return (TornotT == 'Not taken' && !medCard.isTaken) ||
                        (TornotT == 'Taken' && medCard.isTaken);
                  }).map((medCard) {
                    return MedCard(
                      medId: medCard.medId,
                      medName: medCard.medName,
                      dosage: medCard.dosage,
                      onDelete: medCard.onDelete,
                      onArchive: medCard.onArchive,
                      isTaken: TornotT == 'Not taken'
                          ? !medCard.isTaken
                          : medCard.isTaken, // Set isTaken based on TornotT
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Function to show a dialog for adding medications

  void _showMedicationForm() {
    String? selectedType = 'Pill';
    double? selectedDosage;
    double? selectedInterval;
    String? selectedIntervalType;
    DateTime? selectedStartDate;
    TimeOfDay? selectedStartTime;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: AlertDialog(
                scrollable: true,
                title: Text(
                  'Add Medication',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.titleSmall!.color,
                  ),
                ),
                content: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: medNameController,
                        decoration: InputDecoration(),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.025,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                selectedType = 'Pill';
                              });
                            },
                            style: ButtonStyle(
                              side:
                                  MaterialStateProperty.resolveWith<BorderSide>(
                                (states) {
                                  if (selectedType == 'Pill') {
                                    return BorderSide(
                                        color: Colors.blue, width: 2);
                                  } else {
                                    return BorderSide(
                                        color: Colors.grey, width: 1);
                                  }
                                },
                              ),
                            ),
                            child: Text('Pill'),
                          ),
                          SizedBox(width: 10),
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                selectedType = 'Syrup';
                              });
                            },
                            style: ButtonStyle(
                              side:
                                  MaterialStateProperty.resolveWith<BorderSide>(
                                (states) {
                                  if (selectedType == 'Syrup') {
                                    return BorderSide(
                                        color: Colors.blue, width: 2);
                                  } else {
                                    return BorderSide(
                                        color: Colors.grey, width: 1);
                                  }
                                },
                              ),
                            ),
                            child: Text('Syrup'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.025,
                      ),
                      // Dosage Selection
                      if (selectedType == 'Pill')
                        Column(
                          children: [
                            Text(
                              'Select Dosage (Pills)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 150,
                              child: CupertinoPicker(
                                itemExtent: 50,
                                onSelectedItemChanged: (index) {
                                  setState(() {
                                    selectedDosage = (index + 1) * 0.5;
                                  });
                                },
                                children: List.generate(20, (index) {
                                  return Center(
                                    child: Text('${(index + 1) * 0.5}'),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      if (selectedType == 'Syrup')
                        Column(
                          children: [
                            Text(
                              'Select Dosage (ml)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 150,
                              child: CupertinoPicker(
                                itemExtent: 50,
                                onSelectedItemChanged: (index) {
                                  setState(() {
                                    selectedDosage = (index + 1) * 5.0;
                                  });
                                },
                                children: List.generate(20, (index) {
                                  return Center(
                                    child: Text('${(index + 1) * 5}'),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.05,
                      ),
                      // Interval Selection
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            child: CupertinoPicker(
                              itemExtent: 50,
                              onSelectedItemChanged: (index) {
                                setState(() {
                                  selectedInterval = (index + 1) * 0.5;
                                });
                              },
                              children: List.generate(20, (index) {
                                return Center(
                                  child: Text('${(index + 1) * 0.5}'),
                                );
                              }),
                            ),
                          ),
                          SizedBox(width: 20),
                          Center(
                            child: Container(
                              width: 100,
                              child: CupertinoPicker(
                                itemExtent: 50,
                                onSelectedItemChanged: (index) {
                                  setState(() {
                                    switch (index) {
                                      case 0:
                                        selectedIntervalType = 'hours';
                                        break;
                                      case 1:
                                        selectedIntervalType = 'days';
                                        break;
                                      case 2:
                                        selectedIntervalType = 'weeks';
                                        break;
                                      default:
                                        selectedIntervalType = 'hours';
                                    }
                                  });
                                },
                                children: const [
                                  Center(child: Text('hours')),
                                  Center(child: Text('days')),
                                  Center(child: Text('weeks')),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.05,
                      ),
                      Text(
                        '${selectedDosage ?? 0.5} ${selectedType == 'Syrup' ? 'ml' : (selectedDosage == 1 || selectedDosage == 0.5 ? 'pill' : 'pills')} every ${selectedInterval ?? 0} ${selectedIntervalType ?? 'interval'}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.05,
                      ),
                      Container(
                        height: SizeConfig.screenHeight * 0.25,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.dateAndTime,
                          initialDateTime: DateTime.now(),
                          onDateTimeChanged: (DateTime dateTime) {
                            setState(() {
                              selectedStartDate = dateTime;
                              selectedStartTime =
                                  TimeOfDay.fromDateTime(dateTime);
                            });
                          },
                        ),
                      ),

                      SizedBox(
                        height: SizeConfig.screenHeight * 0.025,
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
                      addMedicationToFirestore(
                        medNameController.text,
                        selectedType!, // No need to convert to string
                        selectedDosage!.toStringAsFixed(
                            2), // Example: Formats to 2 decimal places
                        selectedInterval!.toStringAsFixed(
                            1), // Example: Formats to 1 decimal place
                        selectedIntervalType.toString(),
                        selectedStartDate!,
                        selectedStartTime!,
                      );

                      Navigator.of(context).pop();
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
