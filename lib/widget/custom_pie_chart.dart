// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../main.dart';
import '../sleep_app_theme.dart';


class CustomPieChart extends StatelessWidget {
  const CustomPieChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.only(left: 12.0),
        child: PieChart(
          PieChartData(
            borderData: FlBorderData(show: false),
            centerSpaceRadius: 40.0,
            sectionsSpace: 0.0,
            startDegreeOffset: 30.0,
            sections: showingSections(),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: HexColor('#87A0E5').withOpacity(1.0),
            value: 30,
            title: '30%',
            titleStyle: TextStyle(
              fontFamily: SleepAppTheme.fontName,
              fontWeight: FontWeight.w500,
              fontSize: 17,
              color: SleepAppTheme.darkText,
            ), // this cannot be left blank
            radius: 30,
            showTitle: true,
          );
        case 1:
          return PieChartSectionData(
              color: HexColor('#F56E98').withOpacity(1.0),
              value: 60,
              title: '60%',
              titleStyle: TextStyle(
                fontFamily: SleepAppTheme.fontName,
                fontWeight: FontWeight.w500,
                fontSize: 17,
                color: SleepAppTheme.darkText,
              ), // this cannot be left blank
              radius: 30);
        case 2:
          return PieChartSectionData(
              color: HexColor('#F1B440').withOpacity(1.0),
              value: 10,
              title: '10%',
              titleStyle: TextStyle(
                fontFamily: SleepAppTheme.fontName,
                fontWeight: FontWeight.w500,
                fontSize: 17,
                color: SleepAppTheme.darkText,
              ), // this cannot be left blank
              radius: 30);
        default:
          return PieChartSectionData();
      }
    });
  }
}
