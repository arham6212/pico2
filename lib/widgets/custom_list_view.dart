import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/route_list.dart';
import 'animated_list_tile.dart';

class CustomListView extends StatelessWidget {
  final List<Map<String, dynamic>> tiles;

  const CustomListView({Key? key, required this.tiles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => const SizedBox(height: 15),
      shrinkWrap: true,
      itemCount: tiles.length,
      itemBuilder: (_, index) {
        return AnimatedTile(
          leadingText: tiles[index]['name'],
          count: tiles[index]['count'],
          onTap: () {
            Get.toNamed(RouteList.pickingPalletScreen, arguments: {
              'appBarTitle': tiles[index]['name'],
            });
          },
        );
      },
    );
  }
}
