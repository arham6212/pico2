import 'package:flutter/material.dart';

import '../theme/colors.dart';

class DropPalletButton extends StatefulWidget {
  const DropPalletButton({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  _DropPalletButtonState createState() => _DropPalletButtonState();
}

class _DropPalletButtonState extends State<DropPalletButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _colorAnimation = ColorTween(
      begin: kBlueColor,
      end: kBlueColor.withOpacity(0.8),
    ).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _playAnimation() {
    _animationController.forward();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    });
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: _colorAnimation.value,
          height: 55,
          onPressed: _playAnimation,
          child: const Text(
            'Drop Pallet',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }
}
