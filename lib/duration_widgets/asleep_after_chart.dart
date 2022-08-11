// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ptixiaki_sleep_stages/screens/statistics_weekend.dart';
import 'package:ptixiaki_sleep_stages/sleep_app_theme.dart';
import '../screens/statistics_month.dart';

class AsleepAfterChart extends StatefulWidget {
  final bool type;
  final List<Color> availableColors = const [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  const AsleepAfterChart({Key? key, required this.type}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AsleepAfterChartState();
}

//Διάγραμμα κατηγορίας AsleepAfter // για να το δημιουργούμε μόνο μία φορα στον constructor πέρναμε ως argument τον τύπο οθόνης
class AsleepAfterChartState extends State<AsleepAfterChart> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);
  List<Color> gradientColors = [
    Colors.purple,
    Colors.deepPurple,
  ];
//Αρχικοποιήσεις
  int touchedIndex = -1;
  double touchedValue = -1;
  int tapIndex = -1;
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: widget
              .type //δεχεται ως ορισμα των τύπο δεδομένων και με βάση αυτό δημιουργεί το κατάλληλο διαγραμμα της οθόνης(εδω πρόκειται για το διάγραμμα των στατιστικών εβδομάδας)
          ? Card(
              shape: RoundedRectangleBorder(
                  //στρογγυλοποιημένες γωνίες
                  borderRadius: BorderRadius.circular(18)),
              color: SleepAppTheme.white,
              child: Stack(
                //χρήση widget stack για να μπορούμε να προσθέσουμε πάνω στο διάγραμμα περιεχόμενο
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
                              'Asleep after time',
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
                            child: BarChart(
                              //διάγραμμα στήλης για το γράφημα των στατιστικών εβδομάδας
                              mainBarData(), //κλήση συνάρτηση για την δημιουργία των δεδομένων για το γράφημα
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
              //σε αυτήν την περίπτωση πρόκειται για το διάγραμμα των στατιστικών μήνα
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
                              'Asleep after time',
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
                              //δημιουργία διαγράμματος γραμμής
                              mainMonthlyData(), //συνάρτηση για την δημιουργία των δεδομένων του διαγράμματος
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

  LineChartData mainMonthlyData() {
    //συνάρτηση για το διάγραμμα γραμμής
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
        //listener που παρακολουθεί το click του χρήστη πάνω στο διάγραμμα
        touchCallback: (FlTouchEvent event, LineTouchResponse? lineTouch) {
          if (!event.isInterestedForInteractions ||
              lineTouch == null ||
              lineTouch.lineBarSpots == null) {
            setState(() {
              touchedValue =
                  -1; //boolean για να ξέρουμε πότε πατάει ο χρήστης πατάει πάνω στο γράφημα
            });
            return;
          }
          final value = lineTouch.lineBarSpots![0].x;
          setState(() {
            touchedValue = value;
          });
        },

        touchTooltipData: LineTouchTooltipData(
          //καθορίζει πως εμφανίζεται το tooltip όταν ο χρήστης πατάει πάνω στο spot
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
        //δημιουργούμαι μία γραμμή στο average του χρόνου
        HorizontalLine(
          y: average(),
          color: SleepAppTheme.grey.withOpacity(0.4),
          strokeWidth: 3,
          dashArray: [20, 2],
        ),
      ]),
      titlesData: FlTitlesData(
        //επιλέγουμε ποιοι άξονες θέλουμε να φαίνονται στο διάγραμμα
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
              //πληροφορία που θα περιέχουν οι άξονες
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
      maxY: 30,
      lineBarsData: [
        LineChartBarData(
          //συνάρτηση που δημιουργεί τα σημεία(τροφοδοτείται απο την λίστα που βρίσκεται στην main)
          spots: [
            for (int i = 0; i < sleepMonthStatistics.length; i++)
              FlSpot(i.toDouble(), sleepMonthStatistics[i].asleep_after!)
          ],
          isCurved: true,
          gradient: LinearGradient(
            //gradient γέμισμα στην γραμμή
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

//δημιουργία των στηλών με βάση τα δεδομένα της λίστας
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
          color: y == 30 ? Colors.deepPurple : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.yellow, width: 1)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 30, //480min 8 ώρες ύπνου
            color: const Color.fromRGBO(198, 201, 207, 1),
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        //δημιουργία δεδομένων στατιστικών εβδομάδας
        switch (i) {
          case 0:
            return makeGroupData(0, sleepWeekendStatistics[0].asleep_after!,
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, sleepWeekendStatistics[1].asleep_after!,
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, sleepWeekendStatistics[2].asleep_after!,
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, sleepWeekendStatistics[3].asleep_after!,
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, sleepWeekendStatistics[4].asleep_after!,
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, sleepWeekendStatistics[5].asleep_after!,
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, sleepWeekendStatistics[6].asleep_after!,
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    //συνάρτηση για το format των δεδομένων
    return BarChartData(
      barTouchData: BarTouchData(
        //καθορίζουμε τι εμφανίζεται όταν ο χρήστης πατάει πάνω στην μπάρα
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
                //tooltip
                weekDay + '\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Asleep after:' +
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

//μορφη αξόνων y διαγράμματος στατιστικών μήνα
  Widget leftTitleWidgetsMonth(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    print(value);
    switch (value.toInt()) {
      case 5:
        text = '5min';
        break;
      case 10:
        text = '10min';
        break;
      case 20:
        text = '20min';
        break;

      case 30:
        text = '30min';
        break;

      default:
        return Container();
    }

    return Row(
      children: [Text(text, style: style)],
    );
  }

//μορφη αξόνων y διαγράμματος στατιστικών εβδομάδας
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    print(value);
    switch (value.toInt()) {
      case 5:
        text = '5min';
        break;
      case 10:
        text = '10min';
        break;
      case 20:
        text = '20min';
        break;

      case 30:
        text = '30min';
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
  //υπολογισμός μέσου όρου aslee after time
  double totalAverage = 0.0;
  for (int i = 0; i < sleepMonthStatistics.length; i++) {
    totalAverage += sleepMonthStatistics[i].asleep_after!;
  }
  print(totalAverage / sleepMonthStatistics.length);
  return totalAverage / sleepMonthStatistics.length;
}
