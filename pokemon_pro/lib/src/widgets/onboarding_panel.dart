import 'package:flutter/material.dart';
import '../constants/pokocolors.dart';
import '../constants/pokoimages.dart';
import '../constants/pokofonts.dart';

class OnboardingPanel extends StatelessWidget {
  final String title;
  final String imageName;
  const OnboardingPanel(
      {required this.title, required this.imageName, super.key});

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
                Image.asset(imageName),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
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
