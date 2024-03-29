import 'dart:math';
import 'package:flutter/material.dart';
import '../constants/pokoimages.dart';

class PokeSpinner extends StatefulWidget {
  const PokeSpinner({super.key});

  @override
  _PokeSpinnerState createState() => _PokeSpinnerState();
}

class _PokeSpinnerState extends State<PokeSpinner>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.repeat(reverse: false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SizedBox(
          height: 36,
          width: 36,
          child: Transform.rotate(
            angle: 2 * pi * _animation.value,
            child: Image.asset(PokoImages.spinner),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
