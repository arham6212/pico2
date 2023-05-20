import 'package:get/get.dart';
import 'package:pico2/common/profile_roles.dart';

import 'route_list.dart';

routeDecider(String role) {
  if (role == ProfileRoles.reachTruckRole) {
    Get.offNamed(RouteList.reachTruckDashboard);
  } else if (role == ProfileRoles.palletCreationRole) {
    Get.offNamed(RouteList.pcmHome);
  } else {
    Get.offNamed(RouteList.notEligible);
  }
}
