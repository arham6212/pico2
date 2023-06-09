import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pico2/theme/colors.dart';

void errorModalBottomSheet(String message,
    {TextStyle? style, double height = 230}) {
  Get.bottomSheet(
    Container(
      height: height,
      decoration: const BoxDecoration(
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
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 64,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: style ??
                    const TextStyle(
                      fontSize: 18,
                      height: 1.5,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
            const SizedBox(height: 32),
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
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Got it',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
            const SizedBox(height: 16),
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
