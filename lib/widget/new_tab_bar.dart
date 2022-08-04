// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:ptixiaki_sleep_stages/duration_widgets/asleep_after_chart.dart';
import 'package:ptixiaki_sleep_stages/duration_widgets/awake_chart.dart';
import 'package:ptixiaki_sleep_stages/duration_widgets/in_bed_chart.dart';
import 'package:ptixiaki_sleep_stages/sleep_app_theme.dart';
import 'package:ptixiaki_sleep_stages/statistics_weekend/sleep_quality_chart.dart';

class NewTabBar extends StatefulWidget {
  final bool type;
  const NewTabBar({Key? key, required this.type}) : super(key: key);

  @override
  State<NewTabBar> createState() => _NewTabBarState();
}

class _NewTabBarState extends State<NewTabBar> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Column(
      children: [
        Container(
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              labelPadding: const EdgeInsets.only(left: 20, right: 20),
              labelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: 0.27,
                color: Colors.purple,
              ),
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: SleepAppTheme.grey,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: CircleTabBarIndicator(
                color: SleepAppTheme.dark_grey,
                radius: 4,
              ),
              tabs: [
                Tab(text: "Asleep"),
                Tab(text: "Asleep after"),
                Tab(text: "Awake"),
              ],
            ),
          ),
        ),
        Container(
          height: 350,
          width: double.maxFinite,
          child: TabBarView(
            controller: _tabController,
            children: [
              InBedChart(
                type: widget.type,
              ),
              AsleepAfterChart(
                type: widget.type,
              ),
              AwakeChart(
                type: widget.type,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CircleTabBarIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabBarIndicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;
  _CirclePainter({required this.color, required this.radius});
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);
    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}
