// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ptixiaki_sleep_stages/widget/appbar_widget.dart';
import '../../helper/db.dart';
import '../first_screen_widgets/day_selector.dart';
import '../first_screen_widgets/sleep_stages_list_view.dart';
import '../first_screen_widgets/sleep_view.dart';
import '../first_screen_widgets/title_view.dart';
import '../models/sleep_stages_list_data.dart';
import '../models/sleep.dart';
import '../sleep_app_theme.dart';

List<Sleep> homeData = []; //δεδομενα αρχικής οθόνης

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with TickerProviderStateMixin {
  //αρχικοποιήσεις
  Animation<double>? topBarAnimation;
  var dbHelper;
  List<Widget> listViews = <Widget>[];
  List<SleepStagesData> sleepStages = [];
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
    //συνάρτηση η οποία κάνει ενα query στην βάση για την άντληση των δεδομένων της αρχικής οθόνης
    final data = await dbHelper.getHomeInfo(
        //query στην βαση με βαση το τωρινό date για να δούμε τα δεδομένα της τελευταίας εγγραφής
        DateTime(2022, 5, 31, 0, 0, 0, 0,
            0)); //dedomena arxikhw me bash to teleutaio datetime

    setState(() {
      //αφου έχουμε διαβάσει τα δεδομένα
      homeData = [...data];
      sleepStages = [
        //δημιουργία καρτών με βάση τα δεδομένα της λίστας
        SleepStagesData(
          // imagePath: 'assets/sleep_app/breakfast.png',
          titleTxt: 'Deep sleep',
          kacl: getConversion(homeData[0].minutes_deep_sleep!),
          progress: getPercentStage(homeData[0].minutes_deep_sleep!),
          startColor: '#FA7D82',
          endColor: '#FFB295',
        ),
        SleepStagesData(
          imagePath: 'assets/sleep_app/lunch.png',
          titleTxt: 'Light sleep',
          kacl: getConversion(homeData[0].minutes_light_sleep!),
          progress: getPercentStage(homeData[0].minutes_light_sleep!),
          startColor: '#738AE6',
          endColor: '#5C5EDD',
        ),
        SleepStagesData(
          imagePath: 'assets/sleep_app/snack.png',
          titleTxt: 'REM sleep',
          kacl: getConversion(homeData[0].minutes_rem_sleep!),
          progress: getPercentStage(homeData[0].minutes_rem_sleep!),
          startColor: '#FE95B6',
          endColor: '#FF5287',
        ),
        SleepStagesData(
          imagePath: 'assets/sleep_app/dinner.png',
          titleTxt: 'Awake time',
          kacl: homeData[0].awake.toString(),
          progress: (homeData[0].awake! / homeData[0].asleep_min!),
          startColor: '#6F72CA',
          endColor: '#1E1466',
        )
      ];

      addAllListData();
      _isLoading = false;
    });
  }

  void addAllListData() {
    //αφου εχουμε διαβάσει τα δεδομενα τοποθετούμαι τα widgets στην οθόνη
    const int count = 8;

    listViews.add(DaySelector(onApplyClick: (List<Sleep> data) {
      //callback function το οποίο αλλάζει τα δεδομένα με βάση την ημέρα που θα επιλέξει ο χρήστης
      setState(() {
        homeData = [];
        sleepStages = [];
        homeData = [...data];
        listViews = [];
        sleepStages = [
          SleepStagesData(
            // imagePath: 'assets/sleep_app/breakfast.png',
            titleTxt: 'Deep sleep',
            kacl: getConversion(homeData[0].minutes_deep_sleep!),
            progress: getPercentStage(homeData[0].minutes_deep_sleep!),
            startColor: '#FA7D82',
            endColor: '#FFB295',
          ),
          SleepStagesData(
            imagePath: 'assets/sleep_app/lunch.png',
            titleTxt: 'Light sleep',
            kacl: getConversion(homeData[0].minutes_light_sleep!),
            progress: getPercentStage(homeData[0].minutes_light_sleep!),
            startColor: '#738AE6',
            endColor: '#5C5EDD',
          ),
          SleepStagesData(
            imagePath: 'assets/sleep_app/snack.png',
            titleTxt: 'REM sleep',
            kacl: getConversion(homeData[0].minutes_rem_sleep!),
            progress: getPercentStage(homeData[0].minutes_rem_sleep!),
            startColor: '#FE95B6',
            endColor: '#FF5287',
          ),
          SleepStagesData(
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
      //δημιουργία widget τίτλου αρχικής οθόνης
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
      //δημιουργία κάρτας που περιέχει τις πληροφορίες σχετικά για τον ύπνο
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
      //προσθήκη στην λίστα των καρτών που δείχνουν αναλυτικά κάθε στάδιο του ύπνου
      SleepStagesView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: Interval((1 / count) * 3, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
        sleepStagesListData: sleepStages,
      ),
    );
  }

  Future<bool> getData() async {
    //δημιουργία delay για smooth ανανέωση
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
            _isLoading
                ? Text('No Data')
                : getMainListViewUI(), //αμα δεν υπάρχουν δεδομένα εμφανίζει μήνυμα αλλίως φτιάχνει τν οθόνη
            AppBarWidget(
              //αρχικοποιήση app bar
              animationController: widget.animationController,
              topBarAnimation: topBarAnimation,
              topBarOpacity: topBarOpacity,
              firstText: 'Welcome',
              secondText: 'Today',
              currentPage: 1,
              onTap: () async {},
            ),

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
            padding: EdgeInsets.only(top: 100, bottom: 50),
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
