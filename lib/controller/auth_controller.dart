import 'package:pico2/common/common.dart';
import 'package:pico2/common/events.dart';
import 'package:pico2/utils/end_points.dart';
import 'package:pico2/utils/local_storage.dart';
import 'package:pico2/utils/request.dart';
import 'package:pico2/utils/tools.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Future login({required Map<String, dynamic> loginDetails}) async {
    try {
      eventBus.fire(const EventShowLoading());
      var response = await Request.send(EndPoints.login, body: loginDetails);
      if (response != null) {
        if (response is String) {
          Get.back();

          eventBus.fire(const EventErrorSheet(message: 'Something went wrong'));
          return;
        }
        Get.back();
        if(response is Map && response.containsKey('error')){
          Get.back();
          eventBus.fire(EventErrorSheet(message: response['error']));
          return ;
        }
        if (response['data'] is Map) {
          await LocalStorage().setUserLoggedIn(true);
          await LocalStorage().setUser(response['data']);

          routeDecider(response['data']['role']);
        } else {
          return eventBus.fire(EventErrorSheet(message: response['message']));
        }
        update();
      } else {
        Get.back();
        eventBus.fire(EventErrorSheet(message: response['message']));
      }
    } catch (e, s) {
      // Get.back();
      printLog(e);
      printLog(s);
      eventBus.fire(EventErrorSheet(message: e.toString()));
    }
  }
}
