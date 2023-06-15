import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/colors.dart';
import 'exg_text_widget.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Widget? action;
  final bool? showAction;
  final Widget? leading;
  final VoidCallback? onBackButtonTap;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.action,
    this.onBackButtonTap,
    this.leading,
    this.showAction = true,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.action != null) {
      _animationController.forward();
    }

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      leading: widget.showAction == true
          ? (widget.leading ??
              GestureDetector(
                  onTap: widget.onBackButtonTap ?? () => Get.back(),
                  child: const Icon(Icons.arrow_back_ios_new)))
          : SizedBox.shrink(),
      actions: [
        if (widget.action != null)
          AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _fadeAnimation.value,
                child: child!,
              );
            },
            child: widget.action,
          )
        else
          const EXGTextWidget(),
      ],
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      // Remove the app bar's shadow
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              kBlueColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}
