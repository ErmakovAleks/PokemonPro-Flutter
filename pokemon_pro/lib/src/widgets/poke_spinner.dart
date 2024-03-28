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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(seconds: 1),
      builder: (context, value, child) {
        return Container(
          height: 36,
          width: 36,
          child: Transform.rotate(
            angle: 2 * pi * value,
            child: Image.asset(PokoImages.spinner),
          ),
        );
      },
      onEnd: () {
        _controller.reset();
        _controller.forward();
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
