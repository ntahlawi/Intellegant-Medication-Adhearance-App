import 'package:flutter/material.dart';
import 'package:medappfv/Pages/Exercise/weekly_calories_graph.dart';

class WeeklyGraph extends StatelessWidget {
  final List<double> weeklyCalories;

  const WeeklyGraph({Key? key, required this.weeklyCalories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weekly Calorie Chart')),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5, // Set to half the height of the screen
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: WeeklyCaloriesGraph(weeklyCalories: weeklyCalories),
            ),
          ),
        ],
      ),
    );
  }
}
