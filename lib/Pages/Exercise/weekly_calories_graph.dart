import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WeeklyCaloriesGraph extends StatelessWidget {
  final List<double> weeklyCalories;

  WeeklyCaloriesGraph({Key? key, required this.weeklyCalories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Validate the data
    List<double> validatedCalories = weeklyCalories.map((value) {
      if (value.isNaN || value.isInfinite || value < 0) {
        return 0.0;
      }
      return value;
    }).toList();

    double maxYValue = validatedCalories.reduce(max);
    if (maxYValue.isNaN || maxYValue.isInfinite || maxYValue == 0) {
      maxYValue = 1.0; // Ensure maxYValue is never zero or invalid
    }

    print('Validated weekly calories for graph: $validatedCalories'); // Debugging statement

    return Container(
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(days[value.toInt()], style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
                interval: (maxYValue / 5).ceilToDouble(), // Ensure interval is never zero
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Text(value.toInt().toString());
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: (maxYValue * 1.2).ceilToDouble(),
          lineBarsData: [
            LineChartBarData(
              spots: validatedCalories
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value))
                  .toList(),
              isCurved: false,
              barWidth: 3,
              belowBarData: BarAreaData(show: true, color: Colors.purple.withOpacity(0.3)),
              dotData: FlDotData(show: true),
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
