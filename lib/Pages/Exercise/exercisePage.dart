// ignore_for_file: unused_local_variable, file_names, library_private_types_in_public_api, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

import '../../components/Cards/exercise_card.dart';

class Extracking extends StatefulWidget {
  const Extracking({Key? key}) : super(key: key);

  @override
  _ExtrackingState createState() => _ExtrackingState();
}

final User? user = FirebaseAuth.instance.currentUser;
final String? userId = user?.uid;

class _ExtrackingState extends State<Extracking> {
  TextEditingController exerciseNameController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();

  List<bool> selectedDates = List.filled(90, false);
  List<ExerciseCard> exerciseCards = [];

  @override
  void initState() {
    super.initState();
    fetchExercises();
  }

  Future<void> fetchExercises() async {
    try {
      DocumentReference userDoc = userInfoCollection.doc(userId);
      DocumentSnapshot snapshot = await userDoc.get();

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      Map<String, dynamic> exercisesData =
          data['Exercises'] as Map<String, dynamic>;

      exerciseCards = exercisesData.entries.map((entry) {
        String exerciseId = entry.key;
        Map<String, dynamic> exerciseData = entry.value;
        return ExerciseCard(
          exerciseName: exerciseData['exerciseName'],
          duration: exerciseData['time'],
          caloriesBurned: exerciseData['burnedCalories'],
        );
      }).toList();

      setState(() {}); // Trigger UI update
    } catch (error) {
      print('Error fetching exercises: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    SizeConfig.init(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show the exercise form dialog
          _showExerciseForm();
        },
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
                        // current exercises
                        const Text('Your exercises for the day are:'),
                        SizedBox(
                          height: SizeConfig.pointFifteenHeight,
                        ),
                        // update the page and display the newly generated exercise card here
                        Column(
                          children: exerciseCards.map((exerciseCard) {
                            return Column(
                              children: [
                                exerciseCard, // Add the ExerciseCard
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

  // Function to show a dialog for adding exercises
  void _showExerciseForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Exercise'),
          content: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: exerciseNameController,
                  decoration: const InputDecoration(labelText: 'Exercise Name'),
                ),
                TextFormField(
                  controller: timeController,
                  decoration: const InputDecoration(labelText: 'Time'),
                ),
                TextFormField(
                  controller: caloriesController,
                  decoration:
                      const InputDecoration(labelText: 'Burned Calories'),
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
                // Save the exercise details and update UI
                addExerciseToFirestore(
                  exerciseNameController.text,
                  timeController.text,
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

  CollectionReference userInfoCollection =
      FirebaseFirestore.instance.collection('UserInfo');

  Future<void> addExerciseToFirestore(
      String exerciseName, String time, String calories) async {
    try {
      DocumentReference userDoc = userInfoCollection.doc(userId);

      // Ensure an Exercises map exists, create it if necessary
      final snapshot = await userDoc.get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (!data.containsKey('Exercises')) {
        data['Exercises'] = {};
      }

      // Get the next available exercise ID (e.g., "Exercise1", "Exercise2")
      int exerciseIndex = 1;
      String exerciseId = "Exercise $exerciseIndex";
      while (data['Exercises'].containsKey(exerciseId)) {
        exerciseIndex++;
        exerciseId = "Exercise $exerciseIndex";
      }

      // Create a new exercise map
      Map<String, dynamic> exerciseData = {
        'exerciseName': exerciseName,
        'time': time,
        'burnedCalories': calories,
      };

      // Update the document with the new exercise map within the Exercises map
      await userDoc.update({
        'Exercises': {
          ...data['Exercises'],
          exerciseId: exerciseData,
        },
      });
      // Create the new ExerciseCard and add it to the list
      setState(() {
        exerciseCards.add(ExerciseCard(
          exerciseName: exerciseName,
          duration: time,
          caloriesBurned: calories,
        ));
      });
      print('Exercise added successfully!');
    } catch (error) {
      print('Error adding exercise: $error');
    }
  }
}
