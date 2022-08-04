// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ptixiaki_sleep_stages/first_screen_widgets/sleep_stages_card.dart';
import 'package:ptixiaki_sleep_stages/widget/appbar_widget.dart';
import '../../helper/db.dart';
import '../first_screen_widgets/day_selector.dart';
import '../first_screen_widgets/meals_list_view.dart';
import '../first_screen_widgets/pie_chart_home.dart';
import '../first_screen_widgets/sleep_view.dart';
import '../first_screen_widgets/title_view.dart';
import '../models/meals_list_data.dart';
import '../models/sleep.dart';
import '../sleep_app_theme.dart';

List<Sleep> homeData = [];

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;
  var dbHelper;
  List<Widget> listViews = <Widget>[];
  List<MealsListData> sleepStages = [];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  var _isLoading = true;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
    dbHelper = DB(); //instance της βάσης

    get();
  }

  void get() async {
    final data = await dbHelper.getHomeInfo(
        //query στην βαση με βαση το τωρινό date για να δούμε τα δεδομένα της τελευταίας εγγραφής
        DateTime(2022, 5, 31, 0, 0, 0, 0,
            0)); //dedomena arxikhw me bash to teleutaio datetime
    setState(() {
      homeData = [...data];
      sleepStages = [
        MealsListData(
          // imagePath: 'assets/sleep_app/breakfast.png',
          titleTxt: 'Deep sleep',
          kacl: getConversion(homeData[0].minutes_deep_sleep!),
          progress: getPercentStage(homeData[0].minutes_deep_sleep!),
          startColor: '#FA7D82',
          endColor: '#FFB295',
        ),
        MealsListData(
          imagePath: 'assets/sleep_app/lunch.png',
          titleTxt: 'Light sleep',
          kacl: getConversion(homeData[0].minutes_light_sleep!),
          progress: getPercentStage(homeData[0].minutes_light_sleep!),
          startColor: '#738AE6',
          endColor: '#5C5EDD',
        ),
        MealsListData(
          imagePath: 'assets/sleep_app/snack.png',
          titleTxt: 'REM sleep',
          kacl: getConversion(homeData[0].minutes_rem_sleep!),
          progress: getPercentStage(homeData[0].minutes_rem_sleep!),
          startColor: '#FE95B6',
          endColor: '#FF5287',
        ),
        MealsListData(
          imagePath: 'assets/sleep_app/dinner.png',
          titleTxt: 'Awake time',
          kacl: homeData[0].awake.toString(),
          progress: (homeData[0].awake! / homeData[0].asleep_min!),
          startColor: '#6F72CA',
          endColor: '#1E1466',
        )
      ];
      print(homeData.length);
      addAllListData();
      _isLoading = false;
    });
  }

  void addAllListData() {
    const int count = 8;

    listViews.add(DaySelector(onApplyClick: (List<Sleep> data) {
      setState(() {
        homeData = [];
        sleepStages = [];
        homeData = [...data];
        listViews = [];
        sleepStages = [
          MealsListData(
            // imagePath: 'assets/sleep_app/breakfast.png',
            titleTxt: 'Deep sleep',
            kacl: getConversion(homeData[0].minutes_deep_sleep!),
            progress: getPercentStage(homeData[0].minutes_deep_sleep!),
            startColor: '#FA7D82',
            endColor: '#FFB295',
          ),
          MealsListData(
            imagePath: 'assets/sleep_app/lunch.png',
            titleTxt: 'Light sleep',
            kacl: getConversion(homeData[0].minutes_light_sleep!),
            progress: getPercentStage(homeData[0].minutes_light_sleep!),
            startColor: '#738AE6',
            endColor: '#5C5EDD',
          ),
          MealsListData(
            imagePath: 'assets/sleep_app/snack.png',
            titleTxt: 'REM sleep',
            kacl: getConversion(homeData[0].minutes_rem_sleep!),
            progress: getPercentStage(homeData[0].minutes_rem_sleep!),
            startColor: '#FE95B6',
            endColor: '#FF5287',
          ),
          MealsListData(
            imagePath: 'assets/sleep_app/dinner.png',
            titleTxt: 'Awake time',
            kacl: homeData[0].awake.toString(),
            progress: (homeData[0].awake! / homeData[0].asleep_min!),
            startColor: '#6F72CA',
            endColor: '#1E1466',
          )
        ];
        addAllListData();
      });
    }));

    listViews.add(
      TitleView(
        titleTxt: 'Sleep Information',
        subTxt: 'Details',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      SleepView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: 'Sleep Stages',
        subTxt: 'Details',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      MealsListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: Interval((1 / count) * 3, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
        mealsListData: sleepStages,
      ),
    );

    // listViews.add(
    //   SleepStagesCard(
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //         parent: widget.animationController!,
    //         curve:
    //             Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
    //     animationController: widget.animationController!,
    //   ),
    // );
    // listViews.add(SizedBox(
    //   height: 10.0,
    // ));
    // listViews.add(CardStaggered(
    //   animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //       parent: widget.animationController!,
    //       curve: Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
    //   animationController: widget.animationController!,
    // ));
    // listViews.add(ActivityPieChart());
    // listViews.add(BedTimeChart());
    // listViews.add(SecondSleep());
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SleepAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            _isLoading ? Text('No Data') : getMainListViewUI(),
            AppBarWidget(
              animationController: widget.animationController,
              topBarAnimation: topBarAnimation,
              topBarOpacity: topBarOpacity,
              firstText: 'Welcome',
              secondText: 'Today',
              currentPage: 1,
              onTap: () async {},
            ),
            // getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(top: 100, bottom: 50
                // top: AppBar().preferredSize.height +
                //     MediaQuery.of(context).padding.top +
                //     24,
                // bottom: 62 + MediaQuery.of(context).padding.bottom,
                ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }
}

