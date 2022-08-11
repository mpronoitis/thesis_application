// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../sleep_app_theme.dart';

//Widget κάρτας στατιστικών μήνα
class AdviceCard extends StatelessWidget {
  const AdviceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Ink.image(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1587738108058-10ad47447b86?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80',
                ),
                height: 240,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 16,
                right: 16,
                left: 16,
                child: Text(
                  'Last call for caffeine',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16).copyWith(
              bottom: 0,
            ),
            child: Text(
              'Did you know that caffeine still has 50% of its waking effects 6 hours after intake? Today, try to stick to 4 cups max and aim to quit your caffeine intake around 2 p.m.',
              style: TextStyle(
                fontFamily: SleepAppTheme.fontName,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 0.3,
                color: SleepAppTheme.darkText,
              ),
            ),
          )
        ],
      ),
    );
  }
}
