import 'package:flutter/material.dart';
import 'package:pokemon_pro/src/routes/router.dart';
import '../widgets/page_control.dart';
import '../widgets/page_one.dart';
import '../widgets/page_two.dart';
import '../widgets/page_three.dart';
import '../widgets/onboarding_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController(initialPage: 0);
  int _activePage = 0;
  final List<Widget> _pages = [
    const PageOne(),
    const PageTwo(),
    const PageThree(),
  ];

  void _updatePage(int page) {
    setState(() {
      _activePage = page;
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _activePage = index;
            });
          },
          itemCount: _pages.length,
          itemBuilder: (BuildContext context, int index) {
            return _pages[index % _pages.length];
          },
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OnboardingButton(
                    title: 'Skip',
                    onPressed: () =>
                        Navigator.of(context).pushNamed(AppRouteKeys.dashboard),
                  ),
                  PageControl(
                      pagesCount: _pages.length,
                      activePage: _activePage,
                      onUpdatePage: _updatePage),
                  OnboardingButton(
                    title: 'Next',
                    onPressed: () {
                      _activePage += 1;
                      if (_activePage >= _pages.length) {
                        Navigator.of(context).pushNamed(AppRouteKeys.dashboard);
                      } else {
                        _pageController.animateToPage(
                          _activePage % _pages.length,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 34,
            )
          ],
        ),
      ],
    ));
  }
}
