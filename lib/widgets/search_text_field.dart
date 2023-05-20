import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/search_controller.dart';

class SearchTextField extends StatefulWidget {
  final List<dynamic> data;
  final String? hintText;

  const SearchTextField({Key? key, required this.data, this.hintText})
      : super(key: key);

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final SearchController searchController = Get.put(SearchController());
  final TextEditingController searchTextController = TextEditingController();
  late FocusNode searchNode;

  @override
  void initState() {
    super.initState();
    searchNode = FocusNode();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      searchController.sortElementsByQuery('', widget.data);
      searchNode.requestFocus();
      searchController.update();
    });
  }

  @override
  void dispose() {
    searchNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: searchTextController,
        focusNode: searchNode,
        onChanged: (String val) {
          if (val.isEmpty) {
            searchController.searchItemsList.clear();
            searchController.showCloseIcon = false;
            searchController.sortElementsByQuery('', widget.data);
          } else {
            searchController.showCloseIcon = true;
            searchController.sortElementsByQuery(val, widget.data);
          }
          searchController.update();
        },
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          hintText: widget.hintText ?? 'Enter Data',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: GetBuilder<SearchController>(
            builder: (_) {
              return Visibility(
                visible: searchController.showCloseIcon,
                child: InkWell(
                  onTap: () {
                    searchTextController.clear();
                    searchController.searchItemsList.clear();
                    searchController.showCloseIcon = false;
                    searchController.sortElementsByQuery('', widget.data);
                  },
                  child: const Icon(Icons.close, color: Colors.grey),
                ),
              );
            },
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
