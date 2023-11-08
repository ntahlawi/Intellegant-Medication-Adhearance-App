// ignore_for_file: camel_case_types, file_names

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class mypiechart extends StatelessWidget {
  const mypiechart({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Excersise Time',
              style: TextStyle(
                color: Theme.of(context).textTheme.labelSmall!.color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            Text(
              'Per Day',
              style: TextStyle(
                color: Theme.of(context).textTheme.labelSmall!.color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
        PieChart(
          swapAnimationDuration: const Duration(milliseconds: 750),
          swapAnimationCurve: Curves.easeInOutQuint,
          PieChartData(
            sections: [
              PieChartSectionData(
                value: 20,
                color: Colors.red,
                titleStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
              PieChartSectionData(
                value: 130,
                color: Colors.pink,
                titleStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
              PieChartSectionData(
                value: 20,
                color: Colors.blue,
                titleStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
              PieChartSectionData(
                value: 20,
                color: Colors.black,
                titleStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
