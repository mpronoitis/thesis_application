// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ptixiaki_sleep_stages/widget/appbar_widget.dart';

import '../../helper/db.dart';
import '../../statistics_today/date_view_widget.dart';
import '../../statistics_today/linear_stages.dart';
import '../../statistics_today/sleep_score_progress.dart';
import '../../widget/calendar_popup_view.dart';
import '../models/sleep.dart';
import '../sleep_app_theme.dart';

List<Sleep> tryingDay = [];

class StatisticsPage extends StatefulWidget {
  final AnimationController? animationController;
  const StatisticsPage({Key? key, this.animationController}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

List<Sleep> sleepStatistics = [];

class _StatisticsPageState extends State<StatisticsPage>
    with TickerProviderStateMixin {
  // var dbHelper;
  // CategoryType categoryType = CategoryType.ui;

  Animation<double>? topBarAnimation;
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  int _currentIndex = 0;
  final screens = [];
  var _isLoading = true;
  // DateTime startDate = DateTime.now();
  // DateTime endDate = DateTime.now().add(const Duration(days: 2));
  DateTime startDate = DateTime(2022, 5, 31, 0, 0, 0, 0, 0);
  DateTime endDate = DateTime(2022, 5, 31, 0, 0, 0, 0, 0);

  void addAllWidget() {
    listViews.add(DateView());
    listViews.add(SleepScoreProgress());
    listViews.add(LinearStages());
  }

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
    getSleepDataByDay();
  }

  void getSleepDataByDay() async {
    final data = await DB().getHomeInfo(DateTime(
        2022, 5, 31, 0, 0, 0, 0, 0)); //dedomena me bash thn twrinh hmeromhnia
    // final data = await dbHelper.getRecordingByDay();
    setState(() {
      sleepStatistics = [...data];
      _isLoading = false;
      addAllWidget();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SleepAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            _isLoading
                ? Text('NoData')
                : ListView.builder(
                    controller: scrollController,
                    padding: EdgeInsets.only(top: 120, bottom: 50
                        // top: AppBar().preferredSize.height +
                        //     MediaQuery.of(context).padding.top +
                        //     24,
                        // bottom: 62 + MediaQuery.of(context).padding.bottom,
                        ),
                    itemCount: listViews.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return listViews[index];
                    },
                  ),
            // getAppBarUI(),
            AppBarWidget(
                animationController: widget.animationController,
                topBarAnimation: topBarAnimation,
                topBarOpacity: topBarOpacity,
                firstText: 'Day',
                secondText: 'Statistics',
                currentPage: 2,
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());

                  showDemoDialog(context: context);
                },
                startDate: startDate,
                endDate: endDate),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }

