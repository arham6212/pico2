import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pico2/theme/colors.dart';

void errorModalBottomSheet(String message,
    {TextStyle? style, double height = 230}) {
  Get.bottomSheet(
    Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 64,
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: style ??
                    TextStyle(
                      fontSize: 18,
                      height: 1.5,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
            SizedBox(height: 32),
            SizedBox(
              width: Get.mediaQuery.size.width * 0.6,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  primary: kThemeOrangeColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Got it',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    ),
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );
}
