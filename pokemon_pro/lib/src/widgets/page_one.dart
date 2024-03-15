import 'package:flutter/material.dart';
import '../widgets/onboarding_panel.dart';
import '../constants/pokoimages.dart';
import '../constants/pokocolors.dart';
import '../constants/pokofonts.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return const OnboardingPanel(
  //       title: 'Find out who', imageName: PokoImages.largeSilgouette);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PokoColors.wildSand,
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
                Image.asset(PokoImages.largeSilgouette),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(color: Colors.blue),
              const Text(
                'Find out who',
                style:
                    TextStyle(fontFamily: PokoFonts.paytoneOne, fontSize: 24.0),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                margin: EdgeInsets.only(left: 24, right: 24.0),
                child: const Text(
                  '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.''',
                  style: TextStyle(
                      fontFamily: PokoFonts.jakartaSans, fontSize: 15.0),
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
