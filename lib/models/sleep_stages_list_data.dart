import 'package:ptixiaki_sleep_stages/screens/first_screen.dart';

//Μοντέλο καρτών sleepstages αρχικής οθόνης
class SleepStagesData {
  String? imagePath;
  String? titleTxt;
  String? startColor;
  String? endColor;
  String? kacl;
  double? progress;

  SleepStagesData(
      {this.imagePath,
      this.titleTxt,
      this.startColor,
      this.endColor,
      this.kacl,
      this.progress});
}
