import 'package:pico2/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

getCommonAppBar({required String title, Widget ?action}) {
  return AppBar(
    title: Text(title),
    actions: [
     action?? Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'EXG',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffEB8A46),
                  letterSpacing: 8),
            ),
          ],
        ),
      ),
    ],
  );
}

createToast(message,
    {Duration? duration,
    bool error = false,
    bool isDismissible = true,
    void Function(GetBar)? onTap,
    SnackPosition snackPosition = SnackPosition.TOP}) {
  return Get.snackbar(
    '',
    '',
    duration: const Duration(seconds: 2),
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
            child: const Icon(Icons.arrow_forward_ios, color: Colors.black),
          )
        : null,
    messageText: const Offstage(),
    backgroundColor: error ? Colors.red : kBlueColor,
    dismissDirection: SnackDismissDirection.HORIZONTAL,
    // dismissDirection: DismissDirection.horizontal,
    onTap: onTap,
    snackPosition: snackPosition,
    isDismissible: isDismissible,
  );
}

bool validateCrateName(String crateName) {
  bool firstCharacterIsString = RegExp(r'^[A-Za-z]+$').hasMatch(crateName[0]);
  bool secondCharacterIsString = RegExp(r'^[A-Za-z]+$').hasMatch(crateName[1]);
  return firstCharacterIsString && secondCharacterIsString;
}

bool validatePallet(String crateName) {
  return crateName.startsWith('P');
}
