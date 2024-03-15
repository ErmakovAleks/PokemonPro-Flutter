import 'package:flutter/material.dart';
import '../widgets/onboarding_panel.dart';
import '../constants/pokoimages.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardingPanel(
        title: 'Collect them all', imageName: PokoImages.largePokemons);
  }
}
