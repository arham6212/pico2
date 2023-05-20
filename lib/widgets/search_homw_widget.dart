import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchHomeWidget extends StatefulWidget {
  const SearchHomeWidget({
    Key? key,
    required this.textController,
    required this.onTap,
    required this.label,
  }) : super(key: key);

  final VoidCallback onTap;
  final String label;
  final TextEditingController textController;

  @override
  _SearchHomeWidgetState createState() => _SearchHomeWidgetState();
}

class _SearchHomeWidgetState extends State<SearchHomeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _scaleAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleFocusChange(bool hasFocus) {
    setState(() {
      _isFocused = hasFocus;
      if (_isFocused) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: widget.textController,
                  style: Get.textTheme.bodyText2?.copyWith(
                      color: _isFocused ? Colors.black : Colors.grey[800],
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  textAlignVertical: TextAlignVertical.center,
                  enabled: _isFocused,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    hintText: widget.label,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: BorderSide.none,
                    ),
                    // prefixIcon: Icon(
                    //   Icons.search,
                    //   color: Colors.grey,
                    // ),
                    // suffixIcon: InkWell(
                    //   onTap: () {
                    //     widget.textController.clear();
                    //   },
                    //   child: Container(
                    //     padding: const EdgeInsets.all(8),
                    //     child: Icon(
                    //       Icons.clear,
                    //       color: Colors.grey,
                    //       size: 18,
                    //     ),
                    //   ),
                    // ),
                  ),
                  readOnly: true,
                  onTap: () {
                    if (!_isFocused) {
                      _handleFocusChange(true);
                    }
                  },
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: _isFocused ? 8 : 0,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
