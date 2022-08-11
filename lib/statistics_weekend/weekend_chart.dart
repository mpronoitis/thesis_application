// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ptixiaki_sleep_stages/helper/db.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/sleep.dart';
import '../screens/statistics_weekend.dart';
import '../sleep_app_theme.dart';
import 'legend_info.dart';

//Διάγραμμα sleep stages οθόνης στατιστικών εβδομάδας
class WeekendChart extends StatefulWidget {
  const WeekendChart({Key? key, this.onApplyClick1, this.onApplyClick2})
      : super(key: key);
  final Function(DateTime, DateTime, List<Sleep>)?
      onApplyClick1; //δέχεται ως όρισμα δυο callback functions
  final Function(DateTime, DateTime, List<Sleep>)? onApplyClick2;

  @override
  State<WeekendChart> createState() => _WeekendChartState();
}

class _WeekendChartState extends State<WeekendChart> {
  //Αρχικοποιήσεις
  List<_ChartData> chartData = [];
  TooltipBehavior? _tooltipBehavior;
  TrackballBehavior? _trackballBehavior;
  //Τέλος αρχικοποιήσεων
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
        //αρχικοποιήση tooltip
        enable: true,
        textStyle: TextStyle(
          fontSize: 18,
        ));
    super.initState();
    chartData = <_ChartData>[]; //δεδομένα διαγράμματος
    for (int i = 0; i < sleepWeekendStatistics.length; i++) {
      chartData.add(_ChartData(
        DateFormat.E()
            .format(DateTime.parse(sleepWeekendStatistics[i].recording_day)),
        250,
        150,
        70,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //μορφή κάρτας πάνω στην οποία μπαίνει το γράφημα
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 28.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Sleep Statistics By Day",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Container(
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: GestureDetector(
                            onTap: () async {
                              //listener όταν ο χρήστης πατάει το αριστερό βελάκι στο γράφημα
                              DateTime newStartDate = DateTime(startDate.year,
                                  startDate.month, startDate.day - 7);

                              DateTime newEndDate = DateTime(startDate.year,
                                  startDate.month, startDate.day - 1);

                              final data = await DB()
                                  .getAllRecordsByWeekendTemp(
                                      DateFormat('yyyy-MM-dd')
                                          .format(newStartDate),
                                      DateFormat('yyyy-MM-dd')
                                          .format(newEndDate));

                              widget.onApplyClick1!(
                                  //callback function που αλλάζει τα δεδομένα
                                  newStartDate,
                                  newEndDate,
                                  data);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_left,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            //listener όταν ο χρήστης πατάει το δεξί βελάκι στο γράφημα
                            DateTime newStartDate = DateTime(
                                endDate.year, endDate.month, endDate.day + 1);
                            DateTime newEndDate = DateTime(
                                endDate.year, endDate.month, endDate.day + 7);

                            final data = await DB().getAllRecordsByWeekendTemp(
                                DateFormat('yyyy-MM-dd').format(newStartDate),
                                DateFormat('yyyy-MM-dd').format(newEndDate));

                            widget.onApplyClick2!(
                                //callback function που ανανεώσει την main Με τα νέα δεδομένα
                                newStartDate,
                                newEndDate,
                                data);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_right,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 15.0,
              ),
              LegendInfo(), //widget για τα legends sleep stages
            ],
          ),
          _buildStackedBar100Chart() //δημιουργία διαγράμματος
        ],
      ),
    );
  }

  SfCartesianChart _buildStackedBar100Chart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      onTooltipRender: (TooltipArgs args) {
        //καθορίζει την μορφή του tooltip όταν πατάμε πάνω στην στήλη
        List<dynamic>? chartdata = args.dataPoints;

        switch (args.pointIndex) {
          case 0:
            switch (args.seriesIndex) {
              case 0:
                print(chartData[0].deep);
                double current =
                    sleepWeekendStatistics[0].minutes_deep_sleep! / 60;
                print(current);
                int hours = current.toInt();
                num minutes =
                    sleepWeekendStatistics[0].minutes_deep_sleep! % 60;
                args.text = '${hours}h' + ' ${minutes.toInt()}m';
                print(args.text);
                break;
              case 1:
                double current =
                    sleepWeekendStatistics[0].minutes_light_sleep! / 60;
                int hours = current.toInt();
                num minutes =
                    sleepWeekendStatistics[0].minutes_light_sleep! % 60;
                args.text = '${hours}h' + ' ${minutes.toInt()}m';
                break;
              case 2:
                double current =
                    sleepWeekendStatistics[0].minutes_rem_sleep! / 60;
                int hours = current.toInt();
                num minutes = sleepWeekendStatistics[0].minutes_rem_sleep! % 60;
                args.text = '${hours}h' + ' ${minutes.toInt()}m';
                break;

              default:
            }
            break;
          case 1:
            switch (args.seriesIndex) {
              case 0:
                double current =
                    sleepWeekendStatistics[1].minutes_deep_sleep! / 60;
                int hours = current.toInt();
                num minutes =
                    sleepWeekendStatistics[1].minutes_deep_sleep! % 60;
                args.text = '${hours}h' + ' ${minutes.toInt()}m';
                break;
              case 1:
                double current =
                    sleepWeekendStatistics[1].minutes_light_sleep! / 60;
                int hours = current.toInt();
                num minutes =
                    sleepWeekendStatistics[1].minutes_light_sleep! % 60;
                args.text = '${hours}h' + ' ${minutes.toInt()}m';
                break;
              case 2:
                double current =
                    sleepWeekendStatistics[1].minutes_rem_sleep! / 60;
                int hours = current.toInt();
                num minutes = sleepWeekendStatistics[1].minutes_rem_sleep! % 60;
                args.text = '${hours}h' + ' ${minutes.toInt()}m';
                break;

              default:
            }
            break;
          case 2:
            switch (args.seriesIndex) {
              case 0:
                double current =
                    sleepWeekendStatistics[2].minutes_deep_sleep! / 60;
                int hours = current.toInt();
                num minutes =
                    sleepWeekendStatistics[2].minutes_deep_sleep! % 60;
                args.text = '${hours}h' + ' ${minutes.toInt()}m';
                break;
              case 1:
                double current =
                    sleepWeekendStatistics[2].minutes_light_sleep! / 60;
                int hours = current.toInt();
                num minutes =
                    sleepWeekendStatistics[2].minutes_light_sleep! % 60;
                args.text = '${hours}h' + ' ${minutes.toInt()}m';
                break;
              case 2:
                double current =
                    sleepWeekendStatistics[2].minutes_rem_sleep! / 60;
                int hours = current.toInt();
                num minutes = sleepWeekendStatistics[2].minutes_rem_sleep! % 60;
                args.text = '${hours}h' + ' ${minutes.toInt()}m';
                break;

              default:
            }
            break;
          case 3:
            switch (args.seriesIndex) {
              case 0:
                double current =
                    sleepWeekendStatistics[3].minutes_deep_sleep! / 60;
                int hours = current.toInt();
                num minutes =
                    sleepWeekendStatistics[3].minutes_deep_sleep! % 60;
                args.text = '${hours}h' + ' ${minutes.toInt()}m';
                break;
              case 1:
                double current =
                    sleepWeekendStatistics[3].minutes_light_sleep! / 60;
                int hours = current.toInt();
                num minutes =
                    sleepWeekendStatistics[3].minutes_light_sleep! % 60;
                args.text = '${hours}h' + ' ${minutes.toInt()}m';
                break;
              case 2:
                double current =
                    sleepWeekendStatistics[3].minutes_rem_sleep! / 60;
                int hours = current.toInt();
                num minutes = sleepWeekendStatistics[3].minutes_rem_sleep! % 60;
                args.text = '${hours}h' + ' ${minutes.toInt()}m';
                break;

              default:
            }
            break;
          case 4:
            switch (args.seriesIndex) {
              case 0:
                double current =
                    sleepWeekendStatistics[4].minutes_deep_sleep! / 60;
                int hours = current.toInt();
                num minutes =
                    sleepWeekendStatistics[4].minutes_deep_sleep! % 60;
                args.text = '${hours}h' + ' ${minutes.toInt()}m';
                break;
              case 1:
                double current =
                    sleepWeekendStatistics[4].minutes_light_sleep! / 60;
                int hours = current.toInt();
                num minutes =
                    sleepWeekendStatistics[4].minutes_light_sleep! % 60;
                args.text = '${hours}h' + ' ${minutes.toInt()}m';
                break;
              case 2:
                double current =
                    sleepWeekendStatistics[4].minutes_rem_sleep! / 60;
                int hours = current.toInt();
                num minutes = sleepWeekendStatistics[4].minutes_rem_sleep! % 60;
                args.text = '${hours}h' + ' ${minutes.toInt()}m';
                break;

              default:
            }
            break;
          case 5:
            switch (args.seriesIndex) {
              case 0:
                double current =
                    sleepWeekendStatistics[5].minutes_deep_sleep! / 60;
                int hours = current.toInt();
                num minutes =
                    sleepWeekendStatistics[5].minutes_deep_sleep! % 60;
                args.text = '${hours}h' + ' ${minutes.toInt()}m';
                break;
              case 1:
                double current =
                    sleepWeekendStatistics[5].minutes_light_sleep! / 60;
                int hours = current.toInt();
                num minutes =
                    sleepWeekendStatistics[5].minutes_light_sleep! % 60;
                args.text = '${hours}h' + ' ${minutes.toInt()}m';
                break;
              case 2:
                double current =
                    sleepWeekendStatistics[5].minutes_rem_sleep! / 60;
                int hours = current.toInt();
                num minutes = sleepWeekendStatistics[5].minutes_rem_sleep! % 60;
                args.text = '${hours}h' + ' ${minutes.toInt()}m';
                break;

              default:
            }
            break;
          case 6:
            switch (args.seriesIndex) {
              case 0:
                double current =
                    sleepWeekendStatistics[6].minutes_deep_sleep! / 60;
                int hours = current.toInt();
                num minutes =
                    sleepWeekendStatistics[6].minutes_deep_sleep! % 60;
                args.text = '${hours}h' + ' ${minutes.toInt()}m';
                break;
              case 1:
                double current =
                    sleepWeekendStatistics[6].minutes_light_sleep! / 60;
                int hours = current.toInt();
                num minutes =
                    sleepWeekendStatistics[6].minutes_light_sleep! % 60;
                args.text = '${hours}h' + ' ${minutes.toInt()}m';
                break;
              case 2:
                double current =
                    sleepWeekendStatistics[6].minutes_rem_sleep! / 60;
                int hours = current.toInt();
                num minutes = sleepWeekendStatistics[6].minutes_rem_sleep! % 60;
                args.text = '${hours}h' + ' ${minutes.toInt()}m';
                break;

              default:
            }
            break;
          default:
        }
      },
      primaryXAxis: CategoryAxis(
          //μορφή χ άξονα
          axisLine: const AxisLine(
              width:
                  0), //τα width είναι μηδεν γιατί δεν θέλουμε να φαινονται οι γραμμες
          majorGridLines: const MajorGridLines(width: 0),
          majorTickLines: const MajorTickLines(
            size: 0,
            width: 0,
          ),
          isVisible: true,
          interval: 1,
          labelStyle: TextStyle(
            fontSize: 16,
          )),
      primaryYAxis: NumericAxis(
          //κάθετος άξονας y
          isVisible: false, //δεν θέλουμαι να εμφανίζεται
          axisLine: const AxisLine(width: 0),
          interval: 80, //interval για τις τιμές
          labelFormat: '{value}min',
          majorTickLines: const MajorTickLines(size: 0),
          minimum: 0,
          maximum: 480),
      series: _getStackedBarSeries(),
      tooltipBehavior: _tooltipBehavior, //κάνουμε set το tooltip
    );
  }

  List<ChartSeries<Sleep, String>> _getStackedBarSeries() {
    //δεδομένα διαγράμματος
    return <ChartSeries<Sleep, String>>[
      StackedColumnSeries<Sleep, String>(
        dataSource:
            sleepWeekendStatistics, //του δίνουμε ως source την λίστα που φτιάξαμε
        xValueMapper: (Sleep sales, _) =>
            ' ${DateFormat.d().format(DateTime.parse(sales.recording_day))}' +
            '${'/'}' +
            '${DateFormat.M().format(DateTime.parse(sales.recording_day))}' +
            '${'\n'}' +
            '${DateFormat.E().format(DateTime.parse(sales.recording_day))}',
        yValueMapper: (Sleep sales, _) => sales.minutes_deep_sleep,
        name: 'Deep',
        color: Color(0xff632af2),
      ),
      StackedColumnSeries<Sleep, String>(
        dataSource: sleepWeekendStatistics,
        xValueMapper: (Sleep sales, _) =>
            ' ${DateFormat.d().format(DateTime.parse(sales.recording_day))}' +
            '${'/'}' +
            '${DateFormat.M().format(DateTime.parse(sales.recording_day))}' +
            '${'\n'}' +
            '${DateFormat.E().format(DateTime.parse(sales.recording_day))}',
        yValueMapper: (Sleep sales, _) => sales.minutes_light_sleep,
        name: 'Light',
        color: Color(0xffffb3ba),
      ),
      StackedColumnSeries<Sleep, String>(
          dataSource: sleepWeekendStatistics,
          xValueMapper: (Sleep sales, _) =>
              ' ${DateFormat.d().format(DateTime.parse(sales.recording_day))}' +
              '${'/'}' +
              '${DateFormat.M().format(DateTime.parse(sales.recording_day))}' +
              '${'\n'}' +
              '${DateFormat.E().format(DateTime.parse(sales.recording_day))}',
          yValueMapper: (Sleep sales, _) => sales.minutes_rem_sleep,
          // borderRadius: const BorderRadius.all(Radius.circular(10)),
          name: 'REM',
          color: Color(0xff578eff)
          // color: HexColor('#F56E98').withOpacity(1.0),

          // width: 0.5, // Width of the columns
          // spacing: 0.2 // Spacing between the columns
          ),
    ];
  }

  @override
  void dispose() {
    chartData.clear();
    super.dispose();
  }
}

class _ChartData {
  //μοντέλο δεδομένων
  _ChartData(this.x, this.light, this.deep, this.rem);
  final String x;
  final num deep;
  final num light;
  final num rem;
}