  void showDemoDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        // minimumDate: DateTime(2022, 4, 1),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        // initialEndDate: DateTime(2022, 4, 13),
        // initialStartDate: DateTime(2022, 4, 13),
        onApplyClick: (DateTime startData, DateTime endData,
            BuildContext newContext) async {
          final current = endData.difference(startData).inDays;
          if (current == 1) {
            tryingDay = [];
            tryingDay = await DB().getHomeInfo(endData);
          }

          setState(() {
            final current = endData.difference(startData).inDays;
            if (current == 1) {
              startDate = startData;
              endDate = endData;

              sleepStatistics = [];
              sleepStatistics = [...tryingDay];
              listViews = [];
              addAllWidget();
              Navigator.pop(context);
            } else {
              Scaffold.of(newContext).showSnackBar(
                SnackBar(
                  content: Text(
                      'You have to choose two days. For example, if you want to see your sleep data for May 7, you must select the night of May 6 as the first day and the day of your choice as the last.'),
                  duration: Duration(seconds: 10),
                ),
              );
            }
          });
        },
        onCancelClick: () {},
        typeOfChart: 1,
        getInfo: (DateTime startDate, DateTime endDate) {
          print('theStart' + startDate.toString());
          print('theEnd' + endDate.toString());
        },
      ),
    );
  }
}

  // Widget getAppBarUI() {
  //   return Column(
  //     children: <Widget>[
  //       AnimatedBuilder(
  //         animation: widget.animationController!,
  //         builder: (BuildContext context, Widget? child) {
  //           return FadeTransition(
  //             opacity: topBarAnimation!,
  //             child: Transform(
  //               transform: Matrix4.translationValues(
  //                   0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                   color: SleepAppTheme.white.withOpacity(topBarOpacity),
  //                   borderRadius: const BorderRadius.only(
  //                     bottomLeft: Radius.circular(32.0),
  //                     bottomRight: Radius.circular(32.0),
  //                   ),
  //                   boxShadow: <BoxShadow>[
  //                     BoxShadow(
  //                         color: SleepAppTheme.grey
  //                             .withOpacity(0.4 * topBarOpacity),
  //                         offset: const Offset(1.1, 1.1),
  //                         blurRadius: 10.0),
  //                   ],
  //                 ),
  //                 child: Column(
  //                   children: <Widget>[
  //                     SizedBox(
  //                       height: MediaQuery.of(context).padding.top,
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.only(
  //                           left: 16,
  //                           right: 16,
  //                           top: 16 - 8.0 * topBarOpacity,
  //                           bottom: 12 - 8.0 * topBarOpacity),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: <Widget>[
  //                           Expanded(
  //                             child: Padding(
  //                               padding: const EdgeInsets.all(8.0),
  //                               child: Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   Text(
  //                                     'Day',
  //                                     textAlign: TextAlign.left,
  //                                     style: TextStyle(
  //                                       fontFamily: SleepAppTheme.fontName,
  //                                       fontWeight: FontWeight.w700,
  //                                       fontSize: 22 + 6 - 6 * topBarOpacity,
  //                                       letterSpacing: 1.2,
  //                                       color: SleepAppTheme.darkerText,
  //                                     ),
  //                                   ),
  //                                   Text(
  //                                     'Statistics',
  //                                     textAlign: TextAlign.left,
  //                                     style: TextStyle(
  //                                       fontFamily: SleepAppTheme.fontName,
  //                                       fontWeight: FontWeight.w700,
  //                                       fontSize: 22 + 6 - 6 * topBarOpacity,
  //                                       letterSpacing: 1.2,
  //                                       color: SleepAppTheme.darkerText,
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             height: 38,
  //                             width: 38,
  //                             child: InkWell(
  //                               highlightColor: Colors.transparent,
  //                               borderRadius: const BorderRadius.all(
  //                                   Radius.circular(32.0)),
  //                               onTap: () {},
  //                               child: Center(
  //                                 child: Icon(
  //                                   Icons.keyboard_arrow_left,
  //                                   color: SleepAppTheme.grey,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: const EdgeInsets.only(
  //                               left: 8,
  //                               right: 8,
  //                             ),
  //                             child: Row(
  //                               children: <Widget>[
  //                                 Padding(
  //                                   padding: const EdgeInsets.only(right: 8),
  //                                   child: InkWell(
  //                                     onTap: () async {
  //                                       FocusScope.of(context)
  //                                           .requestFocus(FocusNode());

  //                                       showDemoDialog(context: context);
  //                                     },
  //                                     child: Icon(
  //                                       Icons.calendar_today,
  //                                       color: SleepAppTheme.grey,
  //                                       size: 22,
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Text(
  //                                   DateFormat.MMMd().format(startDate),
  //                                   textAlign: TextAlign.left,
  //                                   style: TextStyle(
  //                                     fontFamily: SleepAppTheme.fontName,
  //                                     fontWeight: FontWeight.normal,
  //                                     fontSize: 18,
  //                                     letterSpacing: -0.2,
  //                                     color: SleepAppTheme.darkerText,
  //                                   ),
  //                                 ),
  //                                 // Text(
  //                                 //   DateFormat.MMMd().format(DateTime.parse(
  //                                 //       sleepData[0].recording_day)),
  //                                 //   textAlign: TextAlign.left,
  //                                 //   style: TextStyle(
  //                                 //     fontFamily: SleepAppTheme.fontName,
  //                                 //     fontWeight: FontWeight.normal,
  //                                 //     fontSize: 18,
  //                                 //     letterSpacing: -0.2,
  //                                 //     color: SleepAppTheme.darkerText,
  //                                 //   ),
  //                                 // ),
  //                               ],
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             height: 38,
  //                             width: 38,
  //                             child: InkWell(
  //                               highlightColor: Colors.transparent,
  //                               borderRadius: const BorderRadius.all(
  //                                   Radius.circular(32.0)),
  //                               onTap: () {},
  //                               child: Center(
  //                                 child: Icon(
  //                                   Icons.keyboard_arrow_right,
  //                                   color: SleepAppTheme.grey,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       )
  //     ],
  //   );
  // }




//   Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
//     String txt = '';
//     if (CategoryType.ui == categoryTypeData) {
//       txt = 'Ui/Ux';
//     } else if (CategoryType.coding == categoryTypeData) {
//       txt = 'Coding';
//     } else if (CategoryType.basic == categoryTypeData) {
//       txt = 'Basic UI';
//     }
//     return Expanded(
//       child: Container(
//         decoration: BoxDecoration(
//             color: isSelected
//                 ? SleepAppTheme.nearlyBlue
//                 : SleepAppTheme.nearlyWhite,
//             borderRadius: const BorderRadius.all(Radius.circular(24.0)),
//             border: Border.all(color: SleepAppTheme.nearlyBlue)),
//         child: Material(
//           color: Colors.transparent,
//           child: InkWell(
//             splashColor: Colors.white24,
//             borderRadius: const BorderRadius.all(Radius.circular(24.0)),
//             onTap: () {
//               setState(() {
//                 categoryType = categoryTypeData;
//               });
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(
//                   top: 12, bottom: 12, left: 18, right: 18),
//               child: Center(
//                 child: Text(
//                   txt,
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 12,
//                     letterSpacing: 0.27,
//                     color: isSelected
//                         ? SleepAppTheme.nearlyWhite
//                         : SleepAppTheme.nearlyBlue,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// enum CategoryType {
//   ui,
//   coding,
//   basic,
// }
