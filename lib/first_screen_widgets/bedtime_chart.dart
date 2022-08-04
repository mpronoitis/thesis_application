// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../sleep_app_theme.dart';

class BedTimeChart extends StatefulWidget {
  const BedTimeChart({Key? key}) : super(key: key);

  @override
  State<BedTimeChart> createState() => _BedTimeChartState();
}

class _BedTimeChartState extends State<BedTimeChart> {
  List<ChartSampleData>? chartData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      child: Container(
        // ignore: prefer_const_constructors
        margin: EdgeInsets.only(
          left: 12.0,
          right: 12.0,
          top: 0.0,
        ),
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
        child: SfCartesianChart(
          title: ChartTitle(text: 'BedTime'),
          plotAreaBorderWidth: 0,
          primaryXAxis: CategoryAxis(
            axisLine: const AxisLine(width: 0),
            majorGridLines: const MajorGridLines(width: 0),
            majorTickLines: const MajorTickLines(
              size: 0,
              width: 0,
            ),
          ),
          primaryYAxis: NumericAxis(
              axisLine: const AxisLine(width: 0),
              majorGridLines: const MajorGridLines(width: 0),
              majorTickLines: const MajorTickLines(
                size: 0,
                width: 0,
              ),
              // minimum: 21,
              // maximum: 23,
              name: 'primaryYaxis',
              minimum: 20,
              maximum: 24,
              interval: 1
              // axisLabelFormatter: (AxisLabelRenderDetails args) {
              //   late String text;
              //   print(args.value);
              //   text = DateTime.fromMillisecondsSinceEpoch(args.value.toInt())
              //       .hour
              //       .toString();
              //   print(text);
              //   return ChartAxisLabel(text, TextStyle());
              // }

              // axisLabelFormatter: (AxisLabelRenderDetails args) {
              //   late String text;
              //   print(args.value);
              //   text = DateTime.fromMillisecondsSinceEpoch(args.value.toInt())
              //           .hour
              //           .toString() +
              //       ':' +
              //       DateTime.fromMillisecondsSinceEpoch(args.value.toInt())
              //           .minute
              //           .toString() +
              //       ':' +
              //       DateTime.fromMillisecondsSinceEpoch(args.value.toInt())
              //           .second
              //           .toString();
              //   return ChartAxisLabel(text, args.textStyle);
              // },
              // axisLabelFormatter: (AxisLabelRenderDetails args) {
              //   late String text;

              //   text = DateTime.fromMillisecondsSinceEpoch(args.value.toInt())
              //           .hour
              //           .toString() +
              //       ':' +
              //       DateTime.fromMillisecondsSinceEpoch(args.value.toInt())
              //           .minute
              //           .toString() +
              //       ':' +
              //       DateTime.fromMillisecondsSinceEpoch(args.value.toInt())
              //           .second
              //           .toString();
              //   return ChartAxisLabel(text, args.textStyle);
              // },
              ),
          series: _getDefaultScatterSeries(),
        ),
      ),
    );
  }

  @override
  void initState() {
    chartData = <ChartSampleData>[
      ChartSampleData(
        x: DateFormat.E().format(DateTime.now()),
        y: DateTime(2020, 12, 22, 24, 30, 01),
      ),
    ];
    super.initState();
  }

  List<ScatterSeries<ChartSampleData, String>> _getDefaultScatterSeries() {
    return <ScatterSeries<ChartSampleData, String>>[
      ScatterSeries<ChartSampleData, String>(
        dataSource: chartData!,
        opacity: 0.7,
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => 23.30,
      ),
      // ScatterSeries<ChartSampleData, DateTime>(
      //     opacity: 0.7,
      //     dataSource: chartData!,
      //     xValueMapper: (ChartSampleData sales, _) => sales.x as DateTime,
      //     yValueMapper: (ChartSampleData sales, _) => sales.yValue,
      //     markerSettings: const MarkerSettings(height: 15, width: 15),
      //     name: 'Canada'),
      // ScatterSeries<ChartSampleData, DateTime>(
      //   dataSource: chartData!,
      //   color: const Color.fromRGBO(0, 168, 181, 1),
      //   xValueMapper: (ChartSampleData sales, _) => sales.x as DateTime,
      //   yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
      //   name: 'India',
      //   markerSettings: const MarkerSettings(height: 15, width: 15),
    ];
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }
}

class ChartSampleData {
  final String x;
  final DateTime y;

  ChartSampleData({required this.x, required this.y});
}
