// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../sleep_app_theme.dart';

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
// class AdviceCard extends StatefulWidget {
//   const AdviceCard({Key? key}) : super(key: key);

//   @override
//   State<AdviceCard> createState() => _AdviceCardState();
// }

// class _AdviceCardState extends State<AdviceCard> {
//   @override
//   Widget build(BuildContext context) {
//     final double height = MediaQuery.of(context).size.height;
//     final double width = MediaQuery.of(context).size.width;
//     return Container(
//       height: 230,
//       child: Stack(
//         children: [
//           Positioned(
//             top: 35,
//             left: 30,
//             child: Material(
//               child: Container(
//                 height: 195.0,
//                 width: width * 0.9,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(0.0),
//                   boxShadow: [
//                     BoxShadow(
//                       color: SleepAppTheme.grey.withOpacity(0.3),
//                       offset: Offset(-10.0, 10.0),
//                       blurRadius: 20.0,
//                       spreadRadius: 4.0,
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 20,
//             left: 40,
//             child: Card(
//               elevation: 10.0,
//               shadowColor: SleepAppTheme.grey.withOpacity(0.5),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15.0),
//               ),
//               child: Container(
//                   height: 180,
//                   width: 180,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10.0),
//                       image: DecorationImage(
//                           fit: BoxFit.fill,
//                           image: AssetImage(
//                               "assets/fitness_app/advice_caffeine3.jpg")))),
//             ),
//           ),
//           Positioned(
//               top: 45,
//               left: 240,
//               child: Container(
//                 height: 185,
//                 width: 150,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Advice',
//                       style: TextStyle(
//                         fontFamily: SleepAppTheme.fontName,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 24,
//                         letterSpacing: 0.5,
//                         color: SleepAppTheme.lightText,
//                       ),
//                     ),
//                     Text(
//                       'Last Call for Caffeine',
//                       style: TextStyle(
//                         fontFamily: SleepAppTheme.fontName,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                         letterSpacing: 0.5,
//                         color: SleepAppTheme.darkText,
//                       ),
//                     ),
//                     Divider(
//                       color: Colors.black,
//                     ),
//                     Text(
//                       'Did you know that caffeine still has 50% of its waking effects 6 hours after intake?',
//                       style: TextStyle(
//                         fontFamily: SleepAppTheme.fontName,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         letterSpacing: 0.3,
//                         color: SleepAppTheme.darkText,
//                       ),
//                     )
//                   ],
//                 ),
//               ))
//         ],
//       ),
//     );
//   }
// }
