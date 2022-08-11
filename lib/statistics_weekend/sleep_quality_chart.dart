// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ptixiaki_sleep_stages/main.dart';
import 'package:ptixiaki_sleep_stages/screens/statistics_weekend.dart';
import 'package:ptixiaki_sleep_stages/sleep_app_theme.dart';
import '../statistics_month/legend_widget.dart';

class SleepQualityChart extends StatefulWidget {
  const SleepQualityChart({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SleepQualityChartState();
}

class SleepQualityChartState extends State<SleepQualityChart> {
//Αρχικοποιήσεις
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);
  int touchedIndex = -1;
  bool isPlaying = false;
  //τέλος αρχικοποιήσεων

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      //κάρτα που θα βάλουμε πάνω σε αυτό το γράφημα
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
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
                        'Sleep Quality',
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
                    legends: [
                      //legends γραφήματος
                      Legend("Appropriate", Colors.deepPurple),
                      Legend("Uncertain", Colors.purple),
                      Legend("Inappropriate", HexColor("#D27AE7")),
                      // Legend("Min", Color(0xffffb3ba)),
                    ],
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        mainBarData(), //δεδομένα γραφήματος
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
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y,
    Color barColor, {
    bool isTouched = false,
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
            toY: 100,
            color: const Color.fromRGBO(198, 201, 207, 1),
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

//δημιουργία λίστας για τα δεδομένα που θα χρησιμοποιήσει το γράφημα
  List<BarChartGroupData> showingGroups() =>
      List.generate(sleepWeekendStatistics.length, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, sleepWeekendStatistics[0].sleep_score * 100,
                find(sleepWeekendStatistics[0].sleep_score),
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, sleepWeekendStatistics[1].sleep_score * 100,
                find(sleepWeekendStatistics[1].sleep_score),
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, sleepWeekendStatistics[2].sleep_score * 100,
                find(sleepWeekendStatistics[2].sleep_score),
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, sleepWeekendStatistics[3].sleep_score * 100,
                find(sleepWeekendStatistics[3].sleep_score),
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, sleepWeekendStatistics[4].sleep_score * 100,
                find(sleepWeekendStatistics[4].sleep_score),
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, sleepWeekendStatistics[5].sleep_score * 100,
                find(sleepWeekendStatistics[5].sleep_score),
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, sleepWeekendStatistics[6].sleep_score * 100,
                find(sleepWeekendStatistics[6].sleep_score),
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    //μορφή δεδομένων
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
                    text: 'Quality:' + ((rod.toY - 1).toInt()).toString(),
                    style: const TextStyle(
                      color: Colors.purple,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
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
              interval: 20,
              showTitles: true,
              getTitlesWidget: leftTitleWidgets,
              reservedSize: 38),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
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
      case 10:
        text = '10%';
        break;
      case 20:
        text = '20%';
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
      case 100:
        text = '100%';
        break;
      default:
        return Container();
    }

    return Row(
      children: [Text(text, style: style)],
    );
  }
}

//ανάλογα την τιμή της ποιότητας ύπνου θέλουμε να βρίσκουμε σε ποια κατηγορία ανήκει και ανάλογα να επιστρέφουμε άλλο χρώμα
Color find(double score) {
  if (score >= 0.85 && score <= 0.99) {
    return Colors.deepPurple;
  } else if (score >= 0.75 && score <= 0.84) {
    return Colors.purple;
  } else if (score < 0.75) {
    return HexColor("#D27AE7");
  }

  return Colors.red;
}
