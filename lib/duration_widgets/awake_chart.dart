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

List<double> myList = [34.0, 34.0, 11.0, 8.0, 28.0, 22.0, 6.0];

class AwakeChart extends StatefulWidget {
  final List<Color> availableColors = const [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];
  final bool type;
  const AwakeChart({Key? key, required this.type}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AwakeChartState();
}

class AwakeChartState extends State<AwakeChart> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;
  List<Color> gradientColors = [
    Colors.purple,
    Colors.purple,
  ];
  double touchedValue = -1;
  int tapIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: widget.type
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
                              'Awake time',
                              style: TextStyle(
                                  color: Color(0xff0f4a3c),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            // Container(
                            //   width: 140,
                            //   decoration: BoxDecoration(
                            //     color: Colors.grey[200],
                            //     borderRadius: BorderRadius.circular(16),
                            //   ),
                            //   child: Row(
                            //     children: [
                            //       Expanded(
                            //         child: Padding(
                            //           padding: const EdgeInsets.all(3.0),
                            //           child: GestureDetector(
                            //             onTap: () async {
                            //               DateTime newStartDate = DateTime(
                            //                   startDate.year,
                            //                   startDate.month,
                            //                   startDate.day - 7);

                            //               DateTime newEndDate = DateTime(
                            //                   startDate.year,
                            //                   startDate.month,
                            //                   startDate.day - 1);

                            //               final data = await DB()
                            //                   .getAllRecordsByWeekendTemp(
                            //                       DateFormat('yyyy-MM-dd')
                            //                           .format(newStartDate),
                            //                       DateFormat('yyyy-MM-dd')
                            //                           .format(newEndDate));

                            //               // widget.onApplyClick1!(
                            //               //     newStartDate, newEndDate, data);
                            //             },
                            //             child: Container(
                            //               decoration: BoxDecoration(
                            //                 color: Colors.white,
                            //                 borderRadius:
                            //                     BorderRadius.circular(16),
                            //               ),
                            //               padding: const EdgeInsets.symmetric(
                            //                   vertical: 4),
                            //               child: const Center(
                            //                 child: Icon(
                            //                   Icons.arrow_left,
                            //                   size: 30,
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //       Expanded(
                            //         child: GestureDetector(
                            //           onTap: () async {
                            //             DateTime newStartDate = DateTime(
                            //                 endDate.year,
                            //                 endDate.month,
                            //                 endDate.day + 1);
                            //             DateTime newEndDate = DateTime(
                            //                 endDate.year,
                            //                 endDate.month,
                            //                 endDate.day + 7);

                            //             final data = await DB()
                            //                 .getAllRecordsByWeekendTemp(
                            //                     DateFormat('yyyy-MM-dd')
                            //                         .format(newStartDate),
                            //                     DateFormat('yyyy-MM-dd')
                            //                         .format(newEndDate));

                            //             // widget.onApplyClick2!(
                            //             //     newStartDate, newEndDate, data);
                            //           },
                            //           child: Container(
                            //             decoration: BoxDecoration(
                            //               color: Colors.white,
                            //               borderRadius:
                            //                   BorderRadius.circular(16),
                            //             ),
                            //             padding: const EdgeInsets.symmetric(
                            //                 vertical: 4),
                            //             child: const Center(
                            //               child: Icon(
                            //                 Icons.arrow_right,
                            //                 size: 30,
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        // LegendsListWidget(
                        //   legends: [
                        //     Legend("Longest", Colors.deepPurple),
                        //     Legend(
                        //       "Shortest",
                        //       Colors.red,
                        //     ),
                        //     // Legend("Min", Color(0xffffb3ba)),
                        //   ],
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
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
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Align(
                  //     alignment: Alignment.topRight,
                  //     child: IconButton(
                  //       icon: Icon(
                  //         isPlaying ? Icons.pause : Icons.play_arrow,
                  //         color: const Color(0xff0f4a3c),
                  //       ),
                  //       onPressed: () {
                  //         setState(() {
                  //           isPlaying = !isPlaying;
                  //           if (isPlaying) {
                  //             refreshState();
                  //           }
                  //         });
                  //       },
                  //     ),
                  //   ),
                  // )
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
                              'Total Awake time',
                              style: TextStyle(
                                  color: Color(0xff0f4a3c),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            // Container(
                            //   width: 140,
                            //   decoration: BoxDecoration(
                            //     color: Colors.grey[200],
                            //     borderRadius: BorderRadius.circular(16),
                            //   ),
                            //   child: Row(
                            //     children: [
                            //       Expanded(
                            //         child: Padding(
                            //           padding: const EdgeInsets.all(3.0),
                            //           child: GestureDetector(
                            //             onTap: () async {
                            //               DateTime newStartDate = DateTime(
                            //                   startDate.year,
                            //                   startDate.month,
                            //                   startDate.day - 7);

                            //               DateTime newEndDate = DateTime(
                            //                   startDate.year,
                            //                   startDate.month,
                            //                   startDate.day - 1);

                            //               final data = await DB()
                            //                   .getAllRecordsByWeekendTemp(
                            //                       DateFormat('yyyy-MM-dd')
                            //                           .format(newStartDate),
                            //                       DateFormat('yyyy-MM-dd')
                            //                           .format(newEndDate));

                            //               // widget.onApplyClick1!(
                            //               //     newStartDate, newEndDate, data);
                            //             },
                            //             child: Container(
                            //               decoration: BoxDecoration(
                            //                 color: Colors.white,
                            //                 borderRadius:
                            //                     BorderRadius.circular(16),
                            //               ),
                            //               padding: const EdgeInsets.symmetric(
                            //                   vertical: 4),
                            //               child: const Center(
                            //                 child: Icon(
                            //                   Icons.arrow_left,
                            //                   size: 30,
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //       Expanded(
                            //         child: GestureDetector(
                            //           onTap: () async {
                            //             DateTime newStartDate = DateTime(
                            //                 endDate.year,
                            //                 endDate.month,
                            //                 endDate.day + 1);
                            //             DateTime newEndDate = DateTime(
                            //                 endDate.year,
                            //                 endDate.month,
                            //                 endDate.day + 7);

                            //             final data = await DB()
                            //                 .getAllRecordsByWeekendTemp(
                            //                     DateFormat('yyyy-MM-dd')
                            //                         .format(newStartDate),
                            //                     DateFormat('yyyy-MM-dd')
                            //                         .format(newEndDate));

                            //             // widget.onApplyClick2!(
                            //             //     newStartDate, newEndDate, data);
                            //           },
                            //           child: Container(
                            //             decoration: BoxDecoration(
                            //               color: Colors.white,
                            //               borderRadius:
                            //                   BorderRadius.circular(16),
                            //             ),
                            //             padding: const EdgeInsets.symmetric(
                            //                 vertical: 4),
                            //             child: const Center(
                            //               child: Icon(
                            //                 Icons.arrow_right,
                            //                 size: 30,
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        // LegendsListWidget(
                        //   legends: [
                        //     Legend("Longest", Colors.deepPurple),
                        //     Legend(
                        //       "Shortest",
                        //       Colors.red,
                        //     ),
                        //     // Legend("Min", Color(0xffffb3ba)),
                        //   ],
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            child: LineChart(
                              mainMonthlyData(),
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
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Align(
                  //     alignment: Alignment.topRight,
                  //     child: IconButton(
                  //       icon: Icon(
                  //         isPlaying ? Icons.pause : Icons.play_arrow,
                  //         color: const Color(0xff0f4a3c),
                  //       ),
                  //       onPressed: () {
                  //         setState(() {
                  //           isPlaying = !isPlaying;
                  //           if (isPlaying) {
                  //             refreshState();
                  //           }
                  //         });
                  //       },
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
    );
  }

  LineChartData mainMonthlyData() {
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
              interval: 1,
              reservedSize: 50,
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
      maxY: 60,
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (int i = 0; i < sleepMonthStatistics.length; i++)
              FlSpot(i.toDouble(), sleepMonthStatistics[i].awake!)
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
    int x,
    double y, {
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
          color: barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.yellow, width: 1)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 36, //480min 8 ώρες ύπνου
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
            return makeGroupData(0, sleepWeekendStatistics[0].awake!,
                isTouched: i == touchedIndex,
                barColor: find(sleepWeekendStatistics[0].awake!));
          case 1:
            return makeGroupData(1, sleepWeekendStatistics[1].awake!,
                isTouched: i == touchedIndex,
                barColor: find(sleepWeekendStatistics[1].awake!));
          case 2:
            return makeGroupData(2, sleepWeekendStatistics[2].awake!,
                isTouched: i == touchedIndex,
                barColor: find(sleepWeekendStatistics[2].awake!));
          case 3:
            return makeGroupData(3, sleepWeekendStatistics[3].awake!,
                isTouched: i == touchedIndex,
                barColor: find(sleepWeekendStatistics[3].awake!));
          case 4:
            return makeGroupData(4, sleepWeekendStatistics[4].awake!,
                isTouched: i == touchedIndex,
                barColor: find(sleepWeekendStatistics[4].awake!));
          case 5:
            return makeGroupData(5, sleepWeekendStatistics[5].awake!,
                isTouched: i == touchedIndex,
                barColor: find(sleepWeekendStatistics[5].awake!));
          case 6:
            return makeGroupData(6, sleepWeekendStatistics[6].awake!,
                isTouched: i == touchedIndex,
                barColor: find(sleepWeekendStatistics[6].awake!));

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
              switch (group.x.toInt()) {
                case 0:
                  weekDay = DateFormat.EEEE().format(
                      DateTime.parse(sleepWeekendStatistics[0].recording_day));
                  break;
                case 1:
                  weekDay = DateFormat.EEEE().format(
                      DateTime.parse(sleepWeekendStatistics[1].recording_day));
                  break;
                case 2:
                  weekDay = DateFormat.EEEE().format(
                      DateTime.parse(sleepWeekendStatistics[2].recording_day));
                  break;
                case 3:
                  weekDay = DateFormat.EEEE().format(
                      DateTime.parse(sleepWeekendStatistics[3].recording_day));
                  break;
                case 4:
                  weekDay = DateFormat.EEEE().format(
                      DateTime.parse(sleepWeekendStatistics[4].recording_day));
                  break;
                case 5:
                  weekDay = DateFormat.EEEE().format(
                      DateTime.parse(sleepWeekendStatistics[5].recording_day));
                  break;
                case 6:
                  weekDay = DateFormat.EEEE().format(
                      DateTime.parse(sleepWeekendStatistics[6].recording_day));
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
                    text: 'Awake time:' +
                        ((rod.toY - 1).toInt()).toString() +
                        'min',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            },
            fitInsideHorizontally: true,
            fitInsideVertically: true),
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
                    left: 0.0,
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
      case 9:
        text = '9min';
        break;
      case 60:
        text = '60min';
        break;
      case 26:
        text = '26min';
        break;

      case 36:
        text = '36min';
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
      case 9:
        text = '9min';
        break;
      case 18:
        text = '18min';
        break;
      // case 26:
      //   text = '26min';
      //   break;

      // case 36:
      //   text = '36min';
      //   break;

      case 50:
        text = '50min';
        break;

      case 60:
        text = '60min';
        break;

      default:
        return Container();
    }

    return Row(
      children: [Text(text, style: style)],
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      await refreshState();
    }
  }
}

Color find(double score) {
  double maxValue = sleepWeekendStatistics[0].awake!;
  double minValue = sleepWeekendStatistics[0].awake!;
  print(score);
  for (int i = 0; i < sleepWeekendStatistics.length; i++) {
    if (sleepWeekendStatistics[i].awake! > maxValue) {
      maxValue = sleepWeekendStatistics[i].awake!;
    }
    if (sleepWeekendStatistics[i].awake! < minValue) {
      minValue = sleepWeekendStatistics[i].awake!;
    }
  }
  return Colors.purpleAccent;
  // if (score == maxValue) {
  //   return Colors.deepPurple;
  // } else if (score == minValue) {
  //   return Colors.red;
  // } else {
  //   return Colors.purpleAccent;
  // }
}

double average() {
  double totalAverage = 0.0;
  for (int i = 0; i < sleepMonthStatistics.length; i++) {
    totalAverage += sleepMonthStatistics[i].awake!;
  }

  return totalAverage / sleepMonthStatistics.length;
}
