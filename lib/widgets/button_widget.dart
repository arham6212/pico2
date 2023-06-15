import 'package:flutter/material.dart';
import 'package:pico2/theme/colors.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget(
      {Key? key,
      required this.onButtonPressed,
      required this.buttonLabel,
      this.icon})
      : super(key: key);
  final VoidCallback onButtonPressed;
  final String buttonLabel;
  final Widget? icon;

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Material(
          color: kBlueColor,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: widget.onButtonPressed,
            borderRadius: BorderRadius.circular(10),
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.icon ??
                            const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                        const SizedBox(width: 8),
                        Text(
                          widget.buttonLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
