import 'dart:convert';

import 'package:pico2/models/user.dart';
import 'package:pico2/utils/tools.dart';
import 'package:get_storage/get_storage.dart';

import 'constants.dart';

class LocalStorage {
  static GetStorage storage = GetStorage();

// storage clear
  clearStorage() async {
    return await storage.erase();
  }

// check tutorial seen or not
  hasTutorialSeen() async {
    return await storage.read('TutorialSeen') == 'true' ? true : false;
  }

// set tutorial seen
  setTutorialSeen(seen) async {
    return await storage.write('TutorialSeen', seen.toString());
  }

  // getPincode() async {
  //   if (await storage.read('pincode') != null) {
  //     currentPincode = Postcode.fromJson(await storage.read('pincode'));
  //     return await storage.read('pincode');
  //   }
  //   return null;
  // }

  // setPincode(Map<String, dynamic> pincode) async {
  //   if (await storage.read('pincode') != null) {
  //     Postcode _currentPincode =
  //         Postcode.fromJson(await storage.read('pincode'));
  //     await pushNotification.unsubscribeTopics({
  //       'postcode': _currentPincode.id,
  //       'region': _currentPincode.regionId,
  //       'area': _currentPincode.areaId,
  //       'country': _currentPincode.countryId,
  //       'state': _currentPincode.stateId,
  //       'city': _currentPincode.cityId,
  //     });
  //   }
  //   currentPincode = Postcode.fromJson(pincode);
  //   if (user != null && accessToken != null && accessToken.isNotEmpty) {
  //     await pushNotification.subscribeUserTopics({
  //       'postcode': currentPincode.id,
  //       'region': currentPincode.regionId,
  //       'area': currentPincode.areaId,
  //       'country': currentPincode.countryId,
  //       'state': currentPincode.stateId,
  //       'city': currentPincode.cityId,
  //     });
  //   }
  //   return await storage.write('pincode', pincode);
  // }

  // removePincode() async {
  //   await pushNotification.unsubscribeTopics({
  //     'postcode': currentPincode.id,
  //     'region': currentPincode.regionId,
  //     'area': currentPincode.areaId,
  //     'country': currentPincode.countryId,
  //     'state': currentPincode.stateId,
  //     'city': currentPincode.cityId,
  //   });
  //   currentPincode = Postcode();
  //   return await storage.remove('pincode');
  // }

//check user is login or not
  isUserLoggedIn() async {
    return (await storage.read('userLoggedIn') == 'true');
  }

  setUserLoggedIn(bool value) async {
    return await storage.write('userLoggedIn', value.toString());
  }

// set user data to storage
  setUser(Map<String, dynamic> userData) async {
   try {
      Constants.user = User.fromJson(userData);
      await storage.write('User', json.encode(userData));
      return;
    } catch (e, s) {
      printLog(e);
      printLog(s);
    }
  }

  // get user data from storage!
  Future<User?> getUser() async {
    if (await storage.read('User') != null) {
      return Constants.user =
          User.fromJson(json.decode(await storage.read('User')));
    }
    return null;
  }

  // remove user from storage!
  removeUser() async {
    User? userData = await getUser();
    await storage.write('userLoggedIn', 'false');
    await storage.remove('User');
    // Constants.user = User('a','b');
    return userData;
  }

  // get data from storage! using key
  getLocalDataByKey(key) async {
    return await storage.read(key);
  }

  // set data from storage! using key
  setLocalDataByKey(key, value) async {
    return await storage.write(key, value.toString());
  }
}
