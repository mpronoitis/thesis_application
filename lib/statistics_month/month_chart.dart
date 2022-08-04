// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../screens/statistics_month.dart';
import 'legend_widget.dart';

class MonthChart extends StatefulWidget {
  const MonthChart({Key? key}) : super(key: key);

  static const deepColor = Color(0xff632af2);
  static const lightColor = Color(0xffffb3ba);
  static const remColor = Color(0xff578eff);
  // static const awake = Colors.yellow;
  static const betweenSpace = 0.2;

  @override
  State<MonthChart> createState() => _MonthChartState();
}

class _MonthChartState extends State<MonthChart> {
  int tapIndex = 0;

  BarChartGroupData generateGroupData(
      int x, double deep, double light, double rem) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: deep,
          color: tapIndex == x ? MonthChart.deepColor : const Color(0xFFECECEC),
          width: tapIndex == x ? 15 : 5,
        ),
        BarChartRodData(
          fromY: deep + MonthChart.betweenSpace,
          toY: deep + MonthChart.betweenSpace + light,
          color:
              tapIndex == x ? MonthChart.lightColor : const Color(0xFFECECEC),
          width: tapIndex == x ? 15 : 5,
        ),
        BarChartRodData(
          fromY:
              deep + MonthChart.betweenSpace + light + MonthChart.betweenSpace,
          toY: deep +
              MonthChart.betweenSpace +
              light +
              MonthChart.betweenSpace +
              rem,
          color: tapIndex == x ? MonthChart.remColor : const Color(0xFFECECEC),
          width: tapIndex == x ? 15 : 5,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Duration of Sleep stages',
              style: TextStyle(
                color: Color(0xff171547),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            LegendsListWidget(
              legends: [
                Legend("Deep", Color(0xff632af2)),
                Legend("Light", Color(0xffffb3ba)),
                Legend("REM", Color(0xff578eff)),
              ],
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 8),
            AspectRatio(
              aspectRatio: 1.8,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceBetween,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(),
                    rightTitles: AxisTitles(),
                    topTitles: AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final day =
                              ' ${DateFormat.d().format(DateTime.parse(sleepMonthStatistics[value.toInt()].recording_day))}' +
                                  '${'/'}' +
                                  '${DateFormat.M().format(DateTime.parse(sleepMonthStatistics[value.toInt()].recording_day))}';

                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 1.0,
                              left: 5.0,
                            ),
                            child: tapIndex == value
                                ? Text(
                                    day,
                                  )
                                : Text(''),
                          );
                        },
                        reservedSize: 16,
                      ),
                    ),
                  ),
                  barTouchData: BarTouchData(
                    touchCallback: (event, response) {
                      print(event);
                      if (response != null && event is FlTapUpEvent) {
                        setState(() {
                          if (response.spot != null) {
                            tapIndex = response.spot!.touchedBarGroupIndex;
                          }
                        });
                      }
                    },
                    touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.black,
                        getTooltipItem: (BarChartGroupData data, int x,
                            BarChartRodData datax, int y) {
                          String x1 = 'Deep';
                          String x2 = 'Light';
                          String x3 = 'Rem';
                          // String finalText1 = '';
                          // String finalText2 = '';
                          // String finalText3 = '';

                          // print('${'value is'}' + '${datax.toY}');
                          // print('${'x is'}' + '${x}');
                          // print('${'y is'}' + '${y}');

                          // if (y == 0) {
                          //   double current = (datax.toY) / 60;
                          //   int hours = current.toInt();
                          //   double minutes = datax.toY % 60;
                          //   String finalText1 =
                          //       '${sleepMonthStatistics[x].recording_day} ' +
                          //           '${hours}h' +
                          //           ' ${minutes.toInt()}m';
                          // }

                          // if (y == 1) {
                          //   double current = (datax.toY - 0.2 - 150) / 60;
                          //   int hours = current.toInt();
                          //   double minutes = datax.toY % 60;
                          //   String finalText2 =
                          //       '${sleepMonthStatistics[x].recording_day} ' +
                          //           '${hours}h' +
                          //           ' ${minutes.toInt()}m';
                          // }

                          // if (y == 2) {
                          //   double current = (datax.toY - 0.4 - 150 - 120) / 60;
                          //   int hours = current.toInt();
                          //   double minutes = datax.toY % 60;
                          //   String finalText3 =
                          //       '${sleepMonthStatistics[x].recording_day} ' +
                          //           '${hours}h' +
                          //           ' ${minutes.toInt()}m';
                          // }

                          // print(minutes);

                          if (y == 0) {
                            double current = (datax.toY) / 60;
                            int hours = current.toInt();
                            double minutes = datax.toY % 60;
                            String finalText1 =
                                '${sleepMonthStatistics[x].recording_day} '
                                        '${hours}h' +
                                    ' ${minutes.toInt()}m';
                            return BarTooltipItem(x1 + '${'\n'}' + finalText1,
                                TextStyle(fontSize: 22, color: Colors.white));
                          } else if (y == 1) {
                            print(datax.toY);
                            double current = (datax.toY -
                                    0.2 -
                                    sleepMonthStatistics[x]
                                        .minutes_deep_sleep!) /
                                60;
                            int hours = current.toInt();
                            double minutes = (datax.toY -
                                    0.2 -
                                    sleepMonthStatistics[x]
                                        .minutes_deep_sleep!) %
                                60;
                            String finalText2 =
                                '${sleepMonthStatistics[x].recording_day} ' +
                                    '${hours}h' +
                                    ' ${minutes.toInt()}m';
                            return BarTooltipItem(x2 + '${'\n'}' + finalText2,
                                TextStyle(fontSize: 22, color: Colors.white));
                          } else if (y == 2) {
                            double current = (datax.toY -
                                    0.4 -
                                    sleepMonthStatistics[x]
                                        .minutes_deep_sleep! -
                                    sleepMonthStatistics[x]
                                        .minutes_light_sleep!) /
                                60;
                            int hours = current.toInt();
                            double minutes = (datax.toY -
                                    0.4 -
                                    sleepMonthStatistics[x]
                                        .minutes_deep_sleep! -
                                    sleepMonthStatistics[x]
                                        .minutes_light_sleep!) %
                                60;
                            String finalText3 =
                                '${sleepMonthStatistics[x].recording_day} ' +
                                    '${hours}h' +
                                    ' ${minutes.toInt()}m';
                            return BarTooltipItem(x3 + '${'\n'}' + finalText3,
                                TextStyle(fontSize: 22, color: Colors.white));
                          }
                        },
                        fitInsideHorizontally: true),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  barGroups: [
                    for (int i = 0; i < sleepMonthStatistics.length; i++)
                      generateGroupData(
                          i,
                          sleepMonthStatistics[i].minutes_deep_sleep!,
                          sleepMonthStatistics[i].minutes_light_sleep!,
                          sleepMonthStatistics[i].minutes_rem_sleep!)
                  ],
                  maxY: 480,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
