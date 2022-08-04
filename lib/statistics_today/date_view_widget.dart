// ignore_for_file: prefer_const_constructors, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../screens/statistics.dart';
import '../sleep_app_theme.dart';


class DateView extends StatelessWidget {
  const DateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 90,
          right: 70,
          top: 15.0,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                DateFormat('EEEE, MMM d, yyyy')
                    .format(DateTime.parse(sleepStatistics[0].recording_day)),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: SleepAppTheme.fontName,
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  letterSpacing: 0.5,
                  color: SleepAppTheme.lightText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
