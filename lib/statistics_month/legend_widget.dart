import 'package:flutter/material.dart';

import '../../sleep_app_theme.dart';

//Legend γραφήματος στατιστικών μήνα
class LegendWidget extends StatelessWidget {
  final String name;
  final Color color;

  const LegendWidget({
    Key? key,
    required this.name,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 6),
        Row(
          children: [
            Text(
              name,
              style: TextStyle(
                fontFamily: SleepAppTheme.fontName,
                fontWeight: FontWeight.w500,
                fontSize: 20,
                letterSpacing: -0.1,
                color: SleepAppTheme.grey.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LegendsListWidget extends StatelessWidget {
  final List<Legend> legends;

  const LegendsListWidget({
    Key? key,
    required this.legends,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      spacing: 16,
      children: legends
          .map(
            (e) => LegendWidget(
              name: e.name,
              color: e.color,
            ),
          )
          .toList(),
    );
  }
}

class Legend {
  final String name;
  final Color color;

  Legend(this.name, this.color);
}
