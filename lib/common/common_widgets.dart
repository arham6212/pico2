import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pico2/theme/colors.dart';

void createToast(
  String message, {
  Duration? duration,
  bool error = false,
  bool isDismissible = true,
  void Function(GetBar)? onTap,
  SnackPosition snackPosition = SnackPosition.TOP,
}) {
  Get.snackbar(
    '',
    '',
    duration: duration ?? const Duration(seconds: 2),
    borderRadius: 10,
    titleText: Text(
      message,
      textAlign: TextAlign.left,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    ),
    mainButton: onTap != null
        ? TextButton(
            onPressed: () {},
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          )
        : null,
    messageText: const Offstage(),
    backgroundColor: error ? Colors.red : kBlueColor,
    dismissDirection: SnackDismissDirection.HORIZONTAL,
    onTap: onTap,
    snackPosition: snackPosition,
    isDismissible: isDismissible,
  );
}

bool validateCrateName(String crateName) {
  final bool firstCharacterIsString =
      RegExp(r'^[A-Za-z]+$').hasMatch(crateName[0]);
  final bool secondCharacterIsString =
      RegExp(r'^[A-Za-z]+$').hasMatch(crateName[1]);
  return firstCharacterIsString && secondCharacterIsString;
}

bool validatePallet(String crateName) {
  return crateName.startsWith('P');
}
