import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medappfv/components/Cards/exercise_card.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class ExerciseTracking extends StatefulWidget {
  const ExerciseTracking({Key? key}) : super(key: key);

  @override
  _ExerciseTrackingState createState() => _ExerciseTrackingState();
}

class _ExerciseTrackingState extends State<ExerciseTracking> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  TextEditingController exerciseController = TextEditingController();
  TextEditingController durationController = TextEditingController();

  List<ExerciseCard> exerciseCards = [];
  double totalCalories = 0;
  double userWeight = 70.0; // Default weight

  @override
  void initState() {
    super.initState();
    fetchUserWeight();
    fetchExercises();
  }

  Future<void> fetchUserWeight() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('UserInfo').doc(userId).get();
    if (userDoc.exists && userDoc.data() != null) {
      var data = userDoc.data() as Map<String, dynamic>;
      setState(() {
        userWeight = data['Weight']; // Use default weight if not specified
      });
    }
  }

  Future<void> fetchExercises() async {
    String currentDayId = DateFormat('yyyy-MM-dd').format(DateTime.now());
    DocumentReference dayDoc = FirebaseFirestore.instance.collection('UserInfo').doc(userId).collection('DailyCalories').doc(currentDayId);
    DocumentSnapshot daySnapshot = await dayDoc.get();
    if (daySnapshot.exists && daySnapshot.data() != null) {
      var dayData = daySnapshot.data() as Map<String, dynamic>;
      List<dynamic> exercises = dayData['exercises'] ?? [];
      List<ExerciseCard> newCards = exercises.map((exercise) {
        Map<String, dynamic> exerciseMap = exercise as Map<String, dynamic>;
        return ExerciseCard(
          exerciseType: exerciseMap['exerciseType'],
          duration: exerciseMap['duration'],
          caloriesBurned: exerciseMap['caloriesBurned'] as double,
          exerciseId: exerciseMap['exerciseId'],
          onDelete: () => deleteExercise(exerciseMap),
        );
      }).toList();
      setState(() {
        exerciseCards = newCards;
        totalCalories = exercises.fold(0, (sum, exercise) => sum + (exercise['caloriesBurned'] as double));
        if (totalCalories < 0) totalCalories = 0; // Ensure non-negative value
      });
    } else {
      setState(() {
        exerciseCards = [];  // Clear the list if no exercises found for today
        totalCalories = 0;
      });
    }
  }

  Future<void> addExerciseToFirestore(String exerciseType, int duration) async {
    double caloriesBurned = calculateCalories(exerciseType, duration);
    String currentDayId = DateFormat('yyyy-MM-dd').format(DateTime.now());

    Map<String, dynamic> exerciseData = {
      'exerciseType': exerciseType,
      'duration': duration,
      'caloriesBurned': caloriesBurned,
      'exerciseId': FirebaseFirestore.instance.collection('UserInfo').doc(userId).collection('DailyCalories').doc(currentDayId).collection('exercises').doc().id,
    };

    DocumentReference dayDoc = FirebaseFirestore.instance.collection('UserInfo').doc(userId).collection('DailyCalories').doc(currentDayId);
    await dayDoc.set({
      'date': currentDayId,
      'caloriesBurned': FieldValue.increment(caloriesBurned),
      'exercises': FieldValue.arrayUnion([exerciseData])
    }, SetOptions(merge: true));

    fetchExercises();  // Refresh the exercise cards
  }

  Future<void> deleteExercise(Map<String, dynamic> exercise) async {
    try {
      String currentDayId = DateFormat('yyyy-MM-dd').format(DateTime.now());
      DocumentReference dayDoc = FirebaseFirestore.instance
          .collection('UserInfo')
          .doc(userId)
          .collection('DailyCalories')
          .doc(currentDayId);

      // Get the current list of exercises
      DocumentSnapshot daySnapshot = await dayDoc.get();
      if (daySnapshot.exists && daySnapshot.data() != null) {
        var dayData = daySnapshot.data() as Map<String, dynamic>;
        List<dynamic> exercises = dayData['exercises'] ?? [];

        // Remove the exercise from the list
        exercises.removeWhere((e) => e['exerciseId'] == exercise['exerciseId']);

        // Recalculate the total calories burned
        double newTotalCalories = 0;
        for (var exercise in exercises) {
          newTotalCalories += exercise['caloriesBurned'] as double;
        }
        newTotalCalories = newTotalCalories < 0 ? 0 : newTotalCalories; // Ensure non-negative value

        // Update the Firestore document with the new list of exercises and total calories
        await dayDoc.update({
          'exercises': exercises,
          'caloriesBurned': newTotalCalories,
        });

        fetchExercises();  // Refresh the exercise cards
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Exercise deleted successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print('Error deleting exercise: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete exercise. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  double calculateCalories(String exerciseType, int duration) {
    double metValue = getMetValue(exerciseType);
    return (metValue * userWeight * duration / 60);
  }

  double getMetValue(String exerciseType) {
    switch (exerciseType.toLowerCase()) {
      case 'walking': return 3.3;
      case 'jogging': return 7.0;
      case 'running': return 9.8;
      case 'tennis': return 7.3;
      case 'football': return 8.0;
      case 'cycling': return 8.5;
      default: return 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _showExerciseForm,
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
                AutoSizeText(
                  'Exercise tracking to maintain a healthy life',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.titleSmall!.color,
                      fontWeight: FontWeight.w500,
                      fontSize: 24),
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.15),
                Expanded(
                  child: ListView(
                    children: exerciseCards.map((card) {
                      return Column(
                        children: [card, SizedBox(height: SizeConfig.pointThreeHeight)],
                      );
                    }).toList(),
                  ),
                ),
                AutoSizeText('Total Calories Burned: ${totalCalories.round()}'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showExerciseForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Log Exercise', style: TextStyle(color: Theme.of(context).textTheme.titleSmall!.color)),
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Exercise Type'),
                  items: ['Walking', 'Jogging', 'Running', 'Tennis', 'Football', 'Cycling']
                      .map((String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                  onChanged: (newValue) {
                    exerciseController.text = newValue!;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Duration (minutes)'),
                  controller: durationController,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                addExerciseToFirestore(
                  exerciseController.text,
                  int.parse(durationController.text),
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
}
