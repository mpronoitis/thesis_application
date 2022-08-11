// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ptixiaki_sleep_stages/models/sleep_stages_list_data.dart';
import 'package:ptixiaki_sleep_stages/sleep_app_theme.dart';
import '../../main.dart';
import '../models/sleep_stages_list_data.dart';

class SleepStagesView extends StatefulWidget {
  const SleepStagesView(
      {Key? key,
      this.mainScreenAnimationController,
      this.mainScreenAnimation,
      required this.sleepStagesListData})
      : super(key: key);
//αρχικοποιήσεις παραμέτρων που δέχεται ο constructor
  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  final List<SleepStagesData> sleepStagesListData;
  @override
  _SleepStagesViewState createState() => _SleepStagesViewState();
}

class _SleepStagesViewState extends State<SleepStagesView>
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
      //χρήση animatedBuilder για το animation των καρτών sleep stages
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

                  return SleepStages(
                    //widget κάρτας sleep stage σε καθένα απο τα οποίο περνάμε τις κατάλληλες παραμέτρους
                    sleepstagesdata: widget.sleepStagesListData[index],
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

class SleepStages extends StatelessWidget {
  //widget κάρτας sleep stage
  const SleepStages(
      {Key? key,
      this.sleepstagesdata,
      this.animationController,
      this.animation})
      : super(key: key);
//αρχικοποίηση παραμέτρων που δέχεται
  final SleepStagesData? sleepstagesdata;
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
                      decoration: BoxDecoration(
                        color: SleepAppTheme.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: HexColor(sleepstagesdata!.endColor!)
                                  .withOpacity(0.6),
                              offset: const Offset(1.1, 4.0),
                              blurRadius: 8.0),
                        ],
                        gradient: LinearGradient(
                          //προσθήκη gradient χρώματος
                          colors: <HexColor>[
                            HexColor(sleepstagesdata!.startColor!),
                            HexColor(sleepstagesdata!.endColor!),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          //radius κάρτας
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
                              sleepstagesdata!.titleTxt!,
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
                                      percent: sleepstagesdata!.progress!,
                                      center: Text(
                                        ((sleepstagesdata!.progress! * 100)
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
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: 0.4 < 0.6
                                          ? Colors.purpleAccent
                                          : Colors.purpleAccent,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  sleepstagesdata!.kacl!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: SleepAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    letterSpacing: 0.2,
                                    color: SleepAppTheme.grey,
                                  ),
                                ),
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
