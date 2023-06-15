import 'package:flutter/material.dart';

class AddButtonWithFab extends StatefulWidget {
  const AddButtonWithFab({Key? key}) : super(key: key);

  @override
  _AddButtonWithFabState createState() => _AddButtonWithFabState();
}

class _AddButtonWithFabState extends State<AddButtonWithFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    // Start the animation when the widget is first built
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleAddButtonPressed() {
    setState(() {
      _count++;
    });

    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Button with Fab'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Trigger the action when the button is pressed
            _handleAddButtonPressed();
          },
          child: const Text('Add'),
        ),
      ),
      floatingActionButton: ScaleTransition(
        scale: _animation,
        child: FloatingActionButton.extended(
          onPressed: () {},
          label: Text('Count: $_count'),
          icon: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
