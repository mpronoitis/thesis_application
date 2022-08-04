// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../sleep_app_theme.dart';

class IndicatorWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;

  const IndicatorWidget(
      {required this.title, required this.subtitle, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title,
            style: TextStyle(
              fontFamily: SleepAppTheme.fontName,
              fontWeight: FontWeight.w500,
              fontSize: 20,
              letterSpacing: -0.1,
              color: color,
            )),
        Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Text(
            subtitle,
            style: TextStyle(
                fontFamily: SleepAppTheme.fontName,
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: SleepAppTheme.darkText),
          ),
        )
      ],
    );
  }
}
