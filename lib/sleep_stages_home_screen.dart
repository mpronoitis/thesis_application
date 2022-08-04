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
  AnimationController? animationController;
  int _currentIndex = 0;
  final screens = [];
  int showDialog = 0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    screens.add(FirstScreen(
      animationController: animationController,
    ));
    screens.add(Navigate(
      animationController: animationController,
    ));
    screens.add(Profile());

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
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  screens[_currentIndex],
                ],
              );
            }
          },
        ),
        bottomNavigationBar: Container(
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
                // rippleColor: Colors.grey[800], // tab button ripple color when pressed
                // hoverColor: Colors.grey[700], // tab button hover color
                haptic: true, // haptic feedback
                tabBorderRadius: 15,
                tabActiveBorder: Border.all(
                    color: Colors.black, width: 1), // tab button border
                tabBorder: Border.all(
                    color: Colors.grey, width: 1), // tab button border
                // tabShadow: [
                //   BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
                // ], // tab button shadow
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
        // bottomNavigationBar: BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   backgroundColor: Colors.deepPurple,
        //   selectedItemColor: Colors.white,
        //   unselectedItemColor: Colors.white70,
        //   iconSize: 20,
        //   selectedFontSize: 16,
        //   unselectedFontSize: 16,
        //   currentIndex: _currentIndex,
        //   onTap: (index) {
        //     setState(() {
        //       _currentIndex = index;
        //     });
        //   },
        //   items: [
        //     BottomNavigationBarItem(
        //         icon: Icon(
        //           Icons.home,
        //         ),
        //         label: 'Home',
        //         backgroundColor: Colors.red),
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.stacked_line_chart,
        //       ),
        //       label: 'Statistics',
        //       backgroundColor: Colors.blue,
        //     ),
        //     // BottomNavigationBarItem(
        //     //     icon: Icon(
        //     //       Icons.person,
        //     //     ),
        //     //     label: 'Profile'),
        //   ],
        // ),
        // bottomNavigationBar: NavigationBarTheme(
        //   data: NavigationBarThemeData(
        //       indicatorColor: Colors.purple[200],
        //       labelTextStyle: MaterialStateProperty.all(
        //         TextStyle(
        //           fontSize: 14,
        //           fontWeight: FontWeight.w500,
        //         ),
        //       )),
        //   child: NavigationBar(
        //     height: 60,
        //     selectedIndex: _currentIndex,
        //     onDestinationSelected: (index) => setState(() {
        //       _currentIndex = index;
        //     }),
        //     backgroundColor: Colors.white,
        //     destinations: [
        //       NavigationDestination(
        //         icon: Icon(
        //           Icons.home,
        //           size: 30,
        //         ),
        //         label: 'Home',
        //       ),
        //       NavigationDestination(
        //         icon: Icon(
        //           Icons.stacked_line_chart,
        //           size: 30,
        //         ),
        //         label: 'Statistics',
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
}
