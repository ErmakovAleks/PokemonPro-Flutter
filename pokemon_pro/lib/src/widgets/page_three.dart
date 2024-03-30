import 'package:flutter/material.dart';
import 'package:pokemon_pro/src/routes/router.dart';
import '../constants/pokocolors.dart';
import '/src/constants/pokofonts.dart';
import '../widgets/onboarding_panel.dart';
import '../constants/pokoimages.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Flexible(
          child: OnboardingPanel(
              title: 'Collect them all', imageName: PokoImages.largePokemons),
        ),
        Positioned(
          height: 152,
          left: 0,
          right: 0,
          bottom: 0,
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRouteKeys.dashboard);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.5)),
                    backgroundColor: PokoColors.gold,
                    shadowColor: PokoColors.darkGold,
                    elevation: 8,
                    fixedSize: const Size(200, 65),
                  ),
                  child: const Text(
                    'GO!',
                    style: TextStyle(
                      fontFamily: PokoFonts.jakartaSans,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  )),
              const SizedBox(height: 86),
            ],
          ),
        ),
      ],
    );
  }
}
