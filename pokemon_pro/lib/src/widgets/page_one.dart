import 'package:flutter/material.dart';
import '../widgets/onboarding_panel.dart';
import '../constants/pokoimages.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardingPanel(
        title: 'Find out who', imageName: PokoImages.largeSilgouette);
  }
}
