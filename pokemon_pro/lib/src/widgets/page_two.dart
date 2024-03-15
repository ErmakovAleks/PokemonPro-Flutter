import 'package:flutter/material.dart';
import '../widgets/onboarding_panel.dart';
import '../constants/pokoimages.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardingPanel(
        title: 'Find out about the abilities',
        imageName: PokoImages.largePokemon);
  }
}
