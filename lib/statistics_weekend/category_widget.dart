// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../sleep_app_theme.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({Key? key, this.onApplyClick}) : super(key: key);
  final Function(CategoryType)? onApplyClick;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  CategoryType categoryType = CategoryType.sleep_stages;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            'Category',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: SleepAppTheme.darkerText,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: <Widget>[
              getButtonUI(CategoryType.sleep_stages,
                  categoryType == CategoryType.sleep_stages),
              const SizedBox(
                width: 16,
              ),
              getButtonUI(CategoryType.sleep_quality,
                  categoryType == CategoryType.sleep_quality),
              const SizedBox(
                width: 16,
              ),
              getButtonUI(CategoryType.time_in_bed,
                  categoryType == CategoryType.time_in_bed),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    String txt = '';
    if (CategoryType.sleep_stages == categoryTypeData) {
      txt = 'Sleep Stages';
    } else if (CategoryType.sleep_quality == categoryTypeData) {
      txt = 'Sleep Quality';
    } else if (CategoryType.time_in_bed == categoryTypeData) {
      txt = '   Duration';
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? Colors.purple : SleepAppTheme.nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: Colors.purple)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              widget.onApplyClick!(categoryTypeData);

              setState(() {
                categoryType = categoryTypeData;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 15, left: 10, right: 0),
              child: Center(
                child: Row(
                  children: [
                    Text(
                      txt,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        letterSpacing: 0.27,
                        color: isSelected
                            ? SleepAppTheme.nearlyWhite
                            : Colors.purple,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum CategoryType {
  // ignore: constant_identifier_names
  sleep_stages,
  // ignore: constant_identifier_names
  sleep_quality,
  time_in_bed
}