//   Widget getAppBarUI() {
//     return Column(
//       children: <Widget>[
//         AnimatedBuilder(
//           animation: widget.animationController!,
//           builder: (BuildContext context, Widget? child) {
//             return FadeTransition(
//               opacity: topBarAnimation!,
//               child: Transform(
//                 transform: Matrix4.translationValues(
//                     0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: SleepAppTheme.white.withOpacity(topBarOpacity),
//                     borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(32.0),
//                       bottomRight: Radius.circular(32.0),
//                     ),
//                     boxShadow: <BoxShadow>[
//                       BoxShadow(
//                           color: SleepAppTheme.grey
//                               .withOpacity(0.4 * topBarOpacity),
//                           offset: const Offset(1.1, 1.1),
//                           blurRadius: 10.0),
//                     ],
//                   ),
//                   child: Column(
//                     children: <Widget>[
//                       SizedBox(
//                         height: MediaQuery.of(context).padding.top,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             left: 16,
//                             right: 16,
//                             top: 16 - 8.0 * topBarOpacity,
//                             bottom: 12 - 8.0 * topBarOpacity),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Hey, Ellen',
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                         fontFamily: SleepAppTheme.fontName,
//                                         fontWeight: FontWeight.w700,
//                                         fontSize: 22 + 6 - 6 * topBarOpacity,
//                                         letterSpacing: 1.2,
//                                         color: SleepAppTheme.darkerText,
//                                       ),
//                                     ),
//                                     Text(
//                                       'Today',
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                         fontFamily: SleepAppTheme.fontName,
//                                         fontWeight: FontWeight.w700,
//                                         fontSize: 22 + 6 - 6 * topBarOpacity,
//                                         letterSpacing: 1.2,
//                                         color: SleepAppTheme.darkerText,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 print('Tapped');
//                               },
//                               child: Container(
//                                 width: 60,
//                                 height: 60,
//                                 child:
//                                     Image.asset('assets/fitness_app/man.png'),
//                               ),
//                             )
//                             // SizedBox(
//                             //   height: 38,
//                             //   width: 38,
//                             //   child: InkWell(
//                             //     highlightColor: Colors.transparent,
//                             //     borderRadius: const BorderRadius.all(
//                             //         Radius.circular(32.0)),
//                             //     onTap: () {},
//                             //     child: Center(
//                             //       child: Icon(
//                             //         Icons.keyboard_arrow_left,
//                             //         color: FitnessAppTheme.grey,
//                             //       ),
//                             //     ),
//                             //   ),
//                             // ),
//                             // Padding(
//                             //   padding: const EdgeInsets.only(
//                             //     left: 8,
//                             //     right: 8,
//                             //   ),
//                             //   child: Row(
//                             //     children: <Widget>[
//                             //       Padding(
//                             //         padding: const EdgeInsets.only(right: 8),
//                             //         child: Icon(
//                             //           Icons.calendar_today,
//                             //           color: FitnessAppTheme.grey,
//                             //           size: 18,
//                             //         ),
//                             //       ),
//                             //       Text(
//                             //         '15 May',
//                             //         textAlign: TextAlign.left,
//                             //         style: TextStyle(
//                             //           fontFamily: FitnessAppTheme.fontName,
//                             //           fontWeight: FontWeight.normal,
//                             //           fontSize: 18,
//                             //           letterSpacing: -0.2,
//                             //           color: FitnessAppTheme.darkerText,
//                             //         ),
//                             //       ),
//                             //     ],
//                             //   ),
//                             // ),
//                             // SizedBox(
//                             //   height: 38,
//                             //   width: 38,
//                             //   child: InkWell(
//                             //     highlightColor: Colors.transparent,
//                             //     borderRadius: const BorderRadius.all(
//                             //         Radius.circular(32.0)),
//                             //     onTap: () {},
//                             //     child: Center(
//                             //       child: Icon(
//                             //         Icons.keyboard_arrow_right,
//                             //         color: FitnessAppTheme.grey,
//                             //       ),
//                             //     ),
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         )
//       ],
//     );
//   }
// }

String getConversion(double total_asleep) {
  double current = (total_asleep) / 60;
  int hours = current.toInt();
  double minutes = total_asleep % 60;
  String finalText = '${hours}h' + ' ${minutes.toInt()}m';
  return finalText;
}

double getPercentStage(double stage) {
  return (stage / homeData[0].asleep_min!);
}
