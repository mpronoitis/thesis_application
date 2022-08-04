// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../main.dart';
import '../screens/first_screen.dart';
import '../sleep_app_theme.dart';

class CardStaggered extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;
  const CardStaggered({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  State<CardStaggered> createState() => _CardStaggeredState();
}

class _CardStaggeredState extends State<CardStaggered> {
  final double percent = 0.5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 200,
              width: 200,
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
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Sleep Quality',
                    style: TextStyle(
                      fontFamily: SleepAppTheme.fontName,
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      letterSpacing: 0.5,
                      color: SleepAppTheme.lightText,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CircularPercentIndicator(
                    radius: 120.0,
                    lineWidth: 13.0,
                    animation: true,
                    percent: homeData[0].sleep_score,
                    center: Text(
                      // ignore: unnecessary_string_interpolations
                      '${((homeData[0].sleep_score * 100).toInt()).toString()}' +
                          '${'%'}',
                      style: const TextStyle(
                        fontFamily: SleepAppTheme.fontName,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        letterSpacing: 0.0,
                        color: SleepAppTheme.darkText,
                      ),
                    ),
                    // footer: Text(
                    //   "Sleep Score",
                    //   style: TextStyle(
                    //     fontFamily: SleepAppTheme.fontName,
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 20,
                    //     letterSpacing: 0.0,
                    //     color: SleepAppTheme.grey.withOpacity(0.5),
                    //   ),
                    // ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: percent < 0.6 ? Colors.red : Colors.purple,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Container(
              width: 200,
              height: 200,
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
              child: Column(
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Duration',
                    style: TextStyle(
                      fontFamily: SleepAppTheme.fontName,
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      letterSpacing: 0.5,
                      color: SleepAppTheme.lightText,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '7h 25m',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: SleepAppTheme.fontName,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: SleepAppTheme.darkerText,
                    ),
                  ),
                  Text(
                    'Total Sleep',
                    style: TextStyle(
                      fontFamily: SleepAppTheme.fontName,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: SleepAppTheme.darkerText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 8, bottom: 8),
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: SleepAppTheme.background,
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                    ),
                  ),
                  Text(
                    '7h 55m',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: SleepAppTheme.fontName,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: SleepAppTheme.darkerText,
                    ),
                  ),
                  Text(
                    'Time In Bed',
                    style: TextStyle(
                      fontFamily: SleepAppTheme.fontName,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: SleepAppTheme.darkerText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        AnimatedBuilder(
            animation: widget.animationController!,
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                  opacity: widget.animation!,
                  child: Transform(
                      transform: Matrix4.translationValues(
                          0.0, 30 * (1.0 - widget.animation!.value), 0.0),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 10, bottom: 40),
                          child: Container(
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
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 10, right: 16),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20, top: 20),
                                          child: Row(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                    height: 48,
                                                    width: 2,
                                                    decoration: BoxDecoration(
                                                      color: HexColor('#87A0E5')
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  4.0)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 4,
                                                                  bottom: 2),
                                                          child: Text(
                                                            'Going to Bed',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  SleepAppTheme
                                                                      .fontName,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 22,
                                                              letterSpacing:
                                                                  -0.1,
                                                              color: SleepAppTheme
                                                                  .grey
                                                                  .withOpacity(
                                                                      0.5),
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: <Widget>[
                                                            SizedBox(
                                                              width: 28,
                                                              height: 28,
                                                              child: Image.asset(
                                                                  "assets/fitness_app/half-moon.png"),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 4,
                                                                      bottom:
                                                                          3),
                                                              child: Text(
                                                                '12:30',
                                                                // Text(
                                                                //   '${(1127 * animation!.value).toInt()}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      SleepAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 20,
                                                                  color: SleepAppTheme
                                                                      .darkerText,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 4,
                                                                      bottom:
                                                                          3),
                                                              child: Text(
                                                                'PM',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        SleepAppTheme
                                                                            .fontName,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        20,
                                                                    color: SleepAppTheme
                                                                        .darkText),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                    height: 48,
                                                    width: 2,
                                                    decoration: BoxDecoration(
                                                      color: HexColor('#87A0E5')
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  4.0)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 4,
                                                                  bottom: 2),
                                                          child: Text(
                                                            'Wake up',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  SleepAppTheme
                                                                      .fontName,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 22,
                                                              letterSpacing:
                                                                  -0.1,
                                                              color: SleepAppTheme
                                                                  .grey
                                                                  .withOpacity(
                                                                      0.5),
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: <Widget>[
                                                            SizedBox(
                                                              width: 28,
                                                              height: 28,
                                                              child: Image.asset(
                                                                  "assets/fitness_app/sun.png"),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 4,
                                                                      bottom:
                                                                          3),
                                                              child: Text(
                                                                '6:30',
                                                                // Text(
                                                                //   '${(102 * animation!.value).toInt()}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      SleepAppTheme
                                                                          .fontName,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 20,
                                                                  color: SleepAppTheme
                                                                      .darkerText,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 8,
                                                                      bottom:
                                                                          3),
                                                              child: Text(
                                                                'AM',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        SleepAppTheme
                                                                            .fontName,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        20,
                                                                    color: SleepAppTheme
                                                                        .darkText),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: EdgeInsets.only(right: 15.0),
                                      //   child: CircularPercentIndicator(
                                      //     radius: 120.0,
                                      //     lineWidth: 13.0,
                                      //     animation: true,
                                      //     percent: homeData[0].sleep_score,
                                      //     center: Text(
                                      //       (homeData[0].sleep_score * 100)
                                      //           .toString(),
                                      //       style: TextStyle(
                                      //         fontFamily:
                                      //             SleepAppTheme.fontName,
                                      //         fontWeight: FontWeight.bold,
                                      //         fontSize: 24,
                                      //         letterSpacing: 0.0,
                                      //         color: SleepAppTheme.darkText,
                                      //       ),
                                      //     ),
                                      //     footer: Text(
                                      //       "Sleep Score",
                                      //       style: TextStyle(
                                      //         fontFamily:
                                      //             SleepAppTheme.fontName,
                                      //         fontWeight: FontWeight.bold,
                                      //         fontSize: 20,
                                      //         letterSpacing: 0.0,
                                      //         color: SleepAppTheme.grey
                                      //             .withOpacity(0.5),
                                      //       ),
                                      //     ),
                                      //     circularStrokeCap:
                                      //         CircularStrokeCap.round,
                                      //     progressColor: percent < 0.6
                                      //         ? Colors.red
                                      //         : Colors.purple,
                                      //   ),
                                      // ),
                                      //           Padding(
                                      //             padding: const EdgeInsets.only(right: 16),
                                      //             child: Center(
                                      //               child: Stack(
                                      //                 clipBehavior: Clip.none,
                                      //                 children: <Widget>[
                                      //                   Padding(
                                      //                     padding: const EdgeInsets.all(8.0),
                                      //                     child: Container(
                                      //                       width: 100,
                                      //                       height: 100,
                                      //                       decoration: BoxDecoration(
                                      //                         color: FitnessAppTheme.white,
                                      //                         borderRadius: BorderRadius.all(
                                      //                           Radius.circular(100.0),
                                      //                         ),
                                      //                         border: Border.all(
                                      //                             width: 5,
                                      //                             color: FitnessAppTheme
                                      //                                 .nearlyDarkBlue
                                      //                                 .withOpacity(0.2)),
                                      //                       ),
                                      //                       child: Column(
                                      //                         mainAxisAlignment:
                                      //                             MainAxisAlignment.center,
                                      //                         crossAxisAlignment:
                                      //                             CrossAxisAlignment.center,
                                      //                         children: <Widget>[
                                      //                           Text(
                                      //                             '80',
                                      //                             // Text(
                                      //                             //   '${(1503 * animation!.value).toInt()}',
                                      //                             textAlign: TextAlign.center,
                                      //                             style: TextStyle(
                                      //                               fontFamily: FitnessAppTheme
                                      //                                   .fontName,
                                      //                               fontWeight:
                                      //                                   FontWeight.normal,
                                      //                               fontSize: 24,
                                      //                               letterSpacing: 0.0,
                                      //                               color: FitnessAppTheme
                                      //                                   .darkText,
                                      //                             ),
                                      //                           ),
                                      //                           Column(
                                      //                             children: [
                                      //                               Text(
                                      //                                 'Sleep',
                                      //                                 textAlign:
                                      //                                     TextAlign.center,
                                      //                                 style: TextStyle(
                                      //                                   fontFamily:
                                      //                                       FitnessAppTheme
                                      //                                           .fontName,
                                      //                                   fontWeight:
                                      //                                       FontWeight.bold,
                                      //                                   fontSize: 18,
                                      //                                   letterSpacing: 0.0,
                                      //                                   color: FitnessAppTheme
                                      //                                       .grey
                                      //                                       .withOpacity(0.5),
                                      //                                 ),
                                      //                               ),
                                      //                               Text(
                                      //                                 'Score',
                                      //                                 textAlign:
                                      //                                     TextAlign.center,
                                      //                                 style: TextStyle(
                                      //                                   fontFamily:
                                      //                                       FitnessAppTheme
                                      //                                           .fontName,
                                      //                                   fontWeight:
                                      //                                       FontWeight.bold,
                                      //                                   fontSize: 18,
                                      //                                   letterSpacing: 0.0,
                                      //                                   color: FitnessAppTheme
                                      //                                       .grey
                                      //                                       .withOpacity(0.5),
                                      //                                 ),
                                      //                               ),
                                      //                             ],
                                      //                           ),
                                      //                         ],
                                      //                       ),
                                      //                     ),
                                      //                   ),
                                      //                   Padding(
                                      //                     padding: const EdgeInsets.all(4.0),
                                      //                     child: CustomPaint(
                                      //                       painter: CurvePainter(
                                      //                           colors: [
                                      //                             Colors.deepPurple,
                                      //                             Colors.deepPurple
                                      //                             // FitnessAppTheme
                                      //                             //     .nearlyDarkBlue,
                                      //                             // FitnessAppTheme
                                      //                             //     .nearlyDarkBlue,
                                      //                           ],
                                      //                           angle: 240 +
                                      //                               (360 - 140) * (1.0 - 0.9)),
                                      //                       child: SizedBox(
                                      //                         width: 108,
                                      //                         height: 108,
                                      //                       ),
                                      //                     ),
                                      //                   )
                                      //                 ],
                                      //               ),
                                      //             ),
                                      //  ela         )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24, right: 24, top: 8, bottom: 8),
                                  child: Container(
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: SleepAppTheme.background,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24, right: 24, top: 8, bottom: 16),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Text(
                                                  'Deep ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        SleepAppTheme.fontName,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20,
                                                    letterSpacing: -0.1,
                                                    color: SleepAppTheme.grey
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                                // Text(
                                                //   'Sleep',
                                                //   textAlign: TextAlign.center,
                                                //   style: TextStyle(
                                                //     fontFamily:
                                                //         FitnessAppTheme.fontName,
                                                //     fontWeight: FontWeight.w500,
                                                //     fontSize: 20,
                                                //     letterSpacing: -0.1,
                                                //     color: FitnessAppTheme.grey
                                                //         .withOpacity(0.5),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Container(
                                                height: 4,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  color: HexColor('#87A0E5')
                                                      .withOpacity(1.0),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4.0)),
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      width: ((70 / 1.2) *
                                                          widget.animation!
                                                              .value),
                                                      height: 4,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                              HexColor(
                                                                  '#87A0E5'),
                                                              HexColor(
                                                                      '#87A0E5')
                                                                  .withOpacity(
                                                                      0.5),
                                                            ]),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    4.0)),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 6),
                                              child: Text(
                                                '6h 10m',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily:
                                                        SleepAppTheme.fontName,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    color:
                                                        SleepAppTheme.darkText),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'REM',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        SleepAppTheme.fontName,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20,
                                                    letterSpacing: -0.1,
                                                    color: SleepAppTheme.grey
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4),
                                                  child: Container(
                                                    height: 4,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                      color: HexColor('#F56E98')
                                                          .withOpacity(1.0),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  4.0)),
                                                    ),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                          width: ((70 / 2) *
                                                              widget
                                                                  .animationController!
                                                                  .value),
                                                          height: 4,
                                                          decoration:
                                                              BoxDecoration(
                                                            gradient:
                                                                LinearGradient(
                                                                    colors: [
                                                                  HexColor(
                                                                          '#F56E98')
                                                                      .withOpacity(
                                                                          0.1),
                                                                  HexColor(
                                                                      '#F56E98'),
                                                                ]),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            4.0)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6),
                                                  child: Text(
                                                    '7h 28m',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            SleepAppTheme
                                                                .fontName,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18,
                                                        color: SleepAppTheme
                                                            .darkText),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'Light',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        SleepAppTheme.fontName,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20,
                                                    letterSpacing: -0.1,
                                                    color: SleepAppTheme.grey
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 0, top: 4),
                                                  child: Container(
                                                    height: 4,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                      color: HexColor('#F1B440')
                                                          .withOpacity(1.0),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  4.0)),
                                                    ),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                          width: ((70 / 2.5) *
                                                              widget
                                                                  .animationController!
                                                                  .value),
                                                          height: 4,
                                                          decoration:
                                                              BoxDecoration(
                                                            gradient:
                                                                LinearGradient(
                                                                    colors: [
                                                                  HexColor(
                                                                          '#F1B440')
                                                                      .withOpacity(
                                                                          0.1),
                                                                  HexColor(
                                                                      '#F1B440'),
                                                                ]),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            4.0)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6),
                                                  child: Text(
                                                    '3h 23m',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            SleepAppTheme
                                                                .fontName,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18,
                                                        color: SleepAppTheme
                                                            .darkerText),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ))));
            }),
        // ActivityPieChart()
      ]),
    );
  }
}
