import 'package:flutter/material.dart';
import 'package:pokemon_pro/src/routes/routes.dart';
import 'page_control.dart';
import 'page_one.dart';
import 'page_two.dart';
import 'page_three.dart';
import 'onboarding_button.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
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
        duration: Duration(milliseconds: 200),
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
              padding: EdgeInsets.symmetric(horizontal: 24),
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OnboardingButton(
                    title: 'Skip',
                    onPressed: () =>
                        context.pageState.value = ActivePage.dashboard,
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
                        context.pageState.value = ActivePage.dashboard;
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
