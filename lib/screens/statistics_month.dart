// ignore_for_file: prefer_const_constructors

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ptixiaki_sleep_stages/helper/db.dart';
import 'package:ptixiaki_sleep_stages/widget/appbar_widget.dart';
import 'package:ptixiaki_sleep_stages/widget/new_tab_bar.dart';

import '../../statistics_weekend/category_widget.dart';
import '../../widget/calendar_popup_view.dart';
import '../models/sleep.dart';
import '../sleep_app_theme.dart';
import '../statistics_month/advice_card.dart';
import '../statistics_month/max_sleep_quality_card.dart';
import '../statistics_month/month_chart.dart';
import '../statistics_month/sleep_quality_month.dart';

List<Sleep> sleepMonthStatistics = [];
List<Sleep> tryingMonth = [];

class StatisticsMonth extends StatefulWidget {
  final AnimationController? animationController;
  const StatisticsMonth({Key? key, this.animationController}) : super(key: key);

  @override
  State<StatisticsMonth> createState() => _StatisticsMonthState();
}

class _StatisticsMonthState extends State<StatisticsMonth>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  DateTime startDate = DateTime(2022, 5, 01);
  DateTime endDate = DateTime(2022, 5, 31);
  List<Widget> listMonth = <Widget>[];
  late CategoryType category;
  var _isLoading = true;
  @override
  void initState() {
    category = CategoryType.sleep_stages;
    topBarAnimation = CurvedAnimation(
      parent: widget.animationController!,
      curve: Interval(
        0,
        0.5,
        curve: Curves.fastOutSlowIn,
      ),
    );
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
    getData();
  }

  void getData() async {
    final data = await DB().getAllRecordsByMonth(
        DateFormat('yyyy-MM-dd').format(startDate),
        DateFormat('yyyy-MM-dd').format(endDate));
    setState(() {
      sleepMonthStatistics = [...data];

      _isLoading = false;
      addItemsSleepStages();
    });
  }

  void addItemsSleepStages() {
    listMonth.add(
      CategoryWidget(
        onApplyClick: (CategoryType categoryType) {
          setState(() {
            category = categoryType;
            listMonth = [];

            if (categoryType == CategoryType.sleep_stages) {
              addItemsSleepStages();
              // } else if (categoryType == CategoryType.sleep_quality) {
              //   addAnother();
              // } else if (categoryType == CategoryType.time_in_bed) {
              //   addTimeInBed();
              // }
            } else if (categoryType == CategoryType.sleep_quality) {
              addItemsSleepQuality();
            } else if (categoryType == CategoryType.time_in_bed) {
              addItemsDurationCategory();
            }
          });
        },
      ),
    );
    listMonth.add(MonthChart());
    listMonth.add(AdviceCard());
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text("Flutter default Snackbar"),
    //   ),
    // );
  }

  void addItemsSleepQuality() {
    listMonth.add(
      CategoryWidget(
        onApplyClick: (CategoryType categoryType) {
          setState(() {
            category = categoryType;
            listMonth = [];

            if (categoryType == CategoryType.sleep_stages) {
              addItemsSleepStages();
              // } else if (categoryType == CategoryType.sleep_quality) {
              //   addAnother();
              // } else if (categoryType == CategoryType.time_in_bed) {
              //   addTimeInBed();
              // }
            } else if (categoryType == CategoryType.sleep_quality) {
              addItemsSleepQuality();
            } else if (categoryType == CategoryType.time_in_bed) {
              addItemsDurationCategory();
            }
          });
        },
      ),
    );
    listMonth.add(MaxSleepQuality());
    listMonth.add(LineChartSample2());
  }

  void addItemsDurationCategory() {
    listMonth.add(
      CategoryWidget(
        onApplyClick: (CategoryType categoryType) {
          setState(() {
            category = categoryType;
            listMonth = [];

            if (categoryType == CategoryType.sleep_stages) {
              addItemsSleepStages();
              // } else if (categoryType == CategoryType.sleep_quality) {
              //   addAnother();
              // } else if (categoryType == CategoryType.time_in_bed) {
              //   addTimeInBed();
              // }
            } else if (categoryType == CategoryType.sleep_quality) {
              addItemsSleepQuality();
            } else if (categoryType == CategoryType.time_in_bed) {
              addItemsDurationCategory();
            }
          });
        },
      ),
    );
    listMonth.add(NewTabBar(
      type: false,
    ));
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
                ? Text('No Data')
                : ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(top: 120, bottom: 50
                        // top: AppBar().preferredSize.height +
                        //     MediaQuery.of(context).padding.top +
                        //     24,
                        // bottom: 62 + MediaQuery.of(context).padding.bottom,
                        ),
                    itemCount: listMonth.length,
                    itemBuilder: (BuildContext context, int index) {
                      return listMonth[index];
                    },
                  ),
            AppBarWidget(
              animationController: widget.animationController,
              topBarAnimation: topBarAnimation,
              topBarOpacity: topBarOpacity,
              firstText: 'Month',
              secondText: 'Statistics',
              currentPage: 3,
              startDate: startDate,
              endDate: endDate,
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());

                showDemoDialog(context: context);
              },
            )
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
        // minimumDate: DateTime(2022, 4, 12),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        // initialEndDate: DateTime(2022, 4, 12),
        // initialStartDate: DateTime(2022, 4, 12),
        onApplyClick: (DateTime startData, DateTime endData,
            BuildContext newContext) async {
          tryingMonth = [];
          tryingMonth = await DB().getAllRecordsByMonth(
              DateFormat('yyyy-MM-dd').format(startData),
              DateFormat('yyyy-MM-dd').format(endData));
          setState(() {
            startDate = startData;
            endDate = endData;

            sleepMonthStatistics = [];
            sleepMonthStatistics = [...tryingMonth];
            listMonth = [];
            print(category);
            if (category == CategoryType.sleep_stages) {
              addItemsSleepStages();
            } else if (category == CategoryType.sleep_quality) {
              addItemsSleepQuality();
            } else if (category == CategoryType.time_in_bed) {
              addItemsDurationCategory();
            }
            Navigator.pop(context);
            // } else if (category == CategoryType.time_in_bed) {
            //   addTimeInBed();
            // }

            // category == CategoryType.sleep_stages ? addWidgets() : addAnother();
          });
        },
        onCancelClick: () {},
        typeOfChart: 3,
      ),
    );
  }
}

final popupOptions = <String>[
  'Weekly',
  'Monthly',
  'Yearly',
];
