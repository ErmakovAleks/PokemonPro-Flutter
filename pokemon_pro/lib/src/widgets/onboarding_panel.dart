import 'package:flutter/material.dart';
import '../constants/pokoimages.dart';

class OnboardingPanel extends StatelessWidget {
  final String title;
  final String imageName;
  const OnboardingPanel(
      {required this.title, required this.imageName, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        children: [
          const SizedBox(
            height: 118,
          ),
          SizedBox(
            height: 328,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(PokoImages.bg),
                Image.asset(imageName),
              ],
            ),
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: Theme.of(context).primaryTextTheme.displayMedium,
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                margin: const EdgeInsets.only(left: 24, right: 24.0),
                child: Text(
                  '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.''',
                  style: Theme.of(context).primaryTextTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 176,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
