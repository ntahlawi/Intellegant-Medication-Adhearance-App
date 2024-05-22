import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:intl/intl.dart';

class ExerciseCard extends StatefulWidget {
  final String exerciseType;
  final int duration;
  final double caloriesBurned;
  final String exerciseId;
  final VoidCallback onDelete;

  ExerciseCard({
    Key? key,
    required this.exerciseType,
    required this.duration,
    required this.caloriesBurned,
    required this.exerciseId,
    required this.onDelete,
  }) : super(key: key);

  @override
  _ExerciseCardState createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  Future<void> _deleteExercise() async {
    try {
      final String userId = FirebaseAuth.instance.currentUser!.uid;
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
        exercises.removeWhere((e) => e['exerciseId'] == widget.exerciseId);

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

        print("Exercise deleted successfully: ${widget.exerciseId}");
        widget.onDelete(); // Trigger parent widget rebuild
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.12,
      width: SizeConfig.screenWidth * 0.8,
      margin: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight * 0.01,
          horizontal: SizeConfig.screenWidth * 0.025),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Theme.of(context).colorScheme.secondary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: SizeConfig.screenWidth * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.exerciseType, style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: SizeConfig.screenHeight * 0.005),
                Text('Duration: ${widget.duration} mins', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          SizedBox(width: SizeConfig.screenWidth * 0.05),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${widget.caloriesBurned.toStringAsFixed(2)} kcal', style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: SizeConfig.screenHeight * 0.01),
              IconButton(
                onPressed: _deleteExercise,
                icon: Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
          SizedBox(width: SizeConfig.screenWidth * 0.02),
        ],
      ),
    );
  }
}
