import 'package:get/get.dart';


class SearchController extends GetxController {
  List<dynamic> listItemsModel = [];
  List<dynamic> searchItemsList = [];
  bool showCloseIcon = false;

  void sortElementsByQuery(String searchQuery, List <dynamic> list) {
    searchItemsList = list
        .where((element) => element?.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    update();
  }
}
