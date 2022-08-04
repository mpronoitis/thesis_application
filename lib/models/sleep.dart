// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Sleep {
  final String? went_to_bed;
  final String? woke_up;
  final String? in_bed;
  final double sleep_score;
  final String recording_day;
  final double? asleep_min;
  final double? asleep_after;
  final double? awake;
  final double? minutes_deep_sleep;
  final double? minutes_light_sleep;
  final double? minutes_rem_sleep;

  Sleep(
      {this.went_to_bed,
      this.woke_up,
      this.in_bed,
      required this.sleep_score,
      required this.recording_day,
      this.asleep_min,
      this.asleep_after,
      this.awake,
      this.minutes_deep_sleep,
      this.minutes_light_sleep,
      this.minutes_rem_sleep});

  factory Sleep.fromJson(Map<String, dynamic> json) {
    return Sleep(
        went_to_bed: json['went_to_bed'],
        woke_up: json['woke_up'],
        in_bed: json['in_bed'],
        sleep_score: json['sleep_score'],
        recording_day: json['recording_day'],
        asleep_min: json['asleep_min'],
        asleep_after: json['asleep_after'],
        awake: json['awake'],
        minutes_deep_sleep: json['minutes_deep_sleep'],
        minutes_light_sleep: json['minutes_light_sleep'],
        minutes_rem_sleep: json['minutes_rem_sleep']);
  }

  Map<String, Object> toJson() =>
      {'sleep_score': sleep_score, 'recording_day': recording_day};
}
