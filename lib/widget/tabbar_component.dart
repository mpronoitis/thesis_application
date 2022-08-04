// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ptixiaki_sleep_stages/widget/tabbar_item_component.dart';

class TabBarComponent extends StatefulWidget {
  TabBarComponent({Key? key}) : super(key: key);

  @override
  State<TabBarComponent> createState() => _TabBarComponentState();
}

class _TabBarComponentState extends State<TabBarComponent> {
  final itemList = [
    {'label': 'Weekly', 'icon': Icons.stacked_bar_chart, 'active': true},
    {'label': 'Monthly', 'icon': Icons.auto_graph, 'active': false}
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.0,
      ),
      height: 50,
      child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: itemList
              .map((tabItem) => TabBarItemComponent(
                  item: tabItem,
                  onApplyClick: (Map<String, dynamic> tappedItem) {
                    setState(() {
                      tabItem['active'] = !tappedItem['active'];
                    });
                  }))
              .toList()),
    );
  }
}
