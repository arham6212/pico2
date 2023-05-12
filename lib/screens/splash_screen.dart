import 'package:pico2/common/common.dart';
import 'package:pico2/common/profile_roles.dart';
import 'package:pico2/common/route_list.dart';
import 'package:pico2/theme/colors.dart';
import 'package:pico2/utils/local_storage.dart';
import 'package:pico2/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void navigateToPage() async {
    if (await LocalStorage().isUserLoggedIn()) {
      var user = await LocalStorage().getUser();
      routeDecider(user?.role??'');

    } else {
      Get.offAllNamed(RouteList.login);
    }
  }

  @override
  void initState() {
    printLog('[Splashscreen] initState');
    navigateToPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kBlackColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const Center(
            child: Text(
          'PCM',
          style: TextStyle(fontSize: 36, color: Colors.white),
        )),
      ),
    );
  }
}
