import 'package:flutter/material.dart';
import '../constants/pokoimages.dart';

class OnboardingPanel extends StatelessWidget {
  final String title;
  final String imageName;
  const OnboardingPanel({
    required this.title,
    required this.imageName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData styles = Theme.of(context);
    return Container(
      color: styles.colorScheme.primaryContainer,
      child: Column(
        children: [
          const SizedBox(
            height: 118,
          ),
          _images(),
          const Spacer(),
          _description(context),
        ],
      ),
    );
  }

  Widget _images() {
    return SizedBox(
      height: 328,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(PokoImages.bg),
          Image.asset(imageName),
        ],
      ),
    );
  }

  Widget _description(BuildContext context) {
    ThemeData styles = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: styles.primaryTextTheme.displayMedium,
        ),
        const SizedBox(
          height: 24,
        ),
        Container(
          margin: const EdgeInsets.only(left: 24, right: 24.0),
          child: Text(
            '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.''',
            style: styles.primaryTextTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 176,
        ),
      ],
    );
  }
}
