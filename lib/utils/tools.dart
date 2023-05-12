import 'dart:developer' as d;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'constants.dart';

enum kSize { small, medium, large }

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static HexColor fromJson(String json) => HexColor(json);

  static List<HexColor> fromListJson(List listJson) =>
      listJson.map((e) => HexColor.fromJson(e as String)).toList();

  String toJson() => super.value.toRadixString(16);
}

class Tools {
  static String capitalize(String s) =>
      (s.isEmpty) ? '' : s[0].toUpperCase() + s.substring(1);

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static Future<void> launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static showSnackBar(ScaffoldState scaffoldState, message) {
    // ignore: deprecated_member_use
    // scaffoldState.showSnackBar(SnackBar(content: Text(message)));
  }

  static dynamic getValueByKey(Map<String, dynamic> json, String key) {
    try {
      List keys = key.split('.');
      var data = Map<String, dynamic>.from(json);
      if (keys[0] == '_links') {
        var links = json['listing_data']['_links'] ?? [];
        for (var item in links) {
          if (item['network'] == keys[keys.length - 1]) return item['url'];
        }
      }
      for (var i = 0; i < keys.length - 1; i++) {
        if (data[keys[i]] is Map) {
          data = data[keys[i]];
        } else {
          return null;
        }
      }
      if (data[keys[keys.length - 1]].toString().isEmpty) return null;
      return data[keys[keys.length - 1]];
    } catch (e) {
      printLog(e.toString());
      return 'Error when mapping $key';
    }
  }

  /// check tablet screen
  static bool isTablet(MediaQueryData query) {
    var size = query.size;
    var diagonal =
        sqrt((size.width * size.width) + (size.height * size.height));
    var isTablet = diagonal > 1100.0;
    return isTablet;
  }

  static double? formatDouble(num value) => value * 1.0;
}

printLog(dynamic data) {
  if (Constants.kLogEnable) {
    final now = DateTime.now().toUtc().toString().split(' ').last;
    d.log('[$now]${Constants.kLogTag}${data.toString()}');
  }
}
