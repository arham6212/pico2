import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pico2/models/user.dart';

class Constants {
  static const pageSize = 10;
  static const kLogEnable = true;
  static const kLogTag = '[PCM]';
  static String listEndMessage = 'It looks like you\'ve reached the end';
  static String appVersion = '1.0.0';
  static DateTime selectedDate = DateTime.now();
  static String pushToken = '';

  static late User user;
  static Map<String, dynamic> commonParams = <String, dynamic>{};
  static Map<String, dynamic> headers = <String, dynamic>{};
  static double defaultLatitude = -34.930466;
  static double defaultLongitude = 138.596260;
  static bool showSkipLoginButton = false;
  static Size deviceSize = Get.mediaQuery.size;
  static Color? shimmerBaseColor = Colors.grey[200];
  static Color? shimmerHighlightColor = Colors.grey[350];
}
