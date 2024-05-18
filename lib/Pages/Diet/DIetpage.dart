// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:medappfv/components/Themes/Sizing.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DietPage extends StatefulWidget {
  const DietPage({super.key});

  @override
  State<DietPage> createState() => _DietPageState();
}

DateTime now = DateTime.now(); // get the current date
String formattedDate =
    DateFormat('dd MMM yyyy').format(now); // convert to dd/MM/yyyy

// Firebase references
final User? user = FirebaseAuth.instance.currentUser;
final String? userId = user?.uid;
final CollectionReference userInfoCollection =
    FirebaseFirestore.instance.collection('UserInfo');

class _DietPageState extends State<DietPage> {
  double carbsConsumed = 0;
  double proteinConsumed = 0;
  double fatConsumed = 0;
  double calorieIntake = 0;
  double waterIntake = 0;
  double carbGoal = 300; // Example goals
  double proteinGoal = 150;
  double fatGoal = 70;
  double calorieGoal = 2000;
  double waterGoal = 3000;
  List<Map<String, dynamic>> meals = [];

  @override
  void initState() {
    super.initState();
    fetchDietData();
  }

  Future<void> fetchDietData() async {
    // Fetch data from Firebase
    final DocumentSnapshot snapshot =
        await userInfoCollection.doc(userId).get();
    if (snapshot.exists) {
      setState(() {
        carbsConsumed = snapshot.get('carbsConsumed')?.toDouble() ?? 0;
        proteinConsumed = snapshot.get('proteinConsumed')?.toDouble() ?? 0;
        fatConsumed = snapshot.get('fatConsumed')?.toDouble() ?? 0;
        calorieIntake = snapshot.get('calorieIntake')?.toDouble() ?? 0;
        waterIntake = snapshot.get('waterIntake')?.toDouble() ?? 0;
        meals = List<Map<String, dynamic>>.from(snapshot.get('meals') ?? []);
      });
    }
  }

  Future<void> addDietMeal(String mealName, double carbs, double protein,
      double fat, double calories) async {
    final meal = {
      'name': mealName,
      'carbs': carbs,
      'protein': protein,
      'fat': fat,
      'calories': calories,
      'isEaten': false,
    };
    await userInfoCollection.doc(userId).update({
      'meals': FieldValue.arrayUnion([meal]),
      'carbsConsumed': FieldValue.increment(carbs),
      'proteinConsumed': FieldValue.increment(protein),
      'fatConsumed': FieldValue.increment(fat),
      'calorieIntake': FieldValue.increment(calories),
    });
    fetchDietData();
  }

  Future<void> updateWaterIntake(double intake) async {
    await userInfoCollection.doc(userId).update({
      'waterIntake': FieldValue.increment(intake),
    });
    fetchDietData();
  }

  Future<void> markMealAsEaten(int index) async {
    final meal = meals[index];
    meal['isEaten'] = true;
    await userInfoCollection.doc(userId).update({
      'meals': meals,
    });
    fetchDietData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          'Your Daily Meals',
          style:
              TextStyle(color: Theme.of(context).textTheme.labelSmall!.color),
          minFontSize: 12,
          maxFontSize: 18,
          maxLines: 1,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: AutoSizeText(
                'Today, $formattedDate',
                style: TextStyle(
                  color: Theme.of(context).textTheme.labelSmall!.color,
                ),
                maxFontSize: 24,
                minFontSize: 16,
                maxLines: 1,
              ),
            ),
            // Nutrient progress section
            _buildNutrientProgressSection(context),
            SizedBox(height: SizeConfig.pointThreeHeight),
            // Calorie intake progress
            _buildProgressSection(
              context,
              title: 'Today\'s Calorie Intake',
              currentValue: calorieIntake,
              goalValue: calorieGoal,
            ),
            SizedBox(height: SizeConfig.pointThreeHeight),
            // Water intake progress
            _buildProgressSection(
              context,
              title: 'Water Intake',
              currentValue: waterIntake,
              goalValue: waterGoal,
            ),
            SizedBox(height: SizeConfig.pointThreeHeight),
            // Meal entry and water tracking buttons
            _buildActionButtons(context),
            SizedBox(height: SizeConfig.pointThreeHeight),
            // Display meals
            _buildMealsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientProgressSection(BuildContext context) {
    return Center(
      child: Container(
        height: SizeConfig.screenHeight * 0.1,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNutrientProgress(context, 'Carbs', carbsConsumed, carbGoal),
            _buildNutrientProgress(
                context, 'Protein', proteinConsumed, proteinGoal),
            _buildNutrientProgress(context, 'Fat', fatConsumed, fatGoal),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientProgress(
      BuildContext context, String nutrientName, double consumed, double goal) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          nutrientName,
          style: TextStyle(
            color: Theme.of(context).textTheme.labelMedium!.color,
          ),
          minFontSize: 12,
          maxFontSize: 18,
          maxLines: 1,
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.01),
        LinearPercentIndicator(
          width: SizeConfig.screenWidth * 0.25,
          lineHeight: SizeConfig.pointFifteenHeight,
          percent: (consumed / goal).clamp(0.0, 1.0),
          barRadius: const Radius.circular(12),
          backgroundColor: Colors.grey,
          progressColor: Colors.blue,
        ),
        AutoSizeText(
          '${consumed.toStringAsFixed(1)}/${goal.toStringAsFixed(1)}g',
          style: TextStyle(
            color: Theme.of(context).textTheme.labelMedium!.color,
          ),
          minFontSize: 12,
          maxFontSize: 18,
          maxLines: 1,
        ),
      ],
    );
  }

  Widget _buildProgressSection(BuildContext context,
      {required String title,
      required double currentValue,
      required double goalValue}) {
    return Center(
      child: Container(
        height: SizeConfig.screenHeight * 0.1,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              title,
              style: TextStyle(
                color: Theme.of(context).textTheme.labelMedium!.color,
              ),
              minFontSize: 12,
              maxFontSize: 18,
              maxLines: 1,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.01),
            LinearPercentIndicator(
              width: SizeConfig.screenWidth * 0.89,
              lineHeight: SizeConfig.pointFifteenHeight,
              percent: (currentValue / goalValue).clamp(0.0, 1.0),
              barRadius: const Radius.circular(12),
              backgroundColor: Colors.grey,
              progressColor: Colors.blue,
            ),
            AutoSizeText(
              '${currentValue.toStringAsFixed(1)}/${goalValue.toStringAsFixed(1)}',
              style: TextStyle(
                color: Theme.of(context).textTheme.labelMedium!.color,
              ),
              minFontSize: 12,
              maxFontSize: 18,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddMealDialog(addDietMeal: addDietMeal);
              },
            );
          },
          child: const Text('Add a Meal'),
        ),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddWaterIntakeDialog(
                    updateWaterIntake: updateWaterIntake);
              },
            );
          },
          child: const Text('Track Water Intake'),
        ),
      ],
    );
  }

  Widget _buildMealsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: meals.length,
      itemBuilder: (context, index) {
        final meal = meals[index];
        return Column(
          children: [
            FoodCard(
              FoodNmae: meal['name'],
              Gm: meal['carbs'] + meal['protein'] + meal['fat'],
              Kcals: meal['calories'],
              pic:
                  'lib/icons/carrot.svg', // Placeholder, replace with actual meal picture if available
              onprsd: () {
                if (!meal['isEaten']) {
                  markMealAsEaten(index);
                }
              },
              isEaten: meal['isEaten'],
            ),
            SizedBox(
                height:
                    SizeConfig.pointFifteenHeight), // Add space between cards
          ],
        );
      },
    );
  }
}

