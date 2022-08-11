// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import '../main.dart';

//Widget για τα legends των γραφημάτων
class LegendInfo extends StatelessWidget {
  const LegendInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10.0,
        left: 10.0,
      ),
      child: Row(
        children: [
          Icon(
            Icons.brightness_1,
            color: Color(0xff632af2),
          ),
          Column(
            children: [
              Text(' Deep'),
              Text(' Sleep'),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Icon(
            Icons.brightness_1,
            color: Color(0xffffb3ba),
          ),
          Column(
            children: [
              Text(' Light'),
              Text(' Sleep'),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Icon(
            Icons.brightness_1,
            color: Color(0xff578eff),
          ),
          Column(
            children: [
              Text(' REM'),
              Text(' Sleep'),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
        ],
      ),
    );
  }
}
