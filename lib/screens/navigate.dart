// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ptixiaki_sleep_stages/screens/statistics.dart';
import 'package:ptixiaki_sleep_stages/screens/statistics_month.dart';
import 'package:ptixiaki_sleep_stages/screens/statistics_weekend.dart';

class Navigate extends StatefulWidget {
  final AnimationController? animationController;
  Navigate({Key? key, this.animationController}) : super(key: key);

  @override
  State<Navigate> createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> with TickerProviderStateMixin {
  final screens = [];
  int showDialog = 0;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    screens.add(StatisticsPage(
      animationController: widget.animationController,
    ));
    screens.add(StatisticsWeekend(
      animationController: widget.animationController,
    ));
    screens.add(
      StatisticsMonth(
        animationController: widget.animationController,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            showDialog == 0
                ? ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'You can interact with calendar to change days of your sleep data',
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  )
                : '';
            showDialog = 1;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.space_dashboard_rounded,
                size: 30,
              ),
              label: 'Today'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.stacked_bar_chart,
                size: 30,
              ),
              label: 'Week'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.auto_graph,
                size: 30,
              ),
              label: 'Month')
        ],
      ),
    );
  }
}
