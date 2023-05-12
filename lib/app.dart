import 'package:pico2/screens/pallet_creation_screen.dart';
import 'package:pico2/screens/login_screen.dart';
import 'package:pico2/screens/picking_pallet_reach-truck_screen.dart';
import 'package:pico2/screens/splash_screen.dart';
import 'package:pico2/screens/reach_truck_dashboard.dart';
import 'package:pico2/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/config.dart';
import 'common/events.dart';
import 'common/route_list.dart';
import 'components/error-bottom_sheet.dart';
import 'screens/pcm_home_dashboard_screen.dart';
import 'utils/utility.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initialEvents();
  }

  void initialEvents() {
    eventBus.on<EventShowLoading>().listen((event) {
      Utility.circularDialog();
    });


    eventBus.on<EventCloseLoading>().listen((event) {
      Get.back();
    });

    eventBus.on<EventErrorSheet>().listen((event) {
      errorModalBottomSheet(event.message);
    });

    eventBus.on<EventAlertSheet>().listen((event) {
      alertModalBottomSheet(
        event.context,
        event.title,
        event.onPreceed,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: buildDarkTheme(),
        getPages: [
          GetPage(
              name: RouteList.splashScreen, page: () => const Splashscreen()),
          GetPage(name: RouteList.login, page: () => const LoginScreen()),
          GetPage(
              name: RouteList.pcmHome, page: () => const PcmHomeDashboardScreen()),
          GetPage(
              name: RouteList.palletCreation,
              page: () => const PalletCreationScreen()),
          GetPage(
              name: RouteList.reachTruckDashboard, page: () =>  ReachTruckDashboard()),
     GetPage(
              name: RouteList.pickingPalletScreen, page: () => const PickingPalletReachTruckScreen()),

        ],
        title: Configuration.appName,
        initialRoute: RouteList.splashScreen,
      ),
    );
  }
}
