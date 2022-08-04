// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../helper/db.dart';
import '../main.dart';

import '../models/sleep.dart';
import '../sleep_app_theme.dart';
import 'custom_calendar.dart';

class CalendarPopupView extends StatefulWidget {
  const CalendarPopupView(
      {Key? key,
      this.initialStartDate,
      this.initialEndDate,
      this.onApplyClick,
      this.onCancelClick,
      this.barrierDismissible = true,
      this.minimumDate,
      this.maximumDate,
      this.getInfo,
      required this.typeOfChart})
      : super(key: key);

  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final bool barrierDismissible;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final Function(DateTime, DateTime, BuildContext context)? onApplyClick;
  final Function(DateTime, DateTime)? getInfo;
  final int typeOfChart;

  final Function()? onCancelClick;
  @override
  _CalendarPopupViewState createState() => _CalendarPopupViewState();
}

class _CalendarPopupViewState extends State<CalendarPopupView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  DateTime? startDate;
  DateTime? endDate;
  bool isActive = false;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    if (widget.initialStartDate != null) {
      startDate = widget.initialStartDate;
    }
    if (widget.initialEndDate != null) {
      endDate = widget.initialEndDate;
    }
    animationController?.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimatedBuilder(
          animation: animationController!,
          builder: (BuildContext context, Widget? child) {
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: animationController!.value,
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  if (widget.barrierDismissible) {
                    Navigator.pop(context);
                  }
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: SleepAppTheme.background,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              offset: const Offset(4, 4),
                              blurRadius: 8.0),
                        ],
                      ),
                      child: InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24.0)),
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'From',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: SleepAppTheme.grey
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        startDate != null
                                            ? DateFormat('EEE, dd MMM')
                                                .format(startDate!)
                                            : '--/-- ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    height: 74,
                                    width: 1,
                                    color: SleepAppTheme.grey),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'To',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: SleepAppTheme.grey
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        endDate != null
                                            ? DateFormat('EEE, dd MMM')
                                                .format(endDate!)
                                            : '--/-- ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const Divider(
                              height: 1,
                            ),
                            CustomCalendarView(
                              minimumDate: widget.minimumDate,
                              maximumDate: widget.maximumDate,
                              initialEndDate: widget.initialEndDate,
                              initialStartDate: widget.initialStartDate,
                              tryingMethod: (bool x) {
                                setState(() {
                                  isActive = x;
                                });
                              },
                              startEndDateChange: (DateTime startDateData,
                                  DateTime endDateData) {
                                print('prits');
                                if (widget.typeOfChart == 1) {
                                  if (endDateData
                                          .difference(startDateData)
                                          .inDays ==
                                      1) {
                                    setState(() {
                                      startDate = startDateData;
                                      endDate = endDateData;
                                      isActive = true;
                                    });
                                  } else {
                                    setState(() {
                                      startDate = startDateData;
                                      endDate = endDateData;
                                      isActive = false;
                                    });
                                  }
                                }
                                if (widget.typeOfChart == 2) {
                                  if (endDateData
                                          .difference(startDateData)
                                          .inDays ==
                                      6) {
                                    setState(() {
                                      startDate = startDateData;
                                      endDate = endDateData;
                                      isActive = true;
                                    });
                                  } else {
                                    setState(() {
                                      startDate = startDateData;
                                      endDate = endDateData;
                                      isActive = false;
                                    });
                                  }
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 16, top: 8),
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: !isActive
                                      ? HexColor('#DCF6F2')
                                      : HexColor('#54d3c2'),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(24.0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      blurRadius: 8,
                                      offset: const Offset(4, 4),
                                    ),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(24.0)),
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      // animationController.reverse().then((f) {

                                      // });
                                      if (widget.typeOfChart == 2) {
                                        if (startDate != null &&
                                            endDate != null) {
                                          widget.onApplyClick!(
                                              startDate!, endDate!, context);
                                        } else {
                                          Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'You have to choose seven days. For example, if you want to see your sleep data for the second week of May, you must choose May 9 as first day and May 15 as last day.'),
                                              duration: Duration(seconds: 10),
                                            ),
                                          );
                                        }
                                      } else if (widget.typeOfChart == 1) {
                                        if (startDate != null &&
                                            endDate != null) {
                                          widget.onApplyClick!(
                                              startDate!, endDate!, context);
                                        } else {
                                          Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'You have to choose two days. For example, if you want to see your sleep data for May 7, you must select the night of May 6 as the first day and the day of your choice as the last.'),
                                              duration: Duration(seconds: 10),
                                            ),
                                          );
                                        }
                                      } else if (widget.typeOfChart == 3) {
                                        widget.onApplyClick!(
                                            startDate!, endDate!, context);
                                      }
                                    },
                                    child: Center(
                                      child: Text(
                                        'Apply',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
