// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ptixiaki_sleep_stages/screens/statistics_weekend.dart';
import 'package:ptixiaki_sleep_stages/sleep_app_theme.dart';

import '../helper/db.dart';
import '../screens/statistics_month.dart';
import '../statistics_month/legend_widget.dart';

class InBedChart extends StatefulWidget {
  final bool type;

  const InBedChart({Key? key, required this.type}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InBedChartState();
}

class InBedChartState extends State<InBedChart> {
  //Αρχικοποιήσεις
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);
  int touchedIndex = -1;
  List<Color> gradientColors = [
    Colors.purple,
    Colors.purple,
  ];
  double touchedValue = -1;
  int tapIndex = -1;
  bool isPlaying = false;
//τέλος αρχικοποιήσεων
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: widget.type == true
          ? Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: SleepAppTheme.white,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Asleep',
                              style: TextStyle(
                                  color: Color(0xff0f4a3c),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        LegendsListWidget(
                          //legends που εμφανίζονται πάνω στο διάγραμμα
                          legends: [
                            Legend("Longest", Colors.purple),
                            // Legend("Min", Color(0xffffb3ba)),
                          ],
                        ),
                        const SizedBox(
                          height: 38,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: BarChart(
                              mainBarData(),
                              swapAnimationDuration: animDuration,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: SleepAppTheme.white,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Asleep',
                              style: TextStyle(
                                  color: Color(0xff0f4a3c),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const SizedBox(
                          height: 38,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: LineChart(
                              mainMonthlyData(),
                              // swapAnimationDuration: animDuration,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  LineChartData mainMonthlyData() {
    //δεδομένα διαγράμματος στατιστικών μήνα
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
          // / 60
          tooltipBgColor: Colors.black,
          getTooltipItems: (List<LineBarSpot> spots) {
            return spots
                .map(
                  (spot) => LineTooltipItem(
                    ((spot.y / 60).toInt()).toString() +
                        '${'h'}' +
                        '${' '}' +
                        ((spot.y % 60).toInt()).toString() +
                        '${'m'}' +
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
          y: average(),
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
              interval: 5,
              reservedSize: 32,
              getTitlesWidget: leftTitleWidgetsMonth),
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
      maxY: 480,
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (int i = 0; i < sleepMonthStatistics.length; i++)
              FlSpot(i.toDouble(), sleepMonthStatistics[i].asleep_min!)
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

  BarChartGroupData makeGroupData(
    //δεδομένα διαγράμματος στατικών εβδομάδας
    int x,
    double y,
    bool isMax, {
    bool isTouched = false,
    Color barColor = Colors.purpleAccent,
    Color maxColor = Colors.purple,
    Color minColor = Colors.yellow,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isMax ? maxColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.yellow, width: 1)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 480, //480min 8 ώρες ύπνου
            color: const Color.fromRGBO(198, 201, 207, 1),
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, sleepWeekendStatistics[0].asleep_min!,
                find(sleepWeekendStatistics[0].asleep_min!),
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, sleepWeekendStatistics[1].asleep_min!,
                find(sleepWeekendStatistics[1].asleep_min!),
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, sleepWeekendStatistics[2].asleep_min!,
                find(sleepWeekendStatistics[2].asleep_min!),
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, sleepWeekendStatistics[3].asleep_min!,
                find(sleepWeekendStatistics[3].asleep_min!),
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, sleepWeekendStatistics[4].asleep_min!,
                find(sleepWeekendStatistics[4].asleep_min!),
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, sleepWeekendStatistics[5].asleep_min!,
                find(sleepWeekendStatistics[5].asleep_min!),
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, sleepWeekendStatistics[6].asleep_min!,
                find(sleepWeekendStatistics[6].asleep_min!),
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            String timeInBed = '';
            switch (group.x.toInt()) {
              case 0:
                double current = (rod.toY - 1) / 60;
                int hours = current.toInt();
                num minutes = ((rod.toY - 1) % 60).toInt();
                weekDay = DateFormat.EEEE().format(
                    DateTime.parse(sleepWeekendStatistics[0].recording_day));
                timeInBed = '${hours}h' + ' ${minutes}m';
                break;
              case 1:
                double current = (rod.toY - 1) / 60;
                int hours = current.toInt();
                num minutes = ((rod.toY - 1) % 60).toInt();
                weekDay = DateFormat.EEEE().format(
                    DateTime.parse(sleepWeekendStatistics[1].recording_day));
                timeInBed = '${hours}h' + ' ${minutes}m';
                break;
              case 2:
                double current = (rod.toY - 1) / 60;
                int hours = current.toInt();
                num minutes = ((rod.toY - 1) % 60).toInt();
                weekDay = DateFormat.EEEE().format(
                    DateTime.parse(sleepWeekendStatistics[2].recording_day));
                timeInBed = '${hours}h' + ' ${minutes}m';
                break;
              case 3:
                double current = (rod.toY - 1) / 60;
                int hours = current.toInt();
                num minutes = ((rod.toY - 1) % 60).toInt();
                weekDay = DateFormat.EEEE().format(
                    DateTime.parse(sleepWeekendStatistics[3].recording_day));
                timeInBed = '${hours}h' + ' ${minutes}m';
                break;
              case 4:
                double current = (rod.toY - 1) / 60;
                int hours = current.toInt();
                num minutes = ((rod.toY - 1) % 60).toInt();
                weekDay = DateFormat.EEEE().format(
                    DateTime.parse(sleepWeekendStatistics[4].recording_day));
                timeInBed = '${hours}h' + ' ${minutes}m';
                break;
              case 5:
                double current = (rod.toY - 1) / 60;
                int hours = current.toInt();
                num minutes = ((rod.toY - 1) % 60).toInt();
                weekDay = DateFormat.EEEE().format(
                    DateTime.parse(sleepWeekendStatistics[5].recording_day));
                timeInBed = '${hours}h' + ' ${minutes}m';
                break;
              case 6:
                double current = (rod.toY - 1) / 60;
                int hours = current.toInt();
                num minutes = ((rod.toY - 1) % 60).toInt();
                weekDay = DateFormat.EEEE().format(
                    DateTime.parse(sleepWeekendStatistics[6].recording_day));
                timeInBed = '${hours}h' + ' ${minutes}m';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              weekDay + '\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  //text: 'Quality:' + ((rod.toY - 1).toInt()).toString(),
                  text: 'Total Asleep:' + timeInBed,
                  style: const TextStyle(
                    color: Colors.purple,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
          fitInsideHorizontally: true,
          fitInsideVertically: true,
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
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
            getTitlesWidget: (value, meta) {
              final date = DateTime.parse(
                  sleepWeekendStatistics[value.toInt()].recording_day);
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
                  child: Text(
                    dateText,
                    style: TextStyle(
                      color: Color(0xff67727d),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ));
            },
            reservedSize: 34,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              interval: 1,
              showTitles: true,
              getTitlesWidget: leftTitleWidgets,
              reservedSize: 53),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget leftTitleWidgetsMonth(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    print(value);
    switch (value.toInt()) {
      case 480:
        text = '8h';
        break;
      case 390:
        text = '6.3h';
        break;
      case 240:
        text = '4h';
        break;
      case 90:
        text = '1.3h';
        break;
      default:
        return Container();
    }

    return Row(
      children: [Text(text, style: style)],
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    print(value);
    switch (value.toInt()) {
      case 120:
        text = '2h 0m';
        break;
      case 426:
        text = '7h 6m';
        break;

      case 310:
        text = '5h 10m';
        break;
      default:
        return Container();
    }

    return Row(
      children: [Text(text, style: style)],
    );
  }
}

double average() {
  double totalAverage = 0.0;
  for (int i = 0; i < sleepMonthStatistics.length; i++) {
    totalAverage += sleepMonthStatistics[i].asleep_min!;
  }
  return totalAverage / sleepMonthStatistics.length;
}

bool find(double score) {
  double maxValue = score;
  print(score);
  for (int i = 0; i < sleepWeekendStatistics.length; i++) {
    if (maxValue < sleepWeekendStatistics[i].asleep_min!) {
      maxValue = sleepWeekendStatistics[i].asleep_min!;
    }
  }
  print(score == maxValue);
  print(maxValue);
  return score == maxValue;
}
