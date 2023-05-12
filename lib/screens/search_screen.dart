import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pico2/controller/search_controller.dart';
import '../common/common_widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, this.hintText, required this.data})
      : super(key: key);
  final List<dynamic> data;

  final String? hintText;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchController searchController = Get.put(SearchController());
  final TextEditingController searchTextController = TextEditingController();
  var searchNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      searchController.sortElementsByQuery('', widget.data);
      searchNode.requestFocus();
      searchController.update();

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: getCommonAppBar(title: ''),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            children: [
              TextFormField(
                controller: searchTextController,
                focusNode: searchNode,
                onChanged: (String val) {
                  if (val == '') {
                    searchController.searchItemsList = [];

                    searchController.showCloseIcon = false;
                    return searchController.update();
                  }
                  searchController.showCloseIcon=true;
                  searchController.sortElementsByQuery(val, widget.data);
                },
                decoration: InputDecoration(
                    suffixIcon: GetBuilder<SearchController>(
                      builder: (_) {
                        return InkWell(
                          onTap: (){
                              searchTextController.text='';

                            searchController.sortElementsByQuery('', widget.data);
                          },
                          child: Icon(searchController.showCloseIcon
                              ? Icons.close
                              : Icons.search_sharp),
                        );
                      }
                    ),
                    hintText: widget.hintText ?? "Enter Data",
                    hintStyle: const TextStyle(color: Colors.grey)),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GetBuilder<SearchController>(builder: (_) {
                  return ListView.separated(
                    separatorBuilder: (_, __) =>const SizedBox(height: 10),
                    itemCount: searchController.searchItemsList.length,
                    itemBuilder: (_, int index) {
                      return ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        tileColor: Colors.white,
                        textColor: Colors.black,
                        title: Text(
                            searchController.searchItemsList[index].name),
                        onTap: () {
                          Get.back(
                              result:
                                  searchController.searchItemsList[index]);
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
