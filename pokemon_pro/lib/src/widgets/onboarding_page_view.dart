import 'package:flutter/material.dart';
import '../widgets/page_control.dart';
import '../widgets/page_one.dart';
import '../widgets/page_two.dart';
import '../widgets/page_three.dart';
import '../widgets/onboarding_button.dart';

class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({super.key});

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  final _pageController = PageController(initialPage: 0);
  int _activePage = 0;
  final List<Widget> _pages = [
    const PageOne(),
    const PageTwo(),
    const PageThree(),
  ];

  void _updatePage(int page) {
    print('<!> page = $page');
    setState(() {
      _activePage = page;
      _pageController.animateToPage(
        page,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    });
  }

  void _skipPressed() {
    print('<!> Skip pressed!');
  }

  void _nextPressed() {
    print('<!> Next pressed!');
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
                    onPressed: _skipPressed,
                  ),
                  PageControl(
                      pagesCount: _pages.length,
                      activePage: _activePage,
                      onUpdatePage: _updatePage),
                  OnboardingButton(
                    title: 'Next',
                    onPressed: _nextPressed,
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
