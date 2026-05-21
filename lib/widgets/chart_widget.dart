import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final values = [1.2, 0.9, 1.5, 0.4, 1.1, 1.8, 0.83];

    return SizedBox(
      height: 220,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 2.2,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            rightTitles: AxisTitles(),
            topTitles: AxisTitles(),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const days = [
                    'Lun',
                    'Mar',
                    'Mie',
                    'Joi',
                    'Vin',
                    'Sâm',
                    'Dum'
                  ];

                  return Text(days[value.toInt()]);
                },
              ),
            ),
          ),
          barGroups: List.generate(
            values.length,
                (index) => BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: values[index],
                  width: 18,
                  borderRadius: BorderRadius.circular(6),
                  color: index == 6
                      ? const Color(0xFF1D9E75)
                      : const Color(0xFF9FE1CB),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}