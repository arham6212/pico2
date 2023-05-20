import 'package:flutter/material.dart';

import '../theme/colors.dart';

class PalletScreen {
  final String crateName;
  final Color color;
  final IconData icon;

  PalletScreen({
    required this.crateName,
    required this.color,
    required this.icon,
  });

  static List<PalletScreen> palletScreens = [
    PalletScreen(
      crateName: 'Create Pallet',
      color: kThemeOrangeColor,
      icon: Icons.add,
    ),
    PalletScreen(
      crateName: 'Return Pallet',
      color: kBlueColor,
      icon: Icons.arrow_back,
    ),
  ];
}
