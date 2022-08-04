// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../screens/statistics_month.dart';
import '../sleep_app_theme.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({Key? key}) : super(key: key);

  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    Colors.purple,
    Colors.purple,
  ];
  double touchedValue = -1;
  double akiros = 2;
  int tapIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: SleepAppTheme.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Sleep Quality',
              style: TextStyle(
                color: Color(0xff171547),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 8),
            AspectRatio(aspectRatio: 1.8, child: LineChart(mainData())),
          ],
        ),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 10:
        text = '20%';
        break;
      case 20:
        text = '30%';
        break;
      case 30:
        text = '30%';
        break;
      case 40:
        text = '40%';
        break;
      case 50:
        text = '50%';
        break;
      case 60:
        text = '60%';
        break;
      case 70:
        text = '70%';
        break;
      case 80:
        text = '80%';
        break;
      case 90:
        text = '90%';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      lineTouchData: LineTouchData(
        touchCallback: (FlTouchEvent event, LineTouchResponse? lineTouch) {
          if (!event.isInterestedForInteractions ||
              lineTouch == null ||
              lineTouch.lineBarSpots == null) {
            setState(() {
              touchedValue = -1;
            });
            return;
          }
          final value = lineTouch.lineBarSpots![0].x;
          print(value);
          // if (value == 0 || value == 6) {
          //   setState(() {
          //     touchedValue = -1;
          //   });
          //   return;
          // }

          setState(() {
            touchedValue = value;
          });
        },
        // touchCallback: (event, response) {
        //   if (response != null && event is FlTapUpEvent) {
        //     print('tapped');
        //   }
        // },
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.black,
          getTooltipItems: (List<LineBarSpot> spots) {
            return spots
                .map(
                  (spot) => LineTooltipItem(
                    '${spot.y.toInt()}' +
                        '${'% sleep score in'}' +
                        '${' '}' +
                        '${sleepMonthStatistics[spot.x.toInt()].recording_day}',
                    TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                )
                .toList();
          },
          fitInsideHorizontally: true,
          fitInsideVertically: true,
        ),
      ),
      extraLinesData: ExtraLinesData(horizontalLines: [
        HorizontalLine(
          y: 80,
          color: SleepAppTheme.grey.withOpacity(0.4),
          strokeWidth: 3,
          dashArray: [20, 2],
        ),
      ]),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {
              final date = DateTime.parse(
                  sleepMonthStatistics[value.toInt()].recording_day);
              final dateText = DateFormat.d().format(date) +
                  '/' +
                  DateFormat.M().format(date) +
                  '\n' +
                  DateFormat.E().format(date);

              return Padding(
                  padding: const EdgeInsets.only(
                    top: 1.0,
                    left: 5.0,
                  ),
                  child: touchedValue == value
                      ? Text(
                          dateText,
                          style: TextStyle(
                            color: Color(0xff67727d),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        )
                      : Text(''));
            },
            reservedSize: 34,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              interval: 20,
              reservedSize: 50,
              getTitlesWidget: leftTitleWidgets),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Colors.black.withOpacity(0.5), width: 3),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      ),
      minX: 0,
      maxX: sleepMonthStatistics.length.toDouble() - 1.0,
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (int i = 0; i < sleepMonthStatistics.length; i++)
              FlSpot(i.toDouble(), sleepMonthStatistics[i].sleep_score * 100)
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.2))
                  .toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );
  }
}

double getAverage() {
  double average = 0.0;
  for (int i = 0; i < sleepMonthStatistics.length; i++) {
    average += sleepMonthStatistics[i].sleep_score;
  }
  print(average);
  return average;
}
