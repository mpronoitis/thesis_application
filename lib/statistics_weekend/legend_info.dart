// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import '../main.dart';

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
            // color: HexColor('#87A0E5').withOpacity(1.0),
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
            // color: HexColor('#F1B440').withOpacity(1.0),
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
            // color: HexColor('#F56E98').withOpacity(1.0),
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
          // Icon(
          //   Icons.brightness_1,
          //   color: Colors.yellow,
          // ),
          // Column(
          //   children: [
          //     Text(' Awake'),
          //     Text(' Time'),
          //   ],
          // ),
        ],
      ),
    );
  }
}
