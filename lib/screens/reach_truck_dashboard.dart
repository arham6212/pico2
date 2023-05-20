import 'package:flutter/material.dart';
import 'package:pico2/theme/colors.dart';
import 'package:pico2/widgets/custom_app_bar.dart';

import '../widgets/animated_logout_button.dart';
import '../widgets/custom_list_view.dart';

class ReachTruckDashboard extends StatelessWidget {
  ReachTruckDashboard({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> firstFourTiles = [
    {'name': 'Curing', 'count': 5},
    {'name': 'Recycle', 'count': 1},
    {'name': 'Glass', 'count': 14},
    {'name': 'Ceramic', 'count': 11},
  ];

  final List<Map<String, dynamic>> secondTiles = [
    {'name': 'Wh To Assembly Line', 'count': 1},
    {'name': 'Assembly Return to WH', 'count': 5},
  ];

  final List<Map<String, dynamic>> thirdTiles = [
    {'name': 'Finished Goods to WH', 'count': 1},
    {'name': 'WH to Loading', 'count': 2},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Reach Truck Jobs Pending'),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.grey.shade900],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                SectionDivider(color: kThemeOrangeColor),
                const SizedBox(height: 16),
                CustomListView(tiles: firstFourTiles),
                const SizedBox(height: 16),
                SectionDivider(color: kThemeOrangeColor),
                const SizedBox(height: 16),
                CustomListView(tiles: secondTiles),
                const SizedBox(height: 16),
                SectionDivider(color: kThemeOrangeColor),
                const SizedBox(height: 16),
                CustomListView(tiles: thirdTiles),
                const SizedBox(height: 20),
                AnimatedLogoutButton(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SectionDivider extends StatelessWidget {
  final Color color;

  const SectionDivider({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: ModalRoute.of(context)!.animation!,
          curve: Interval(0.4, 1.0, curve: Curves.easeInOut),
        ),
      ),
      child: Divider(
        thickness: 1,
        color: color,
      ),
    );
  }
}
