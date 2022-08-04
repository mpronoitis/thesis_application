// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../main.dart';
import '../models/sleep.dart';
import '../screens/first_screen.dart';
import '../sleep_app_theme.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SleepStagesCard extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  SleepStagesCard({
    Key? key,
    this.animationController,
    this.animation,
  }) : super(key: key);

  @override
  State<SleepStagesCard> createState() => _SleepStagesCardState();
}

class _SleepStagesCardState extends State<SleepStagesCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final double percent = 0.5;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.animationController!,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
              opacity: widget.animation!,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 30 * (1.0 - widget.animation!.value), 0.0),
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 5, bottom: 18),
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
                                  top: 16, left: 16, right: 16),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8, top: 4),
                                      child: Column(
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
                                                          Radius.circular(4.0)),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4,
                                                              bottom: 2),
                                                      child: Text(
                                                        'Deep sleep',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              SleepAppTheme
                                                                  .fontName,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 22,
                                                          letterSpacing: -0.1,
                                                          color: SleepAppTheme
                                                              .grey
                                                              .withOpacity(0.5),
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
                                                              "assets/sleep_app/went_to_bed.png"),
                                                        ),
                                                        // Padding(
                                                        //   padding:
                                                        //       const EdgeInsets
                                                        //               .only(
                                                        //           left: 4,
                                                        //           bottom: 3),
                                                        //   child: Text(
                                                        //     '11:34',
                                                        //     // Text(
                                                        //     //   '${(1127 * animation!.value).toInt()}',
                                                        //     textAlign: TextAlign
                                                        //         .center,
                                                        //     style: TextStyle(
                                                        //       fontFamily:
                                                        //           SleepAppTheme
                                                        //               .fontName,
                                                        //       fontWeight:
                                                        //           FontWeight
                                                        //               .w600,
                                                        //       fontSize: 20,
                                                        //       color: SleepAppTheme
                                                        //           .darkerText,
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                        // Padding(
                                                        //   padding:
                                                        //       const EdgeInsets
                                                        //               .only(
                                                        //           left: 4,
                                                        //           bottom: 3),
                                                        //   child: Text(
                                                        //     'PM',
                                                        //     textAlign: TextAlign
                                                        //         .center,
                                                        //     style: TextStyle(
                                                        //         fontFamily:
                                                        //             SleepAppTheme
                                                        //                 .fontName,
                                                        //         fontWeight:
                                                        //             FontWeight
                                                        //                 .w600,
                                                        //         fontSize: 20,
                                                        //         color: SleepAppTheme
                                                        //             .darkText),
                                                        //   ),
                                                        // ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 6),
                                                          child: Text(
                                                            '3h 10m',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    SleepAppTheme
                                                                        .fontName,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 20,
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
                                          Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 10,
                                                height: 10,
                                                child: CircularPercentIndicator(
                                                  radius: 40.0,
                                                  lineWidth: 20.0,
                                                  animation: true,
                                                  percent:
                                                      homeData[0].sleep_score,
                                                  // center: Text(
                                                  //   ((homeData[0].sleep_score *
                                                  //                   100)
                                                  //               .toInt())
                                                  //           .toString() +
                                                  //       '${'%'}',
                                                  //   style: TextStyle(
                                                  //     fontFamily: SleepAppTheme
                                                  //         .fontName,
                                                  //     fontWeight:
                                                  //         FontWeight.bold,
                                                  //     fontSize: 24,
                                                  //     letterSpacing: 0.0,
                                                  //     color: SleepAppTheme
                                                  //         .darkText,
                                                  //   ),
                                                  // ),
                                                  // footer: Text(
                                                  //   "Sleep Score",
                                                  //   style: TextStyle(
                                                  //     fontFamily: SleepAppTheme.fontName,
                                                  //     fontWeight: FontWeight.bold,
                                                  //     fontSize: 20,
                                                  //     letterSpacing: 0.0,
                                                  //     color: SleepAppTheme.grey
                                                  //         .withOpacity(0.5),
                                                  //   ),
                                                  // ),
                                                  circularStrokeCap:
                                                      CircularStrokeCap.round,
                                                  progressColor: percent < 0.6
                                                      ? Colors.red
                                                      : Colors.purple,
                                                ),
                                              ),
                                              // Container(
                                              //   height: 48,
                                              //   width: 2,
                                              //   decoration: BoxDecoration(
                                              //     color: HexColor('#87A0E5')
                                              //         .withOpacity(0.5),
                                              //     borderRadius:
                                              //         BorderRadius.all(
                                              //             Radius.circular(4.0)),
                                              //   ),
                                              // ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4,
                                                              bottom: 2),
                                                      child: Text(
                                                        'REM',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              SleepAppTheme
                                                                  .fontName,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 22,
                                                          letterSpacing: -0.1,
                                                          color: SleepAppTheme
                                                              .grey
                                                              .withOpacity(0.5),
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
                                                              "assets/sleep_app/asleep_after_2.png"),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 4,
                                                                  bottom: 3),
                                                          child: Text(
                                                            '10',
                                                            // Text(
                                                            //   '${(102 * animation!.value).toInt()}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
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
                                                                  bottom: 3),
                                                          child: Text(
                                                            'min',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    SleepAppTheme
                                                                        .fontName,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 20,
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
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8, top: 4),
                                      child: Column(
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
                                                          Radius.circular(4.0)),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4,
                                                              bottom: 2),
                                                      child: Text(
                                                        'Light sleep',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              SleepAppTheme
                                                                  .fontName,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 22,
                                                          letterSpacing: -0.1,
                                                          color: SleepAppTheme
                                                              .grey
                                                              .withOpacity(0.5),
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
                                                              "assets/sleep_app/went_to_bed.png"),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 4,
                                                                  bottom: 3),
                                                          child: Text(
                                                            '11:34',
                                                            // Text(
                                                            //   '${(1127 * animation!.value).toInt()}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
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
                                                                  bottom: 3),
                                                          child: Text(
                                                            'PM',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    SleepAppTheme
                                                                        .fontName,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 20,
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
                                                          Radius.circular(4.0)),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4,
                                                              bottom: 2),
                                                      child: Text(
                                                        'Awake',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              SleepAppTheme
                                                                  .fontName,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 22,
                                                          letterSpacing: -0.1,
                                                          color: SleepAppTheme
                                                              .grey
                                                              .withOpacity(0.5),
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
                                                              "assets/sleep_app/asleep_after_2.png"),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 4,
                                                                  bottom: 3),
                                                          child: Text(
                                                            '10',
                                                            // Text(
                                                            //   '${(102 * animation!.value).toInt()}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
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
                                                                  bottom: 3),
                                                          child: Text(
                                                            'min',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    SleepAppTheme
                                                                        .fontName,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 20,
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
                                  // child: CircularPercentIndicator(
                                  //   radius: 120.0,
                                  //   lineWidth: 13.0,
                                  //   animation: true,
                                  //   percent: homeData[0].sleep_score,
                                  //   center: Text(
                                  //     ((homeData[0].sleep_score * 100)
                                  //                 .toInt())
                                  //             .toString() +
                                  //         '${'%'}',
                                  //     style: TextStyle(
                                  //       fontFamily: SleepAppTheme.fontName,
                                  //       fontWeight: FontWeight.bold,
                                  //       fontSize: 24,
                                  //       letterSpacing: 0.0,
                                  //       color: SleepAppTheme.darkText,
                                  //     ),
                                  //   ),
                                  //   footer: Text(
                                  //     "Sleep Score",
                                  //     style: TextStyle(
                                  //       fontFamily: SleepAppTheme.fontName,
                                  //       fontWeight: FontWeight.bold,
                                  //       fontSize: 20,
                                  //       letterSpacing: 0.0,
                                  //       color: SleepAppTheme.grey
                                  //           .withOpacity(0.5),
                                  //     ),
                                  //   ),
                                  //   circularStrokeCap:
                                  //       CircularStrokeCap.round,
                                  //   progressColor: percent < 0.6
                                  //       ? Colors.red
                                  //       : Colors.purple,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       left: 24, right: 24, top: 8, bottom: 16),
                            //   child: Row(
                            //     children: <Widget>[
                            //       Expanded(
                            //         child: Column(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.center,
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //           children: <Widget>[
                            //             Row(
                            //               children: [
                            //                 Text(
                            //                   'Asleep',
                            //                   textAlign: TextAlign.center,
                            //                   style: TextStyle(
                            //                     fontFamily:
                            //                         SleepAppTheme.fontName,
                            //                     fontWeight: FontWeight.w500,
                            //                     fontSize: 22,
                            //                     letterSpacing: -0.1,
                            //                     color: SleepAppTheme.grey
                            //                         .withOpacity(0.5),
                            //                   ),
                            //                 ),
                            //                 // Text(
                            //                 //   'Sleep',
                            //                 //   textAlign: TextAlign.center,
                            //                 //   style: TextStyle(
                            //                 //     fontFamily:
                            //                 //         FitnessAppTheme.fontName,
                            //                 //     fontWeight: FontWeight.w500,
                            //                 //     fontSize: 20,
                            //                 //     letterSpacing: -0.1,
                            //                 //     color: FitnessAppTheme.grey
                            //                 //         .withOpacity(0.5),
                            //                 //   ),
                            //                 // ),
                            //               ],
                            //             ),
                            //             Padding(
                            //               padding:
                            //                   const EdgeInsets.only(top: 4),
                            //               child: Container(
                            //                 height: 4,
                            //                 width: 70,
                            //                 decoration: BoxDecoration(
                            //                   color: HexColor('#87A0E5')
                            //                       .withOpacity(1.0),
                            //                   borderRadius: BorderRadius.all(
                            //                       Radius.circular(4.0)),
                            //                 ),
                            //                 child: Row(
                            //                   children: <Widget>[
                            //                     Container(
                            //                       width: ((70 / 1.2) *
                            //                           widget.animation!.value),
                            //                       height: 4,
                            //                       decoration: BoxDecoration(
                            //                         gradient:
                            //                             LinearGradient(colors: [
                            //                           HexColor('#87A0E5'),
                            //                           HexColor('#87A0E5')
                            //                               .withOpacity(0.5),
                            //                         ]),
                            //                         borderRadius:
                            //                             BorderRadius.all(
                            //                                 Radius.circular(
                            //                                     4.0)),
                            //                       ),
                            //                     )
                            //                   ],
                            //                 ),
                            //               ),
                            //             ),
                            //             Padding(
                            //               padding:
                            //                   const EdgeInsets.only(top: 6),
                            //               child: Text(
                            //                 '7h 24m',
                            //                 textAlign: TextAlign.center,
                            //                 style: TextStyle(
                            //                     fontFamily:
                            //                         SleepAppTheme.fontName,
                            //                     fontWeight: FontWeight.w600,
                            //                     fontSize: 20,
                            //                     color: SleepAppTheme.darkText),
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //       Expanded(
                            //         child: Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.center,
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.center,
                            //           children: <Widget>[
                            //             Column(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.center,
                            //               crossAxisAlignment:
                            //                   CrossAxisAlignment.start,
                            //               children: <Widget>[
                            //                 Text(
                            //                   'Woke up',
                            //                   textAlign: TextAlign.center,
                            //                   style: TextStyle(
                            //                     fontFamily:
                            //                         SleepAppTheme.fontName,
                            //                     fontWeight: FontWeight.w500,
                            //                     fontSize: 22,
                            //                     letterSpacing: -0.1,
                            //                     color: SleepAppTheme.grey
                            //                         .withOpacity(0.5),
                            //                   ),
                            //                 ),
                            //                 Padding(
                            //                   padding:
                            //                       const EdgeInsets.only(top: 4),
                            //                   child: Container(
                            //                     height: 4,
                            //                     width: 70,
                            //                     decoration: BoxDecoration(
                            //                       color: HexColor('#F56E98')
                            //                           .withOpacity(1.0),
                            //                       borderRadius:
                            //                           BorderRadius.all(
                            //                               Radius.circular(4.0)),
                            //                     ),
                            //                     child: Row(
                            //                       children: <Widget>[
                            //                         Container(
                            //                           width: ((70 / 1.2) *
                            //                               widget
                            //                                   .animationController!
                            //                                   .value),
                            //                           height: 4,
                            //                           decoration: BoxDecoration(
                            //                             gradient:
                            //                                 LinearGradient(
                            //                                     colors: [
                            //                                   HexColor(
                            //                                           '#F56E98')
                            //                                       .withOpacity(
                            //                                           0.1),
                            //                                   HexColor(
                            //                                       '#F56E98'),
                            //                                 ]),
                            //                             borderRadius:
                            //                                 BorderRadius.all(
                            //                                     Radius.circular(
                            //                                         4.0)),
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 ),
                            //                 Padding(
                            //                   padding:
                            //                       const EdgeInsets.only(top: 6),
                            //                   child: Text(
                            //                     '07:14 AM',
                            //                     textAlign: TextAlign.center,
                            //                     style: TextStyle(
                            //                         fontFamily:
                            //                             SleepAppTheme.fontName,
                            //                         fontWeight: FontWeight.w600,
                            //                         fontSize: 20,
                            //                         color:
                            //                             SleepAppTheme.darkText),
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //       Expanded(
                            //         child: Row(
                            //           mainAxisAlignment: MainAxisAlignment.end,
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.center,
                            //           children: <Widget>[
                            //             Column(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.center,
                            //               crossAxisAlignment:
                            //                   CrossAxisAlignment.start,
                            //               children: <Widget>[
                            //                 Text(
                            //                   'In bed',
                            //                   textAlign: TextAlign.center,
                            //                   style: TextStyle(
                            //                     fontFamily:
                            //                         SleepAppTheme.fontName,
                            //                     fontWeight: FontWeight.w500,
                            //                     fontSize: 22,
                            //                     letterSpacing: -0.1,
                            //                     color: SleepAppTheme.grey
                            //                         .withOpacity(0.5),
                            //                   ),
                            //                 ),
                            //                 Padding(
                            //                   padding: const EdgeInsets.only(
                            //                       right: 0, top: 4),
                            //                   child: Container(
                            //                     height: 4,
                            //                     width: 70,
                            //                     decoration: BoxDecoration(
                            //                       color: HexColor('#F1B440')
                            //                           .withOpacity(1.0),
                            //                       borderRadius:
                            //                           BorderRadius.all(
                            //                               Radius.circular(4.0)),
                            //                     ),
                            //                     child: Row(
                            //                       children: <Widget>[
                            //                         Container(
                            //                           width: ((70 / 2) *
                            //                               widget
                            //                                   .animationController!
                            //                                   .value),
                            //                           height: 4,
                            //                           decoration: BoxDecoration(
                            //                             gradient:
                            //                                 LinearGradient(
                            //                                     colors: [
                            //                                   HexColor(
                            //                                           '#F1B440')
                            //                                       .withOpacity(
                            //                                           0.1),
                            //                                   HexColor(
                            //                                       '#F1B440'),
                            //                                 ]),
                            //                             borderRadius:
                            //                                 BorderRadius.all(
                            //                                     Radius.circular(
                            //                                         4.0)),
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 ),
                            //                 Padding(
                            //                   padding:
                            //                       const EdgeInsets.only(top: 6),
                            //                   child: Text(
                            //                     '7h 40m',
                            //                     textAlign: TextAlign.center,
                            //                     style: TextStyle(
                            //                         fontFamily:
                            //                             SleepAppTheme.fontName,
                            //                         fontWeight: FontWeight.w600,
                            //                         fontSize: 20,
                            //                         color: SleepAppTheme
                            //                             .darkerText),
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ))));
        });
  }
}

class CurvePainter extends CustomPainter {
  final double? angle;
  final List<Color>? colors;

  CurvePainter({this.colors, this.angle = 140});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = [];
    if (colors != null) {
      colorsList = colors ?? [];
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shdowPaint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final shdowPaintCenter = Offset(size.width / 2, size.height / 2);
    final shdowPaintRadius =
        math.min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(
        Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.3);
    shdowPaint.strokeWidth = 16;
    canvas.drawArc(
        Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.2);
    shdowPaint.strokeWidth = 20;
    canvas.drawArc(
        Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.1);
    shdowPaint.strokeWidth = 22;
    canvas.drawArc(
        Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    final rect = Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = SweepGradient(
      startAngle: degreeToRadians(268),
      endAngle: degreeToRadians(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        paint);

    final gradient1 = SweepGradient(
      tileMode: TileMode.repeated,
      colors: [Colors.white, Colors.white],
    );

    var cPaint = Paint();
    cPaint..shader = gradient1.createShader(rect);
    cPaint..color = Colors.white;
    cPaint..strokeWidth = 14 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadians(angle! + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}
