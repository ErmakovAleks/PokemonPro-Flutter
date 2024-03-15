import 'package:flutter/material.dart';
import '../constants/pokocolors.dart';

class OnboardingButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const OnboardingButton(
      {required this.title, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 15,
            color: PokoColors.gold,
            fontFamily: 'CupertinoSystemText',
            fontWeight: FontWeight.w800),
      ),
    );
  }
}
