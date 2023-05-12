import 'package:pico2/common/events.dart';
import 'package:pico2/theme/colors.dart';
import 'package:pico2/utils/constants.dart';
import 'package:pico2/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/route_list.dart';

errorModalBottomSheet(String message, {TextStyle? style, double height = 230}) {
  Get.bottomSheet(
    Container(
      height: 210,
      color: Colors.transparent, //could change this to Color(0xFF737373),
      //so you don't have to change MaterialApp canvasColor
      child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Expanded(
                flex: 4,
                child: Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 50,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: style ??
                            const TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                color: Color(0xff646B71)),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: SizedBox(
                  width: Get.mediaQuery.size.width * 0.4,
                  child: Column(
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 0,
                        onPressed: () {
                          Get.back();
                        },
                        height: 45,
                        minWidth: Get.mediaQuery.size.width - 100,
                        child: const Text(
                          'Got it',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        color:  kThemeOrangeColor,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          )),
    ),
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100.0),
    ),
  );
}

alertModalBottomSheet(BuildContext context, String title, Function onProceed,
    {TextStyle? style, double height = 230}) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
      builder: (builder) {
        return StatefulBuilder(
          builder: (context, setState) => Container(
            // height: isRequestedOTP ? 300 : 200,
            color: Colors.transparent,
            child: Container(
                padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: kBlackColor),
                            )),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 60,
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 6,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Text('Back'),
                                color: Colors.red,
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 6,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: kBlueColor,
                                child: const Text('Proceed'),
                                onPressed: () async {
                                  Get.back();

                                  onProceed();
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )),
          ),
        );
      });
}

logoutAlertModalBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
      builder: (builder) {
        return StatefulBuilder(
          builder: (context, setState) => Container(
            height: 180,
            color: Colors.transparent,
            child: Container(
                padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              ".exit_message",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 60,
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 6,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Text('Back'),
                                color: Colors.white,
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 6,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Text('Strings.yes'),
                                onPressed: () async {
                                  Get.back();
                                  eventBus
                                      .fire(EventUserLogout(Constants.user));
                                  await LocalStorage().clearStorage();
                                  Get.offAllNamed(RouteList.login);
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )),
          ),
        );
      });
}
