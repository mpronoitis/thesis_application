// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

import '../../helper/db.dart';
import '../models/sleep.dart';

class DaySelector extends StatefulWidget {
  const DaySelector({Key? key, this.onApplyClick}) : super(key: key);

  final Function(List<Sleep>)? onApplyClick;

  @override
  State<DaySelector> createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 10),
      child: DatePicker(
        DateTime(2022, 05, 27),
        height: 100,
        width: 65,
        initialSelectedDate: DateTime(2022, 5, 31, 0, 0, 0, 0, 0),
        selectionColor: Colors.purpleAccent,
        selectedTextColor: Colors.white,
        dateTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        dayTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        monthTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        onDateChange: (date) async {
          final data = await DB().getHomeInfo(date);
          setState(() {
            _selectedDate = date;
            print(data.length);
            // homeData = [];
            // homeData = [...data];
            if (data.length != 0) {
              widget.onApplyClick!(data);
            } else {
              print('nothing');
            }
          });
        },
      ),
    );
  }
}
