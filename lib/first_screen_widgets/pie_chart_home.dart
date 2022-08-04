// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:flutter/material.dart';

import 'package:ptixiaki_sleep_stages/widget/custom_pie_chart.dart';

import '../../main.dart';
import '../../widget/indicator_widget.dart';
import '../sleep_app_theme.dart';

class ActivityPieChart extends StatefulWidget {
  @override
  _ActivityPieChartState createState() => _ActivityPieChartState();
}

class _ActivityPieChartState extends State<ActivityPieChart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          child: Container(
            margin: EdgeInsets.only(
              left: 21.0,
              right: 21.0,
            ),
            padding: EdgeInsets.all(
              8.0,
            ),
            decoration: BoxDecoration(
              // gradient: LinearGradient(colors: [
              //   Color(0xff0f17ad).withOpacity(0.8),
              //   Color(0xFF6985e8).withOpacity(0.9)
              // ]),
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
            child: Padding(
              padding: EdgeInsets.all(
                8.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Totally Sleep Time',
                        style: TextStyle(
                            fontFamily: SleepAppTheme.fontName,
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            letterSpacing: 0.5,
                            // color: SleepAppTheme.lightText,'
                            color: Colors.deepPurple),
                      ),
                      Text('            7h 57m',
                          style: TextStyle(
                            fontFamily: SleepAppTheme.fontName,
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            color: SleepAppTheme.darkText,
                          )),
                      Row(
                        children: [
                          Icon(
                            Icons.brightness_1,
                            size: 22,
                            color: HexColor('#87A0E5').withOpacity(1.0),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Deep Sleep',
                            style: TextStyle(
                                fontFamily: SleepAppTheme.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: SleepAppTheme.darkText),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('1h 41m',
                              style: TextStyle(
                                fontFamily: SleepAppTheme.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: SleepAppTheme.darkText,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.brightness_1,
                            size: 22,
                            color: HexColor('#F56E98').withOpacity(1.0),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Light Sleep',
                            style: TextStyle(
                              fontFamily: SleepAppTheme.fontName,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: SleepAppTheme.darkText,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '5h 41m',
                            style: TextStyle(
                                fontFamily: SleepAppTheme.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: SleepAppTheme.darkText),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.brightness_1,
                            size: 22,
                            color: HexColor('#F1B440').withOpacity(1.0),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'REM Sleep',
                            style: TextStyle(
                                fontFamily: SleepAppTheme.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: SleepAppTheme.darkText),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '5h 41m',
                            style: TextStyle(
                                fontFamily: SleepAppTheme.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: SleepAppTheme.darkText),
                          )
                        ],
                      ),
                      // CustomPieChart(),
                    ],
                  ),
                  CustomPieChart(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
//     return Container(
//       height: 170,
//       child: Card(
//         margin: EdgeInsets.only(left: 22.0, right: 22.0),
//         color: SleepAppTheme.white,
//         elevation: 0.0,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
//         child: Row(
//           children: [
//             Container(
//               width: 200,
//               // Pie Chart is available in fl_chart package
//               child: PieChart(
//                 PieChartData(
//                   borderData: FlBorderData(show: false),
//                   centerSpaceRadius: 40.0,
//                   sectionsSpace: 0.0,
//                   startDegreeOffset: 30.0,
//                   sections: showingSections(),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 margin: EdgeInsets.symmetric(vertical: 5.0),
//                 padding: EdgeInsets.only(
//                   top: 5.0,
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     IndicatorWidget(
//                       title: 'Deep Sleep',
//                       subtitle: '1h 25m',
//                       color: HexColor('#87A0E5').withOpacity(1.0),
//                     ),
//                     IndicatorWidget(
//                       title: 'Light Sleep',
//                       subtitle: '5h 41m',
//                       color: HexColor('#F56E98').withOpacity(1.0),
//                     ),
//                     IndicatorWidget(
//                       title: 'REM',
//                       subtitle: '1h 20m',
//                       color: HexColor('#F1B440').withOpacity(1.0),
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   List<PieChartSectionData> showingSections() {
//     return List.generate(3, (i) {
//       final isTouched = i == _touchedIndex;

//       final double radius = isTouched ? 30 : 20;

//       switch (i) {
//         case 0:
//           return PieChartSectionData(
//               color: HexColor('#87A0E5').withOpacity(1.0),
//               value: 16,
//               title: '', // this cannot be left blank
//               radius: radius);
//         case 1:
//           return PieChartSectionData(
//               color: HexColor('#F56E98').withOpacity(1.0),
//               value: 30,
//               title: '', // this cannot be left blank
//               radius: radius);
//         case 2:
//           return PieChartSectionData(
//               color: HexColor('#F1B440').withOpacity(1.0),
//               value: 70.33,
//               title: '', // this cannot be left blank
//               radius: radius);
//         default:
//           return PieChartSectionData();
//       }
//     });
//   }
// }
