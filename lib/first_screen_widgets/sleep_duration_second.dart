// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../sleep_app_theme.dart';

class SecondSleep extends StatefulWidget {
  const SecondSleep({Key? key}) : super(key: key);

  @override
  State<SecondSleep> createState() => _SecondSleepState();
}

class _SecondSleepState extends State<SecondSleep> {
  TooltipBehavior? _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          // gradient: LinearGradient(colors: [
          //   Color(0xff0f17ad).withOpacity(0.8),
          //   Color(0xFF6985e8).withOpacity(0.9)
          // ]),
          color: SleepAppTheme.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topRight: Radius.circular(8.0)),
          boxShadow: <BoxShadow>[
            //colorLor
            BoxShadow(
                color: SleepAppTheme.grey.withOpacity(0.2),
                offset: Offset(1.1, 1.1),
                blurRadius: 10.0),
          ],
        ),
        child: _buildTrackerBarChart(),
      ),
    );
  }

  SfCartesianChart _buildTrackerBarChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
        text: 'Sleep time of current day',
        textStyle: TextStyle(
          fontFamily: SleepAppTheme.fontName,
          fontWeight: FontWeight.w500,
          fontSize: 24,
          letterSpacing: 0.5,
          color: SleepAppTheme.lightText,
        ),
      ),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          majorGridLines: const MajorGridLines(width: 0),
          title: AxisTitle(text: 'Hours'),
          minimum: 0,
          maximum: 8,
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getTrackerBarSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  List<BarSeries<Custom, String>> _getTrackerBarSeries() {
    return <BarSeries<Custom, String>>[
      BarSeries<Custom, String>(
        dataSource: <Custom>[
          Custom(x: 'Tue', y: 7.5),
          // ChartSampleData(x: 'Chris', y: 7),
          // ChartSampleData(x: 'Helana', y: 6),
          // ChartSampleData(x: 'Tom', y: 5),
          // ChartSampleData(x: 'Federer', y: 7),
          // ChartSampleData(x: 'Hussain', y: 7),
        ],
        borderRadius: BorderRadius.circular(15),
        trackColor: const Color.fromRGBO(198, 201, 207, 1),
        color: Colors.purple,

        /// If we enable this property as true,
        /// then we can show the track of series.
        isTrackVisible: true,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, labelAlignment: ChartDataLabelAlignment.top),
        xValueMapper: (Custom sales, _) => sales.x as String,
        yValueMapper: (Custom sales, _) => sales.y,
      ),
    ];
  }
}

class Custom {
  final String x;
  final num y;

  Custom({required this.x, required this.y});
}
