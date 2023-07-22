import 'package:flutter/material.dart';

class PatiAnimation extends StatefulWidget {
  @override
  _PatiAnimationState createState() => _PatiAnimationState();
}

class _PatiAnimationState extends State<PatiAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(40, 30 * _animationController.value),
          child: child,
        );
      },
      child: Image.asset(
        'images/png/pati.png',
        height: 40,
        width: 40,
      ),
    );
  }
}
