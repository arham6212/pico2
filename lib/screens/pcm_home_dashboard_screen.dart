import 'package:pico2/common/common_widgets.dart';
import 'package:pico2/common/route_list.dart';
import 'package:pico2/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/colors.dart';

class PcmHomeDashboardScreen extends StatefulWidget {
  const PcmHomeDashboardScreen({Key? key}) : super(key: key);

  @override
  State<PcmHomeDashboardScreen> createState() => _PcmHomeDashboardScreenState();
}

class _PcmHomeDashboardScreenState extends State<PcmHomeDashboardScreen> {
  List palletScreen = [

    {
      'crateName': 'Create Pallet',
      'color': kThemeOrangeColor,
    },
    {
      'crateName': 'Return Pallet',
      'color': kPinkColor,
    },
  ];


  init() async {
    // await crateControllers.getLocations();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCommonAppBar(title: 'Pallet Creation/Management'),
      body: Column(
        children: [
          const SizedBox(height: 25),
          Expanded(
            child: Center(
              child: ListView.separated(
                  separatorBuilder: (context, index) =>const SizedBox(height: 25),
                  itemCount: palletScreen.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(
                            RouteList.palletCreation , arguments: {'index':index});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: palletScreen[index]['color'],
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        height: Get.mediaQuery.size.height * 0.1,
                        child: Center(
                            child: Text(
                          palletScreen[index]['crateName'],
                          style: Get.textTheme.headline5,
                        )),
                      ),
                    );
                  }),
            ),
          ),
          const SizedBox(height: 20),
          MaterialButton(
            color: Colors.red,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () async {
              await LocalStorage().clearStorage();
              Get.offNamed(RouteList.login);
            },
            child: const Text('LogOut'),
          ),
          SizedBox(
            height: 25,
            child: Center(
              child: Text(
                'copyright@EXG Logistics',
                style: Get.textTheme.bodyText2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
