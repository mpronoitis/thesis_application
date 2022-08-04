// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:ptixiaki_sleep_stages/screens/first_screen.dart';
import 'package:ptixiaki_sleep_stages/screens/statistics.dart';

import '../main.dart';
import '../sleep_app_theme.dart';

class LinearStages extends StatelessWidget {
  const LinearStages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.0,
      ),
      child: Column(
        children: [
          LinearStage(
            title: 'Sleep Duration',
            color: Colors.blue,
            duration: getConversion(sleepStatistics[0].asleep_min!),
          ),
          LinearStage(
            title: 'Time to Fall Asleep',
            color: Colors.blue,
            duration: getConversion(sleepStatistics[0].asleep_after!),
          ),
          LinearStage(
            title: 'Light Sleep',
            color: HexColor('#F1B440').withOpacity(1.0),
            duration: getConversion(sleepStatistics[0].minutes_light_sleep!),
          ),
          LinearStage(
            title: 'Deep Sleep',
            color: HexColor('#87A0E5').withOpacity(1.0),
            duration: getConversion(sleepStatistics[0].minutes_deep_sleep!),
          ),
          LinearStage(
            title: 'REM Sleep',
            color: HexColor('#F56E98').withOpacity(1.0),
            duration: getConversion(sleepStatistics[0].minutes_rem_sleep!),
          ),
        ],
      ),
    );
  }
}

class LinearStage extends StatelessWidget {
  final String title;
  final Color color;
  final String duration;
  const LinearStage(
      {Key? key,
      required this.title,
      required this.color,
      required this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontFamily: SleepAppTheme.fontName,
              fontWeight: FontWeight.w500,
              fontSize: 22,
              letterSpacing: -0.1,
              color: color),
        ),
        Row(
          children: [
            LinearPercentIndicator(
                width: 280.0,
                lineHeight: 13.0,
                percent: getPercent(duration) / 100,
                progressColor: color),
            SizedBox(
              width: 30.0,
            ),
            Text(
              duration,
              style: TextStyle(
                  fontFamily: SleepAppTheme.fontName,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: color),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}

String getConversion(double total_asleep) {
  double current = (total_asleep) / 60;
  int hours = current.toInt();
  double minutes = total_asleep % 60;
  String finalText = '${hours}h' + ' ${minutes.toInt()}m';
  return finalText;
}

String getConversionSS(double total_asleep) {
  double current = (total_asleep) / 60;
  int hours = current.toInt();
  double minutes = total_asleep % 60;
  String finalText = '${hours}h' + ' ${minutes.toInt()}m';
  print(finalText);
  return finalText;
}

String getConversionS(int total_asleep) {
  double current = (total_asleep) / 60;
  int hours = current.toInt();
  double minutes = total_asleep % 60;
  String finalText = '${hours}h' + ' ${minutes.toInt()}m';
  return finalText;
}

double getPercent(String duration) {
  int hourToMinutes = int.parse(duration.split("h")[0]) * 60;
  int minute = int.parse(duration.split("h")[1].split("m")[0]);
  int total = hourToMinutes + minute;
  print((total * 100) / 480);
  return (total * 100) / 480;
}

double getPercentAsleepAfter(String duration) {
  int hourToMinutes = int.parse(duration.split("h")[0]) * 60;
  int minute = int.parse(duration.split("h")[1].split("m")[0]);
  int total = hourToMinutes + minute;

  return (total * 100) / 30;
}

double getPercentLightSleep(String duration) {
  double re = sleepStatistics[0].asleep_min! / 100;

  int hourToMinutes = int.parse(duration.split("h")[0]) * 60;
  int minute = int.parse(duration.split("h")[1].split("m")[0]);
  int total = hourToMinutes + minute;
  print(total);
  double prin = (total * 100) / sleepStatistics[0].asleep_min! * 0.7;
  print(prin / 100);
  if (prin / 100 <= 1.0) {
    return (total * 100) / sleepStatistics[0].asleep_min! * 0.7;
  } else {
    return 100;
  }
}

String getPercentS(String duration) {
  int hourToMinutes = int.parse(duration.split("h")[0]) * 60;
  int minute = int.parse(duration.split("h")[1].split("m")[0]);
  int total = hourToMinutes + minute;
  double totalIt = (total * 100) / 400;
  return totalIt.toString();
}
