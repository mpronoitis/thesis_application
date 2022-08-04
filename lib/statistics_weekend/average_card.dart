// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../screens/statistics_weekend.dart';
import '../sleep_app_theme.dart';

class AverageCard extends StatefulWidget {
  const AverageCard({Key? key}) : super(key: key);

  @override
  State<AverageCard> createState() => _AverageCardState();
}

class _AverageCardState extends State<AverageCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 24, top: 16, bottom: 18),
      child: Container(
        decoration: BoxDecoration(
          color: SleepAppTheme.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topRight: Radius.circular(8.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: SleepAppTheme.grey.withOpacity(0.2),
                offset: Offset(1.1, 1.1),
                blurRadius: 10.0),
          ],
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 8, top: 16),
                    child: Text(
                      'Average Sleep Score',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: SleepAppTheme.fontName,
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                        letterSpacing: -0.1,
                        color: SleepAppTheme.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 4, bottom: 3),
                            child: Text(
                              getAverage(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: SleepAppTheme.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 32,
                                color: SleepAppTheme.nearlyDarkBlue,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, bottom: 8),
                            child: Text(
                              '%',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: SleepAppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                                letterSpacing: -0.2,
                                color: SleepAppTheme.nearlyDarkBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  RatingBar.builder(
                    initialRating: double.parse(getAverage()) / 20,
                    minRating: 1,
                    itemSize: 30.0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  color: SleepAppTheme.background,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: Text(
                'Exposure to plenty of sunlight during the day helps to create melatonin at night, which leads to deeper sleep. Two or more hours each day outdoors is enough to get your body enough sunlight.',
                style: TextStyle(
                  fontFamily: SleepAppTheme.fontName,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  letterSpacing: -0.2,
                  color: SleepAppTheme.darkText,
                ),
              ),
              // child: Row(
              //   children: <Widget>[
              //     Expanded(
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           Text(
              //             '185 cm',
              //             textAlign: TextAlign.center,
              //             style: TextStyle(
              //               fontFamily: SleepAppTheme.fontName,
              //               fontWeight: FontWeight.w500,
              //               fontSize: 16,
              //               letterSpacing: -0.2,
              //               color: SleepAppTheme.darkText,
              //             ),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.only(top: 6),
              //             child: Text(
              //               'Height',
              //               textAlign: TextAlign.center,
              //               style: TextStyle(
              //                 fontFamily: SleepAppTheme.fontName,
              //                 fontWeight: FontWeight.w600,
              //                 fontSize: 12,
              //                 color: SleepAppTheme.grey.withOpacity(0.5),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     Expanded(
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: <Widget>[
              //           Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: <Widget>[
              //               Text(
              //                 '27.3 BMI',
              //                 textAlign: TextAlign.center,
              //                 style: TextStyle(
              //                   fontFamily: SleepAppTheme.fontName,
              //                   fontWeight: FontWeight.w500,
              //                   fontSize: 16,
              //                   letterSpacing: -0.2,
              //                   color: SleepAppTheme.darkText,
              //                 ),
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.only(top: 6),
              //                 child: Text(
              //                   'Overweight',
              //                   textAlign: TextAlign.center,
              //                   style: TextStyle(
              //                     fontFamily: SleepAppTheme.fontName,
              //                     fontWeight: FontWeight.w600,
              //                     fontSize: 12,
              //                     color: SleepAppTheme.grey.withOpacity(0.5),
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
              //     Expanded(
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: <Widget>[
              //           Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             crossAxisAlignment: CrossAxisAlignment.end,
              //             children: <Widget>[
              //               Text(
              //                 '20%',
              //                 style: TextStyle(
              //                   fontFamily: SleepAppTheme.fontName,
              //                   fontWeight: FontWeight.w500,
              //                   fontSize: 16,
              //                   letterSpacing: -0.2,
              //                   color: SleepAppTheme.darkText,
              //                 ),
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.only(top: 6),
              //                 child: Text(
              //                   'Body fat',
              //                   textAlign: TextAlign.center,
              //                   style: TextStyle(
              //                     fontFamily: SleepAppTheme.fontName,
              //                     fontWeight: FontWeight.w600,
              //                     fontSize: 12,
              //                     color: SleepAppTheme.grey.withOpacity(0.5),
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     )
              //   ],
              // ),
            )
          ],
        ),
      ),
    );
  }
}

String getAverage() {
  double average = 0.0;
  int finalAverage = 0;
  for (int i = 0; i < sleepWeekendStatistics.length; i++) {
    average += sleepWeekendStatistics[i].sleep_score;
  }
  finalAverage = ((average / sleepWeekendStatistics.length) * 100).toInt();

  return finalAverage.toString();
}
