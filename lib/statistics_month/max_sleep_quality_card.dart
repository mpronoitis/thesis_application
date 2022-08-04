// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ptixiaki_sleep_stages/screens/statistics_month.dart';

import '../sleep_app_theme.dart';

class MaxSleepQuality extends StatelessWidget {
  const MaxSleepQuality({Key? key}) : super(key: key);
  static const Color _primaryColor = Colors.purple;
  static const Color _secondaryColor = Colors.purple;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _reportCard(
          isMax: true,
          title: 'Maximum Sleep Quality',
          progress: findMaxSleepQuality(),
        ),
        SizedBox(
          height: 16,
        ),
        _reportCard(
          isMax: false,
          title: 'Minimum Sleep Quality',
          progress: findMinSleepQuality(),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Container _reportCard({
    required bool isMax,
    required String title,
    required double progress,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      decoration: BoxDecoration(
        color: isMax ? Colors.white : _secondaryColor,
        borderRadius: BorderRadius.circular(30),
        border: isMax
            ? Border.all(color: _primaryColor.withOpacity(0.1), width: 2)
            : null,
        boxShadow: isMax
            ? []
            : [
                BoxShadow(
                  color: _secondaryColor.withOpacity(0.4),
                  offset: Offset(0, 8),
                  blurRadius: 10,
                ),
              ],
      ),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 8,
                  backgroundColor: isMax
                      ? _primaryColor.withOpacity(0.2)
                      : SleepAppTheme.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      isMax ? _secondaryColor : Colors.white),
                ),
              ),
              Container(
                width: 60,
                height: 60,
                alignment: Alignment.center,
                child: Text(
                  '${(progress * 100).toInt()}'.toString() + '%',
                  style: TextStyle(
                    color: isMax ? _primaryColor : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: isMax ? _primaryColor : Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

double findMaxSleepQuality() {
  double largestValue = sleepMonthStatistics[0].sleep_score;

  for (int i = 0; i < sleepMonthStatistics.length; i++) {
    if (sleepMonthStatistics[i].sleep_score > largestValue) {
      largestValue = sleepMonthStatistics[i].sleep_score;
    }
  }
  return largestValue;
}

double findMinSleepQuality() {
  double minimunValue = sleepMonthStatistics[0].sleep_score;

  for (int i = 0; i < sleepMonthStatistics.length; i++) {
    if (sleepMonthStatistics[i].sleep_score < minimunValue) {
      minimunValue = sleepMonthStatistics[i].sleep_score;
    }
  }
  return minimunValue;
}
