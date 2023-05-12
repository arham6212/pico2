import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Utility {
  static circularDialog() {
    return Get.dialog(
      WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          title: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 15.0,
                ),
                 LoadingAnimationWidget.bouncingBall(color: Colors.white, size:100),
                Container(
                  margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: const Text(
                    '  Loading...',
                    style: TextStyle(
                        fontWeight: FontWeight.w300, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      name: 'loader',
      routeSettings: const RouteSettings(name: 'loader'),
      barrierDismissible: false,
    );
  }

  static alertBox(
      {required String titleText,
      required String successButtonText,
      required VoidCallback successButtonFunction,
      VoidCallback? cancelButtonFunction,
      String? cancelButtonText}) {
    return Get.dialog(
      WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          title: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 0.0, bottom: 10.0),
                  child: const Text(
                    'Are you sure you want to delete?',
                    style: TextStyle(
                        fontWeight: FontWeight.w300, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      color: Colors.green,
                      onPressed: successButtonFunction,
                      child: Text(successButtonText),
                    ),
                    const Spacer(),
                    MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      color: Colors.red,
                      onPressed: cancelButtonFunction ??
                          () {
                            Get.back();
                          },
                      child: Text(cancelButtonText ?? 'Cancel'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      name: 'loader',
      routeSettings: const RouteSettings(name: 'loader'),
      barrierDismissible: false,
    );
  }

  static getDistance(double? distance) {
    if (distance == null) {
      return distance.toString();
    }
    if (distance > (1000 * 100)) {
      // > 10 km
      return (distance / 1000).toStringAsFixed(2) + ' km';
    } else if (distance > 1000) {
      // 1 km
      return (distance / 1000).toStringAsFixed(2) + ' km';
    }
    return distance.toStringAsFixed(0) + 'm';
  }

  static String moneyFormatter(dynamic value) {
    if (value == '' || value == null) return '';
    double money = double.parse(value.toString());
    return NumberFormat.simpleCurrency(
            locale: 'hi', name: 'INR', decimalDigits: 0)
        .format(money);
  }
}
