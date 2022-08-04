import 'package:ptixiaki_sleep_stages/screens/first_screen.dart';

class MealsListData {
  String? imagePath;
  String? titleTxt;
  String? startColor;
  String? endColor;
  String? kacl;
  double? progress;

  MealsListData(
      {this.imagePath,
      this.titleTxt,
      this.startColor,
      this.endColor,
      this.kacl,
      this.progress});

  // static List<MealsListData> tabIconsList = <MealsListData>[
  //   MealsListData(
  //     // imagePath: 'assets/sleep_app/breakfast.png',
  //     titleTxt: 'Deep sleep',
  //     kacl: getConversion(homeData[0].minutes_deep_sleep!),
  //     progress: getPercentStage(homeData[0].minutes_deep_sleep!),
  //     startColor: '#FA7D82',
  //     endColor: '#FFB295',
  //   ),
  //   MealsListData(
  //     imagePath: 'assets/sleep_app/lunch.png',
  //     titleTxt: 'Light sleep',
  //     kacl: getConversion(homeData[0].minutes_light_sleep!),
  //     progress: getPercentStage(homeData[0].minutes_light_sleep!),
  //     startColor: '#738AE6',
  //     endColor: '#5C5EDD',
  //   ),
  //   MealsListData(
  //     imagePath: 'assets/sleep_app/snack.png',
  //     titleTxt: 'REM sleep',
  //     kacl: getConversion(homeData[0].minutes_rem_sleep!),
  //     progress: getPercentStage(homeData[0].minutes_rem_sleep!),
  //     startColor: '#FE95B6',
  //     endColor: '#FF5287',
  //   ),
  //   MealsListData(
  //     imagePath: 'assets/sleep_app/dinner.png',
  //     titleTxt: 'Awake time',
  //     kacl: homeData[0].awake.toString(),
  //     progress: (homeData[0].awake! / homeData[0].asleep_min!),
  //     startColor: '#6F72CA',
  //     endColor: '#1E1466',
  //   ),
  // ];
}
