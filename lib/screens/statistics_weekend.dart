// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ptixiaki_sleep_stages/helper/db.dart';
import 'package:ptixiaki_sleep_stages/statistics_weekend/average_card.dart';
import 'package:ptixiaki_sleep_stages/statistics_weekend/category_widget.dart';
import 'package:ptixiaki_sleep_stages/statistics_weekend/sleep_quality_chart.dart';
import 'package:ptixiaki_sleep_stages/statistics_weekend/weekend_chart.dart';
import 'package:ptixiaki_sleep_stages/widget/new_tab_bar.dart';

import '../../widget/appbar_widget.dart';
import '../../widget/calendar_popup_view.dart';
import '../models/sleep.dart';
import '../sleep_app_theme.dart';

List<Sleep> sleepWeekendStatistics = [];
List<Sleep> tryingWeekend = [];
DateTime startDate = DateTime(2022, 5, 1);
DateTime endDate = DateTime(2022, 5, 7);
var _isLoading = true;

class StatisticsWeekend extends StatefulWidget {
  final AnimationController? animationController;
  const StatisticsWeekend({Key? key, this.animationController})
      : super(key: key);

  @override
  State<StatisticsWeekend> createState() => _StatisticsWeekendState();
}

class _StatisticsWeekendState extends State<StatisticsWeekend>
    with TickerProviderStateMixin {
  //αρχικοποιήσεις
  Animation<double>? topBarAnimation;
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  int _currentIndex = 0;
  final screens = [];

  List<Widget> listViews = <Widget>[];
  late CategoryType category;
//κατηγορία sleep stages
  void addWidgets() {
    listViews.add(
      CategoryWidget(
        onApplyClick: (CategoryType categoryType) {
          setState(() {
            listViews = [];
            category = categoryType;
            if (categoryType == CategoryType.sleep_stages) {
              addWidgets();
            } else if (categoryType == CategoryType.sleep_quality) {
              addAnother();
            } else if (categoryType == CategoryType.time_in_bed) {
              addTimeInBed();
            }
          });
        },
      ),
    );
    listViews.add(
      WeekendChart(
        onApplyClick1:
            (DateTime startData, DateTime endData, List<Sleep> data) {
          setState(() {
            startDate = startData;
            endDate = endData;
            sleepWeekendStatistics = [];
            sleepWeekendStatistics = [...data];
            listViews = [];
            addWidgets();
          });
        },
        onApplyClick2:
            (DateTime startData, DateTime endData, List<Sleep> data) {
          setState(() {
            startDate = startData;
            endDate = endData;
            sleepWeekendStatistics = [];
            sleepWeekendStatistics = [...data];
            listViews = [];
            addWidgets();
          });
        },
      ),
    );

    listViews.add(AverageCard());
  } // κατηγορία sleep stages

//κατηγορία sleep quality
  void addAnother() {
    listViews.add(
      CategoryWidget(
        onApplyClick: (CategoryType categoryType) {
          setState(() {
            category = categoryType;
            listViews = [];

            if (categoryType == CategoryType.sleep_stages) {
              addWidgets();
            } else if (categoryType == CategoryType.sleep_quality) {
              addAnother();
            } else if (categoryType == CategoryType.time_in_bed) {
              addTimeInBed();
            }
          });
        },
      ),
    );

    listViews.add(SleepQualityChart());

    // listViews.add(AverageCard());
  } //κατηγορία sleep quality

//κατηγορία duration
  void addTimeInBed() {
    listViews.add(
      CategoryWidget(
        onApplyClick: (CategoryType categoryType) {
          setState(() {
            category = categoryType;
            listViews = [];

            if (categoryType == CategoryType.sleep_stages) {
              addWidgets();
            } else if (categoryType == CategoryType.sleep_quality) {
              addAnother();
            } else if (categoryType == CategoryType.time_in_bed) {
              addTimeInBed();
            }
          });
        },
      ),
    );
    listViews.add(NewTabBar(
      type: true,
    ));
    // listViews.add(TimeInBed());
  }

  @override
  void initState() {
    category = CategoryType.sleep_stages; //αρχικό επιλεγμένο category
    topBarAnimation = CurvedAnimation(
        parent: widget.animationController!,
        curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn));

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
    get(); //πριν τρέξει η main θέλουμε να έχουμε διαβάσει τα δεδομένα
  }

  void get() async {
    //΄κλήση συνάρτησης με την οποία αντλούμαι τα δεδομένα με βάση τις ημέρες που δίνουμε ως όρισμα
    final data = await DB().getAllRecordsByWeekend(
        DateFormat('yyyy-MM-dd').format(startDate),
        DateFormat('yyyy-MM-dd').format(endDate));
    setState(() {
      sleepWeekendStatistics = [...data];
      _isLoading = false; //για να ξέρουμε οτι τα δεδομένα διαβάστηκαν
      addWidgets();
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
                ? Text('No Data')
                : ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(top: 120, bottom: 50),
                    itemCount: listViews.length,
                    itemBuilder: (BuildContext context, int index) {
                      return listViews[index];
                    },
                  ),
            AppBarWidget(
              //αρχικοποίηση AppBar
              animationController: widget.animationController,
              topBarAnimation: topBarAnimation,
              topBarOpacity: topBarOpacity,
              firstText: 'Week',
              secondText: 'Statistics',
              currentPage: 3,
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());

                showDemoDialog(
                    context: context); //listener για το άνοιγμα του ημερολογίου
              },
              startDate: startDate,
              endDate: endDate,
            ),
          ],
        ),
      ),
    );
  }

//συνάρτηση που φτιάχνει το ημερολόγιο της εφαρμογής
  void showDemoDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        onApplyClick: (DateTime startData,
            DateTime
                endData, //callback function για την ανανέωση των δεδομένων σε περίπτωση που ο χρήστης επιλέξει άλλες μέρες
            BuildContext newContext) async {
          final current = endData
              .difference(startData)
              .inDays; //επειδή είναι στατιστικά εβδομάδας θέλουμε ο χρήστης να επιλέξει ακριβώς 7 ημέρες
          if (current == 6) {
            tryingWeekend = [];
            tryingWeekend = await DB().getAllRecordsByWeekendTemp(
                //αμα έχει επιλέξει 7 ημέρες κάνουμε select απο την βάση
                DateFormat('yyyy-MM-dd').format(startData),
                DateFormat('yyyy-MM-dd').format(endData));
          }
          setState(() {
            final current = endData.difference(startData).inDays;
            if (current == 6) {
              startDate = startData;
              endDate = endData;

              sleepWeekendStatistics = [];
              sleepWeekendStatistics = [
                ...tryingWeekend
              ]; //ανανέωση δεδομένων οθόνης
              listViews = [];

              if (category == CategoryType.sleep_stages) {
                //ελέγχουμε ποια ήταν η τελευταία επιλεγμένη κατηγορία
                addWidgets();
              } else if (category == CategoryType.sleep_quality) {
                addAnother();
              } else if (category == CategoryType.time_in_bed) {
                addTimeInBed();
              }
              Navigator.pop(context);
            } else {
              Scaffold.of(newContext).showSnackBar(
                //αμα δεν επιλέξει 7 ημέρες εμφάνισει μηνύματος
                SnackBar(
                  content: Text(
                      'You have to choose seven days. For example, if you want to see your sleep data for the second week of May, you must choose May 9 as first day and May 15 as last day.'),
                  duration: Duration(seconds: 10),
                ),
              );
            }
          });
        },
        onCancelClick: () {},
        typeOfChart: 2,
      ),
    );
  }
}
