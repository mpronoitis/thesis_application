// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../screens/statistics.dart';

//Κυκλικό γράφημα για την οπτικοποίηση του sleep score
class SleepScoreProgress extends StatefulWidget {
  const SleepScoreProgress({Key? key}) : super(key: key);

  @override
  State<SleepScoreProgress> createState() => _SleepScoreProgressState();
}

class _SleepScoreProgressState extends State<SleepScoreProgress> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_buildElevationDoughnutChart()],
    );
  }

  SfCircularChart _buildElevationDoughnutChart() {
    //δημιουργία διαγράμματος
    return SfCircularChart(
      title: ChartTitle(
          text: 'Sleep Score', textStyle: TextStyle(fontSize: 22)), //τίτλος

      /// It used to set the annotation on circular chart.
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
            height: '100%',
            width: '100%',
            widget: PhysicalModel(
              shape: BoxShape.circle,
              elevation: 10,
              shadowColor: Colors.black,
              color: const Color.fromRGBO(230, 230, 230, 1),
              child: Container(),
            )),
        CircularChartAnnotation(
            widget: Text(
                '${((sleepStatistics[0].sleep_score * 100).toInt()).toString()}' +
                    '${'%'}',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.5), fontSize: 25)))
      ],

      series:
          _getElevationDoughnutSeries(), //τα series καθορίζουν τι δεδομένα θα έχει το διάγραμμα
    );
  }

  /// Returns the doughnut series which need to be center elevation.
  List<DoughnutSeries<Dummy, String>> _getElevationDoughnutSeries() {
    return <DoughnutSeries<Dummy, String>>[
      DoughnutSeries<Dummy, String>(
          dataSource: <Dummy>[
            Dummy(
                x: 'A',
                y: sleepStatistics[0].sleep_score * 100,
                pointColor: const Color.fromRGBO(0, 220, 252, 1)),
            Dummy(
                x: 'B',
                y: 100 - (sleepStatistics[0].sleep_score * 100),
                pointColor: const Color.fromRGBO(230, 230, 230, 1))
          ],
          animationDuration: 0,
          xValueMapper: (Dummy data, _) => data.x as String,
          yValueMapper: (Dummy data, _) => data.y,
          pointColorMapper: (Dummy data, _) => data.pointColor),
    ];
  }
}

class Dummy {
  //constructor για την αρχικοποίηση των τιμών του διαγράμματος
  final String x;
  final double y;
  final Color? pointColor;

  Dummy({required this.x, required this.y, this.pointColor});
}
