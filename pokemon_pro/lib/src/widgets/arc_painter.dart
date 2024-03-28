import 'package:flutter/material.dart';
import 'dart:math';
import '/src/constants/pokocolors.dart';

class ArcPainter extends CustomPainter {
  static const int maxBaseExperience = 608;
  final int baseExperience;

  const ArcPainter({required this.baseExperience});

  @override
  void paint(Canvas canvas, Size size) {
    final gradient = LinearGradient(
      colors: const [
        PokoColors.gradientStart,
        PokoColors.gradientFinish,
      ],
      stops: [0.0, baseExperience / maxBaseExperience],
    );

    final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    const startAngle = -pi / 2;
    final sweepAngle = -((2 * pi) / maxBaseExperience) * baseExperience;
    const useCenter = false;
    final paint = Paint()
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..shader = gradient.createShader(rect);

    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
