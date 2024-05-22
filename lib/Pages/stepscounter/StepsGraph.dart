import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StepsChart extends StatelessWidget {
  final List<int> weeklySteps;
  const StepsChart({Key? key, required this.weeklySteps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5, // Half of the screen height
      padding: const EdgeInsets.only(left: 0), // Adjusted for alignment
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 10000, // Set the maximum Y value to 10k steps
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (_, __, bar, ___) {
                return BarTooltipItem(
                  '${bar.toY.toInt()} steps\n', // Display step count
                  TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) => Text(['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][value.toInt()]),
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,  // Enable left side titles
                getTitlesWidget: (value, _) => Text(
                  '${(value / 1000).toStringAsFixed(0)}k', // Format as '1k', '2k', etc.
                  style: TextStyle(
                    fontSize: 12, // Adjust font size to ensure fitting within space
                  ),
                ),
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),  // Disable right side titles
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),  // Disable top titles
            ),
          ),
          gridData: FlGridData(show: false),  // Ensure no grid lines are showing
          borderData: FlBorderData(
            show: false,  // Do not draw the outer border
          ),
          barGroups: weeklySteps.asMap().entries.map((e) {
            return BarChartGroupData(
              x: e.key,
              barRods: [
                BarChartRodData(
                  toY: e.value.toDouble(), // Use actual step count
                  color: Colors.purple[200],
                )
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
