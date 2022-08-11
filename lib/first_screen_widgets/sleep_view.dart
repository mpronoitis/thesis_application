// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../main.dart';
import '../models/sleep.dart';
import '../screens/first_screen.dart';
import '../sleep_app_theme.dart';
import 'package:percent_indicator/percent_indicator.dart';

//Widget που περιγράφει την δομή της κεντρικής κάρτας
class SleepView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  SleepView({
    Key? key,
    this.animationController,
    this.animation,
  }) : super(key: key);

  @override
  State<SleepView> createState() => _SleepViewState();
}

class _SleepViewState extends State<SleepView> {
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
                          //σχηματισμός κάρτας
                          color: SleepAppTheme.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              bottomLeft: Radius.circular(8.0),
                              bottomRight: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                          boxShadow: <BoxShadow>[
                            //shadow κάρτας
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
                                                        'Went to bed ',
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
                                                            homeData[0]
                                                                .went_to_bed!,
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
                                                        'Asleep after',
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
                                                            ((homeData[0]
                                                                        .asleep_after!)
                                                                    .toInt())
                                                                .toString(),
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
                                  Padding(
                                    padding: EdgeInsets.only(right: 15.0),
                                    child: CircularPercentIndicator(
                                      radius: 120.0,
                                      lineWidth: 13.0,
                                      animation: true,
                                      percent: homeData[0].sleep_score,
                                      center: Text(
                                        ((homeData[0].sleep_score * 100)
                                                    .toInt())
                                                .toString() +
                                            '${'%'}',
                                        style: TextStyle(
                                          fontFamily: SleepAppTheme.fontName,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                          letterSpacing: 0.0,
                                          color: SleepAppTheme.darkText,
                                        ),
                                      ),
                                      footer: Text(
                                        "Sleep Score",
                                        style: TextStyle(
                                          fontFamily: SleepAppTheme.fontName,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          letterSpacing: 0.0,
                                          color: SleepAppTheme.grey
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: percent < 0.6
                                          ? Colors.red
                                          : Colors.purple,
                                    ),
                                  ),
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
                                              'Asleep',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    SleepAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 22,
                                                letterSpacing: -0.1,
                                                color: SleepAppTheme.grey
                                                    .withOpacity(0.5),
                                              ),
                                            ),
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
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4.0)),
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  width: ((70 / 1.2) *
                                                      widget.animation!.value),
                                                  height: 4,
                                                  decoration: BoxDecoration(
                                                    gradient:
                                                        LinearGradient(colors: [
                                                      HexColor('#87A0E5'),
                                                      HexColor('#87A0E5')
                                                          .withOpacity(0.5),
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
                                            getConversion(
                                                homeData[0].asleep_min!),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily:
                                                    SleepAppTheme.fontName,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20,
                                                color: SleepAppTheme.darkText),
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
                                              'Woke up',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    SleepAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 22,
                                                letterSpacing: -0.1,
                                                color: SleepAppTheme.grey
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Container(
                                                height: 4,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  color: HexColor('#F56E98')
                                                      .withOpacity(1.0),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4.0)),
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      width: ((70 / 1.2) *
                                                          widget
                                                              .animationController!
                                                              .value),
                                                      height: 4,
                                                      decoration: BoxDecoration(
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
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    4.0)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 6),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    homeData[0].woke_up!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            SleepAppTheme
                                                                .fontName,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20,
                                                        color: SleepAppTheme
                                                            .darkText),
                                                  ),
                                                  Text(
                                                    ' AM',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            SleepAppTheme
                                                                .fontName,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20,
                                                        color: SleepAppTheme
                                                            .darkText),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                                              'In bed',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    SleepAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 22,
                                                letterSpacing: -0.1,
                                                color: SleepAppTheme.grey
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0, top: 4),
                                              child: Container(
                                                height: 4,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  color: HexColor('#F1B440')
                                                      .withOpacity(1.0),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4.0)),
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      width: ((70 / 2) *
                                                          widget
                                                              .animationController!
                                                              .value),
                                                      height: 4,
                                                      decoration: BoxDecoration(
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
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    4.0)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 6),
                                              child: Text(
                                                homeData[0].in_bed!,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily:
                                                        SleepAppTheme.fontName,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
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
        });
  }
}

String getConversion(double total_asleep) {
  double current = (total_asleep) / 60;
  int hours = current.toInt();
  double minutes = total_asleep % 60;
  String finalText = '${hours}h' + ' ${minutes.toInt()}m';
  return finalText;
}
