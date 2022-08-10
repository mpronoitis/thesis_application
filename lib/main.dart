import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:ptixiaki_sleep_stages/sleep_app_theme.dart';
import 'package:ptixiaki_sleep_stages/sleep_stages_home_screen.dart';

import 'helper/db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //αρχικοποίηση widgets
  await DB().insertDymmy(); //εισαγωγή δεδομένων στην βαση
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    //ρυθμιση για portrait orientation συσκευής
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
        title: 'Thesis',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: SleepAppTheme.textTheme,
          platform: TargetPlatform.iOS,
        ),
        home: SleepHomeScreen()); //
    //αφου εχουν γινει οι αρχικοποιήσεις δημιουργία κεντρικής οθόνης εφαρμογής
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
