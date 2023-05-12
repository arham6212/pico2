import 'package:get/get.dart';
import 'package:pico2/models/pallets_create_model.dart';
import 'package:pico2/utils/end_points.dart';
import 'package:pico2/utils/request.dart';

import '../common/common_widgets.dart';
import '../common/events.dart';
import '../models/pallet_detail_model.dart';
import '../models/pallet_items_model.dart';
import '../utils/tools.dart';

class PalletCreationController extends GetxController {
  PalletsCreate? palletCreationModel;
  PalletDetailModel ?palletDetailModel;
  List<PalletItemsModel> palletItemsList = [];

  getPalletCreate({bool toUpdate = true}) async {
    try {
      var response = await Request.send(EndPoints.palletCreate);
      if (response != null) {
        if (response is Map<String, dynamic> && response.containsKey('data')) {
          palletCreationModel = PalletsCreate.fromJson(response);
        }
      }
    } catch (e, s) {
      printLog(e);
      printLog(s);
    }
    finally{
      if(toUpdate)update();
    }
  }

  bool isScannedPalletsFromList(String pallet, {bool returnP =false}) {
    var data = palletCreationModel?.data?.masterPallets
        ?.where((palletData) => (palletData.name == pallet));
    return returnP? true:((data?.length ?? 0) >= 1);
  }

   getPalletDetails(
      {required String palletName}) async {
    try {
      eventBus.fire(const EventShowLoading());
      var response = await Request.send(
        EndPoints.palletDetails,
        body: {'pallet_name': palletName},
      );
      if (response is String) {
        Get.back();
        eventBus.fire(EventErrorSheet(message: response));
        return false;
      }
      if (response.isNotEmpty) {
        Get.back();
        palletDetailModel = PalletDetailModel.fromJson(response);
        update();
        return true;
      } else {
        Get.back();

        createToast('This pallet is empty', error: true);
        return false;
      }
    } catch (e, s) {
      Get.back();
      printLog(e);
      printLog(s);
      eventBus.fire(
          EventErrorSheet(message: e.toString().replaceAll('Exception', '')));
      return false;
    }
  }
  storePalletCreation({required Map<String, dynamic> palletDetails, required bool update, String ?id }) async {
    try {
      eventBus.fire(const EventShowLoading());
      var response = await Request.send(update?EndPoints.updatePalletsCreation+(id??''):EndPoints.storePalletsCreation,
          connectionType: update?ConnectionType.put: ConnectionType.post,
          body:palletDetails);
      if (response is String) {
        Get.back();
        createToast(response, error: true);
        return false;
      }
      else if(response is Map && response.containsKey('data')){
        Get.back();
        return true ;
      }
      else if(response is Map && response.containsKey('error')){
        Get.back();
        createToast(response['error'],error: true);
        return false;
      }
      else{
        Get.back();
        return false ;
      }
    } catch (e, s) {
      Get.back();
      printLog(e);
      printLog(s);
      eventBus.fire(
          EventErrorSheet(message: e.toString().replaceAll('Exception', '')));
      return false;
    }
  }
}