class AddMealDialog extends StatelessWidget {
  final Function(String, double, double, double, double) addDietMeal;
  final TextEditingController mealNameController = TextEditingController();
  final TextEditingController carbsController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController fatController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();

  AddMealDialog({super.key, required this.addDietMeal});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Diet Meal'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: mealNameController,
              decoration: const InputDecoration(labelText: 'Meal Name'),
            ),
            TextField(
              controller: carbsController,
              decoration: const InputDecoration(labelText: 'Carbs (g)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: proteinController,
              decoration: const InputDecoration(labelText: 'Protein (g)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: fatController,
              decoration: const InputDecoration(labelText: 'Fat (g)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: caloriesController,
              decoration: const InputDecoration(labelText: 'Calories (kcal)'),
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
        ElevatedButton(
          onPressed: () {
            final String mealName = mealNameController.text;
            final double carbs = double.tryParse(carbsController.text) ?? 0;
            final double protein = double.tryParse(proteinController.text) ?? 0;
            final double fat = double.tryParse(fatController.text) ?? 0;
            final double calories =
                double.tryParse(caloriesController.text) ?? 0;
            addDietMeal(mealName, carbs, protein, fat, calories);
            Navigator.of(context).pop();
          },
          child: const Text('Add Meal'),
        ),
      ],
    );
  }
}

class AddWaterIntakeDialog extends StatelessWidget {
  final Function(double) updateWaterIntake;
  final TextEditingController waterIntakeController = TextEditingController();

  AddWaterIntakeDialog({super.key, required this.updateWaterIntake});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Water Intake'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: waterIntakeController,
              decoration: const InputDecoration(labelText: 'Water Intake (ml)'),
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
        ElevatedButton(
          onPressed: () {
            final double intake =
                double.tryParse(waterIntakeController.text) ?? 0;
            updateWaterIntake(intake);
            Navigator.of(context).pop();
          },
          child: const Text('Add Intake'),
        ),
      ],
    );
  }
}

class FoodCard extends StatelessWidget {
  final String FoodNmae;
  final double Gm;
  final double Kcals;
  final String pic;
  final VoidCallback onprsd;
  final bool isEaten;

  const FoodCard({
    super.key,
    required this.FoodNmae,
    required this.Gm,
    required this.Kcals,
    required this.pic,
    required this.onprsd,
    required this.isEaten,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.02),
      height: SizeConfig.screenHeight * 0.075,
      width: SizeConfig.screenWidth * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // pic
          SvgPicture.asset(
            pic,
            height: SizeConfig.screenWidth * 0.1,
          ),
          SizedBox(width: SizeConfig.pointThreeWidth),
          // food name
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  AutoSizeText(
                    FoodNmae,
                    maxLines: 1,
                    minFontSize: 12,
                    maxFontSize: 16,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.labelMedium!.color),
                  ),
                ],
              ),
              Row(
                children: [
                  // kcal
                  AutoSizeText(
                    "${Kcals.toString()} Kcal",
                    maxLines: 1,
                    minFontSize: 12,
                    maxFontSize: 16,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.labelMedium!.color),
                  ),
                  SizedBox(width: SizeConfig.pointFifteenWidth),
                  Icon(
                    Icons.fiber_manual_record_rounded,
                    size: SizeConfig.pointFifteenWidth,
                  ),
                  SizedBox(width: SizeConfig.pointFifteenWidth),
                  // gm
                  AutoSizeText(
                    '${Gm.toString()} Gm',
                    maxLines: 1,
                    minFontSize: 12,
                    maxFontSize: 16,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.labelMedium!.color),
                  ),
                ],
              )
            ],
          ),
          // icon button
          IconButton(
            onPressed: onprsd,
            icon: Icon(
              Icons.check_circle,
              color: isEaten ? Colors.green : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
