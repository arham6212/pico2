import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pico2/common/common_widgets.dart';
import 'package:pico2/common/route_list.dart';
import 'package:pico2/theme/colors.dart';

import '../utils/local_storage.dart';

class ReachTruckDashboard extends StatelessWidget {
  ReachTruckDashboard({Key? key}) : super(key: key);
  List firs4tiles = [
    {'name': 'Curing', 'count': 5},
    {'name': 'Recycle', 'count': 1},
    {'name': 'Glass', 'count': 14},
    {'name': 'Ceramic', 'count': 11},
  ];
  List secondTiles = [
    {'name': 'Wh To Assembly Line', 'count': 1},
    {'name': 'Assembly Return to WH', 'count': 5},

  ];
  List thirdTiles = [
    {'name': 'Finished Goods to WH', 'count': 1},
    {'name': 'WH to Loading', 'count': 2},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCommonAppBar(title: 'Reach Truck Jobs Pending'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Divider(thickness: 1, color: kThemeOrangeColor),
              const SizedBox(height: 16),
              ListView.separated(
                  physics: const ScrollPhysics(),
                  separatorBuilder: (_, __) => const SizedBox(height: 15),
                  shrinkWrap: true,
                  itemCount: firs4tiles.length,
                  itemBuilder: (_, index) {
                    return CustomListTileForReachTruckDashboard(
                      leadingText: firs4tiles[index]['name'],
                      count: firs4tiles[index]['count'],
                      callback: () {
                        Get.toNamed(RouteList.pickingPalletScreen);
                      },
                    );
                  }),
              const SizedBox(height: 16),
              Divider(thickness: 1, color: kThemeOrangeColor),
              const SizedBox(height: 16),
              ListView.separated(
                  physics: const ScrollPhysics(),
                  separatorBuilder: (_, __) => const SizedBox(height: 15),
                  shrinkWrap: true,
                  itemCount: secondTiles.length,
                  itemBuilder: (_, index) {
                    return CustomListTileForReachTruckDashboard(
                      leadingText: secondTiles[index]['name'],
                      count: secondTiles[index]['count'],
                      callback: () {
                        Get.toNamed(RouteList.pickingPalletScreen);
                      },                    );
                  }),
              const SizedBox(height: 16),
              Divider(thickness: 1, color: kThemeOrangeColor),
              const SizedBox(height: 16),
              ListView.separated(
                  physics: const ScrollPhysics(),
                  separatorBuilder: (_, __) => const SizedBox(height: 15),
                  shrinkWrap: true,
                  itemCount: thirdTiles.length,
                  itemBuilder: (_, index) {
                    return CustomListTileForReachTruckDashboard(
                      leadingText: thirdTiles[index]['name'],
                      count: thirdTiles[index]['count'],
                      callback: () {
                        Get.toNamed(RouteList.pickingPalletScreen);
                      },                    );
                  }),
              const SizedBox(height: 20),
              MaterialButton(
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () async {
                  await LocalStorage().clearStorage();
                  Get.offNamed(RouteList.login);
                },
                child: const Text('LogOut'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTileForReachTruckDashboard extends StatelessWidget {
  const CustomListTileForReachTruckDashboard({
    Key? key,
    required this.leadingText,
    required this.count,
    required this.callback,
  }) : super(key: key);

  final String leadingText;
  final int count ;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: callback,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(10)),
      title: Text(leadingText),
      trailing: Text(
        count.toString(),
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
