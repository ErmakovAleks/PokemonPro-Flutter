import 'package:flutter/material.dart';
import 'package:pokemon_pro/src/widgets/onboarding_view.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OnboardingView(),
    );
  }
}
