// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ptixiaki_sleep_stages/first_screen_widgets/meals_list_view.dart';
import 'package:ptixiaki_sleep_stages/first_screen_widgets/meals_list_view.dart';
import 'package:ptixiaki_sleep_stages/models/meals_list_data.dart';
import 'package:ptixiaki_sleep_stages/sleep_app_theme.dart';

import '../../main.dart';
import '../models/meals_list_data.dart';
import '../screens/first_screen.dart';
import 'meals_list_view.dart';

class MealsListView extends StatefulWidget {
  const MealsListView(
      {Key? key,
      this.mainScreenAnimationController,
      this.mainScreenAnimation,
      required this.mealsListData})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  final List<MealsListData> mealsListData;
  @override
  _MealsListViewState createState() => _MealsListViewState();
}

class _MealsListViewState extends State<MealsListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: Container(
              height: 216,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count = 4 > 10 ? 10 : 4;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();

                  return MealsView(
                    mealsListData: widget.mealsListData[index],
                    animation: animation,
                    animationController: animationController!,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class MealsView extends StatelessWidget {
  const MealsView(
      {Key? key, this.mealsListData, this.animationController, this.animation})
      : super(key: key);

  final MealsListData? mealsListData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: SizedBox(
              width: 130,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5, left: 8, right: 8, bottom: 1),
                    child: Container(
                      // decoration: BoxDecoration(
                      //   // gradient: LinearGradient(colors: [
                      //   //   Color(0xff0f17ad).withOpacity(0.8),
                      //   //   Color(0xFF6985e8).withOpacity(0.9)
                      //   // ]),
                      //   color: SleepAppTheme.white,
                      //   borderRadius: const BorderRadius.only(
                      //       topLeft: Radius.circular(8.0),
                      //       bottomLeft: Radius.circular(8.0),
                      //       bottomRight: Radius.circular(8.0),
                      //       topRight: Radius.circular(54.0)),
                      //   boxShadow: <BoxShadow>[
                      //     //colorLor
                      //     BoxShadow(
                      //         color: SleepAppTheme.grey.withOpacity(0.2),
                      //         offset: Offset(1.1, 1.1),
                      //         blurRadius: 10.0),
                      //   ],
                      // ),
                      decoration: BoxDecoration(
                        color: SleepAppTheme.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: HexColor(mealsListData!.endColor!)
                                  .withOpacity(0.6),
                              offset: const Offset(1.1, 4.0),
                              blurRadius: 8.0),
                        ],
                        gradient: LinearGradient(
                          colors: <HexColor>[
                            HexColor(mealsListData!.startColor!),
                            HexColor(mealsListData!.endColor!),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(54.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 16, right: 16, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              mealsListData!.titleTxt!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: SleepAppTheme.fontName,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                letterSpacing: 0.2,
                                color: SleepAppTheme.grey,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    CircularPercentIndicator(
                                      radius: 80.0,
                                      lineWidth: 13.0,
                                      animation: true,
                                      percent: mealsListData!.progress!,
                                      center: Text(
                                        ((mealsListData!.progress! * 100)
                                                    .toInt())
                                                .toString() +
                                            '${'%'}',
                                        style: TextStyle(
                                          fontFamily: SleepAppTheme.fontName,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
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
                                      //     color: SleepAppTheme.grey
                                      //         .withOpacity(0.5),
                                      //   ),
                                      // ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: 0.4 < 0.6
                                          ? Colors.purpleAccent
                                          : Colors.purpleAccent,
                                    ),
                                    // Text(
                                    //   mealsListData!.meals!.join('\n'),
                                    //   style: TextStyle(
                                    //     fontFamily: SleepAppTheme.fontName,
                                    //     fontWeight: FontWeight.w500,
                                    //     fontSize: 10,
                                    //     letterSpacing: 0.2,
                                    //     color: SleepAppTheme.white,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  mealsListData!.kacl!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: SleepAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    letterSpacing: 0.2,
                                    color: SleepAppTheme.grey,
                                  ),
                                ),
                                // Padding(
                                //   padding:
                                //       const EdgeInsets.only(left: 4, bottom: 3),
                                //   child: Text(
                                //     'kcal',
                                //     style: TextStyle(
                                //       fontFamily: SleepAppTheme.fontName,
                                //       fontWeight: FontWeight.w500,
                                //       fontSize: 10,
                                //       letterSpacing: 0.2,
                                //       color: SleepAppTheme.white,
                                //     ),
                                //   ),
                                // ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: SleepAppTheme.nearlyWhite.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: 0,
                  //   left: 8,
                  //   child: SizedBox(
                  //     width: 80,
                  //     height: 80,
                  //     child: Image.asset(mealsListData!.imagePath),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
