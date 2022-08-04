// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class TabBarItemComponent extends StatefulWidget {
  final Map<String, dynamic> item;
  final Function(Map<String, dynamic>) onApplyClick;
  const TabBarItemComponent(
      {Key? key, required this.item, required this.onApplyClick})
      : super(key: key);

  @override
  State<TabBarItemComponent> createState() => _TabBarItemComponentState();
}

class _TabBarItemComponentState extends State<TabBarItemComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onApplyClick(widget.item);
      },
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        margin: EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
            color: widget.item['active'] ? Colors.purple : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Color(0xFF000000).withOpacity(0.05),
                  blurRadius: 30,
                  offset: Offset(1, 0)),
            ]),
        child: Row(
          children: [
            Icon(
              widget.item['icon'],
              color: widget.item['active'] ? Colors.white : Colors.black,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              widget.item['label'],
              style: TextStyle(
                  color: widget.item['active'] ? Colors.white : Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
