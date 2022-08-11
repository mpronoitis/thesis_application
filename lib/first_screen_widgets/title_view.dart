// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../sleep_app_theme.dart';

//widget για την δημιουργία τίτλου πάνω απο την κάρτα της αρχικής οθόνης
class TitleView extends StatelessWidget {
  //constructor
  final String titleTxt;
  final String subTxt;
  final AnimationController? animationController;
  final Animation<double>? animation;

  const TitleView(
      {Key? key,
      this.titleTxt: "",
      this.subTxt: "",
      this.animationController,
      this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      //AnimatedBuilder για υποστήριξη animation
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          //τύπος animation
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        titleTxt,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: SleepAppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          letterSpacing: 0.5,
                          color: SleepAppTheme.lightText,
                        ),
                      ),
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      onTap: () async {},
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              subTxt,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: SleepAppTheme.fontName,
                                fontWeight: FontWeight.normal,
                                fontSize: 22,
                                letterSpacing: 0.5,
                                color: SleepAppTheme.nearlyDarkBlue,
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 26,
                              child: Icon(
                                Icons.arrow_forward,
                                color: SleepAppTheme.darkText,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
