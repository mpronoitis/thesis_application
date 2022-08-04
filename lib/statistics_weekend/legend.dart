// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_adjacent_string_concatenation, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../screens/statistics_weekend.dart';

class LegendTitles extends StatelessWidget {
  const LegendTitles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Row(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 25.0,
            ),
            // child: BarNames(
            //   date: '12/04',
            //   name: 'Mon',
            // ),
            child: BarNames(
              date: '${DateFormat.d().format(DateTime.parse(sleepWeekendStatistics[index].recording_day))}' +
                  '${'/'}' +
                  '${DateFormat.M().format(DateTime.parse(sleepWeekendStatistics[index].recording_day))}',
              name: DateFormat.E().format(
                  DateTime.parse(sleepWeekendStatistics[index].recording_day)),
            ),
          ),
        ],
      ),
      itemCount: sleepWeekendStatistics.length,
    );
  }
}

class BarNames extends StatelessWidget {
  final String date;
  final String name;
  const BarNames({
    Key? key,
    required this.date,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(date),
        Text(name),
      ],
    );
  }
}

// return Row(
//       children: [
//         BarNames(
//           date: '${DateFormat.d().format(DateTime.parse(sleepByDate[0].recording_day))}' +
//               '${'/'}' +
//               '${DateFormat.M().format(DateTime.parse(sleepByDate[0].recording_day))}',
//           name: 'Sun',
//         ),
//         BarNames(
//           date: '${DateFormat.d().format(DateTime.parse(sleepByDate[0].recording_day))}' +
//               '${'/'}' +
//               '${DateFormat.M().format(DateTime.parse(sleepByDate[0].recording_day))}',
//           name: 'Mon',
//         ),
//         BarNames(
//           date: '${DateFormat.d().format(DateTime.parse(sleepByDate[0].recording_day))}' +
//               '${'/'}' +
//               '${DateFormat.M().format(DateTime.parse(sleepByDate[0].recording_day))}',
//           name: 'Tue',
//         ),
//         BarNames(
//           date: '${DateFormat.d().format(DateTime.parse(sleepByDate[0].recording_day))}' +
//               '${'/'}' +
//               '${DateFormat.M().format(DateTime.parse(sleepByDate[0].recording_day))}',
//           name: 'Wed',
//         ),
//         BarNames(
//             date: '${DateFormat.d().format(DateTime.parse(sleepByDate[0].recording_day))}' +
//                 '${'/'}' +
//                 '${DateFormat.M().format(DateTime.parse(sleepByDate[0].recording_day))}',
//             name: 'Thu,'),
//         BarNames(
//           date: '${DateFormat.d().format(DateTime.parse(sleepByDate[0].recording_day))}' +
//               '${'/'}' +
//               '${DateFormat.M().format(DateTime.parse(sleepByDate[0].recording_day))}',
//           name: 'Fri',
//         ),
//         BarNames(
//           date: '${DateFormat.d().format(DateTime.parse(sleepByDate[0].recording_day))}' +
//               '${'/'}' +
//               '${DateFormat.M().format(DateTime.parse(sleepByDate[0].recording_day))}',
//           name: 'Sat',
//         ),
//       ],
//     );
