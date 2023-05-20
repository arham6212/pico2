import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../theme/colors.dart';

class ScanPalletCodeButton extends StatefulWidget {
  const ScanPalletCodeButton({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;

  @override
  _ScanPalletCodeButtonState createState() => _ScanPalletCodeButtonState();
}

class _ScanPalletCodeButtonState extends State<ScanPalletCodeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _playAnimation() {
    _animationController.forward();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      _animationController.reverse();
    });
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          primary: kThemeOrangeColor,
          onPrimary: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: _playAnimation,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Scan Pallet Code'),
            SizedBox(width: 8),
            Icon(Icons.qr_code_2),
          ],
        ),
      ),
    );
  }
}
