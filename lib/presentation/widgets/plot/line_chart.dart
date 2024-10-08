import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker/data/models/weight.dart';
import 'package:weight_tracker/providers/chart/chart_provider.dart';
import 'package:weight_tracker/providers/chart/chart_state.dart';
import 'package:weight_tracker/providers/weights/weights_provider.dart';
import 'package:weight_tracker/providers/weights/weights_state.dart';
import 'package:weight_tracker/utils/chart_utils.dart';

final List<String> months = LineCharUtils().months;

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({super.key});

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final state = ref.watch(weightsProvider);
      final monthsState = ref.watch(chartProvider);

      int numMonths = 6;
      if (monthsState is FinalMonthsState) numMonths = monthsState.months;
      List<Weight> weighList = state is WeightsLoadedState ? state.weights : [];
      int interval = LineCharUtils().calculateInterval(weighList, numMonths);

      final List<FlSpot> dummyData1 =
          List.generate(min(weighList.length, interval), (index) {
        final DateTime time = weighList[index].time;
        final int year = time.year;
        final int month =
            year == DateTime.now().year ? time.month + 12 : time.month;
        return FlSpot(
          month.toDouble(),
          weighList[index].weight,
        );
      });

      return weighList.isEmpty
          ? const Center(
              child: Text("Add weights to analyze"),
            )
          : Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(
                    show: true,
                  ),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(
                      axisNameWidget: const Text(
                        "Weight (Kg)",
                        style: TextStyle(fontSize: 12),
                      ),
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 35,
                        getTitlesWidget: (value, meta) => Text(
                          value.toString(),
                          style: const TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      axisNameWidget: const Text("Time (Months)"),
                      sideTitles: SideTitles(
                        interval: 1,
                        reservedSize: 28,
                        showTitles: true,
                        getTitlesWidget: (value, meta) => Text(
                          months[(value.abs().toInt() - 1) % 12],
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: dummyData1,
                      barWidth: 3,
                      color: Colors.indigo,
                    ),
                  ],
                ),
              ),
            );
    });
  }
}
