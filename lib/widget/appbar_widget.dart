// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../sleep_app_theme.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget(
      {Key? key,
      required this.animationController,
      required this.topBarAnimation,
      required this.topBarOpacity,
      required this.firstText,
      required this.secondText,
      required this.currentPage,
      this.onTap,
      this.startDate,
      this.endDate})
      : super(key: key);
  final AnimationController? animationController;
  final Animation<double>? topBarAnimation;
  final double topBarOpacity;
  final String firstText;
  final String secondText;
  final int currentPage;
  final Function()? onTap;
  final DateTime? startDate;
  final DateTime? endDate;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: widget.topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - widget.topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        SleepAppTheme.white.withOpacity(widget.topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                      bottomRight: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: SleepAppTheme.grey
                              .withOpacity(0.4 * widget.topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      // SizedBox(
                      //   height: MediaQuery.of(context).padding.top,
                      // ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 16 - 8.0 * widget.topBarOpacity,
                              bottom: 12 - 8.0 * widget.topBarOpacity),
                          child: widget.currentPage == 1
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.firstText,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontFamily:
                                                    SleepAppTheme.fontName,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 22 +
                                                    6 -
                                                    6 * widget.topBarOpacity,
                                                letterSpacing: 1.2,
                                                color: SleepAppTheme.darkerText,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              widget.secondText,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontFamily:
                                                    SleepAppTheme.fontName,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 22 +
                                                    6 -
                                                    6 * widget.topBarOpacity,
                                                letterSpacing: 1.2,
                                                color: SleepAppTheme.darkerText,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print('Tapped');
                                      },
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        child: Image.asset(
                                            'assets/sleep_app/man.png'),
                                      ),
                                    )
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.firstText,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontFamily:
                                                    SleepAppTheme.fontName,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 22 +
                                                    6 -
                                                    6 * widget.topBarOpacity,
                                                letterSpacing: 1.2,
                                                color: SleepAppTheme.darkerText,
                                              ),
                                            ),
                                            Text(
                                              widget.secondText,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontFamily:
                                                    SleepAppTheme.fontName,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 22 +
                                                    6 -
                                                    6 * widget.topBarOpacity,
                                                letterSpacing: 1.2,
                                                color: SleepAppTheme.darkerText,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 38,
                                      width: 38,
                                      child: InkWell(
                                        highlightColor: Colors.transparent,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(32.0)),
                                        onTap: widget.onTap,
                                        child: Center(
                                          child: Icon(
                                            Icons.keyboard_arrow_left,
                                            color: SleepAppTheme.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                          left: 0,
                                          right: 0,
                                        ),
                                        child: widget.currentPage == 2
                                            ? Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: InkWell(
                                                      onTap: widget.onTap,
                                                      child: Icon(
                                                        Icons.calendar_today,
                                                        color:
                                                            SleepAppTheme.grey,
                                                        size: 22,
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: widget.onTap,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          DateFormat.MMMd()
                                                              .format(widget
                                                                  .endDate!),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                SleepAppTheme
                                                                    .fontName,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 18,
                                                            letterSpacing: -0.2,
                                                            color: SleepAppTheme
                                                                .darkerText,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            : GestureDetector(
                                                onTap: widget.onTap,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8),
                                                      child: InkWell(
                                                        onTap: widget.onTap,
                                                        child: Icon(
                                                          Icons.calendar_today,
                                                          color: SleepAppTheme
                                                              .grey,
                                                          size: 22,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      DateFormat.d().format(
                                                              widget
                                                                  .startDate!) +
                                                          ' ' +
                                                          DateFormat.MMM()
                                                              .format(widget
                                                                  .startDate!) +
                                                          ' - ',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            SleepAppTheme
                                                                .fontName,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 18,
                                                        letterSpacing: -0.2,
                                                        color: SleepAppTheme
                                                            .darkerText,
                                                      ),
                                                    ),
                                                    Text(
                                                      DateFormat.d().format(
                                                              widget.endDate!) +
                                                          ' ',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            SleepAppTheme
                                                                .fontName,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 18,
                                                        letterSpacing: -0.2,
                                                        color: SleepAppTheme
                                                            .darkerText,
                                                      ),
                                                    ),
                                                    Text(
                                                      DateFormat.MMMM().format(
                                                          widget.endDate!),
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            SleepAppTheme
                                                                .fontName,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 18,
                                                        letterSpacing: -0.2,
                                                        color: SleepAppTheme
                                                            .darkerText,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                    SizedBox(
                                      height: 38,
                                      width: 38,
                                      child: InkWell(
                                        highlightColor: Colors.transparent,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(32.0)),
                                        onTap: widget.onTap,
                                        child: Center(
                                          child: Icon(
                                            Icons.keyboard_arrow_right,
                                            color: SleepAppTheme.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
