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

//Οθόνη στατιστικών ημέρας
class StatisticsPage extends StatefulWidget {
  final AnimationController? animationController;
  const StatisticsPage({Key? key, this.animationController}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

List<Sleep> sleepStatistics = [];

class _StatisticsPageState extends State<StatisticsPage>
    with TickerProviderStateMixin {
  //αρχικοποιήσεις
  Animation<double>? topBarAnimation;
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  int _currentIndex = 0;
  final screens = [];
  var _isLoading = true;

  DateTime startDate = DateTime(2022, 5, 31, 0, 0, 0, 0, 0);
  DateTime endDate = DateTime(2022, 5, 31, 0, 0, 0, 0, 0);

  void addAllWidget() {
    // συνάρτηση που προσθέτει τα widgets της οθόνης αφου έχουν αρχικοποιηθεί τα δεδομένα μας
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
    getSleepDataByDay(); //συνάρτηση για την αρχικοποίση της λίστας με τα στατιστικά ημέρας
  }

  void getSleepDataByDay() async {
    final data = await DB().getHomeInfo(DateTime(2022, 5, 31, 0, 0, 0, 0,
        0)); //θέλουμε τα δεδομένα με βάση την τωρινή ημερομηνία
    setState(() {
      // με την setState ειδοποιούμε το framework οτι κάτι άλλαξε, στην περίπτωση μας ανανεώθηκε η λίστα δεδομένων
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
                    padding: EdgeInsets.only(top: 120, bottom: 50),
                    itemCount: listViews.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return listViews[index];
                    },
                  ),
            AppBarWidget(
                //δημιουργία AppBar
                animationController: widget.animationController,
                topBarAnimation: topBarAnimation,
                topBarOpacity: topBarOpacity,
                firstText: 'Day',
                secondText: 'Statistics',
                currentPage: 2,
                onTap: () async {
                  //listener για το άνοιγμα του ημερολογίου ανάλογα πότε θα πατήσει ο χρήστης
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
    //συνάρτηση που κανει draw το ημερολόγιο
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
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
              //για να ξέρουμε ότι ο χρήστης επέλεξε δυο ημέρες(το βράδυ που κοιμήθηκε και την ημέρα που ξύπνησε)
              startDate = startData;
              endDate = endData;

              sleepStatistics = [];
              sleepStatistics = [...tryingDay];
              listViews = [];
              addAllWidget();
              Navigator.pop(context);
            } else {
              Scaffold.of(newContext).showSnackBar(
                //εμφάνιση μηνύματος αν δεν εχει επιλέξει 2 ημέρες
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
