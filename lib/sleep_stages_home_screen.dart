// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ptixiaki_sleep_stages/screens/first_screen.dart';
import 'package:ptixiaki_sleep_stages/screens/navigate.dart';
import 'package:ptixiaki_sleep_stages/screens/profile.dart';
import 'sleep_app_theme.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class SleepHomeScreen extends StatefulWidget {
  @override
  _SleepHomeScreenState createState() => _SleepHomeScreenState();
}

class _SleepHomeScreenState extends State<SleepHomeScreen>
    with TickerProviderStateMixin {
  //Interface TickerProviderStateMixin για υποστηριξη animation
  // Αρχικοποιήσεις
  AnimationController? animationController;
  int _currentIndex = 0;
  final screens = [];
  int showDialog = 0;
//Μέθοδος initState τρέχει πριν την δημιουργία των widgets
//δημιουργία οθονών αρχικής οθόνης και συγχρονισμός της παρούσας οθόνης με τον animationcontroller
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    screens.add(FirstScreen(
      //1o tab
      animationController: animationController,
    ));
    screens.add(Navigate(
      //2o tab
      animationController: animationController,
    ));
    screens.add(Profile()); //3o tab

    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SleepAppTheme.background,
      child: Scaffold(
        body: FutureBuilder<bool>(
          future: getData(), //δημιουργία καθυστέρησης για πιο smooth animation
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              //αφου ολοκληρωθεί το amimation δημιουργία οθόνης
              return Stack(
                children: <Widget>[
                  screens[_currentIndex],
                ],
              );
            }
          },
        ),
        bottomNavigationBar: Container(
          //κάτω μενού πλοήγησης
          decoration: BoxDecoration(
            color: SleepAppTheme.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                haptic: true, // haptic feedback
                tabBorderRadius: 15,
                tabActiveBorder: Border.all(
                    color: Colors.black, width: 1), // tab button border
                tabBorder: Border.all(
                    color: Colors.grey, width: 1), // tab button border

                curve: Curves.easeOutExpo, // tab animation curves
                duration: Duration(milliseconds: 300), // tab animation duration
                gap: 8, // the tab button gap between icon and text
                color: Colors.grey[800], // unselected icon color
                activeColor: Colors.purple, // selected icon and text color
                iconSize: 30, // tab button icon size
                // tabBackgroundColor: Colors.purple
                //     .withOpacity(0.1), // selected tab background color
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                selectedIndex: _currentIndex,
                onTabChange: (index) {
                  setState(() {
                    // μέθοδος που καλείται κάθε φορα που αλληλοεπιδρούμαι με το κάτω μενού πλοήγησης(διαχειρίζει το state της εφαρμογής)
                    _currentIndex = index;

                    showDialog == 0
                        ? ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'You can choose from calendar icon your day of preference'),
                              behavior: SnackBarBehavior.floating,
                              elevation: 0,
                            ),
                          )
                        : '';
                    showDialog = 1;
                  });
                },
                tabs: [
                  //διαθέσιμα tabs μενού
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.stacked_bar_chart,
                    text: 'Statistics',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> getData() async {
    // συνάρτηση για δημιουργία delay
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
}
