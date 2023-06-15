import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pico2/screens/pallet_creation_screen.dart';

import '../models/pallet_scren_model.dart';
import '../widgets/animated_logout_button.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/pallet_card.dart';

class PcmHomeDashboardScreen extends StatelessWidget {
  const PcmHomeDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Pallet Creation/Management',
        showAction: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: PalletCard(
                      palletScreen: PalletScreen.palletScreens[0],
                      onTap: () {
                        _navigateToPalletCreation(context, index: 0);
                      },
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: PalletCard(
                      palletScreen: PalletScreen.palletScreens[1],
                      onTap: () {
                        _navigateToPalletCreation(context, index: 1);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AnimatedLogoutButton(),
            const SizedBox(height: 25),
            const Text(
              '© EXG Logistics',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPalletCreation(BuildContext context, {required int index}) {
    Get.to(
      PalletCreationScreen(
        index: index,
      ),
    );
  }
}
