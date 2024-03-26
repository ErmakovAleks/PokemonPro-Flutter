import 'package:flutter/material.dart';
import '/src/screens/dashboard_page.dart';
import '/src/screens/detail_page.dart';
import '/src/screens/about_us_page.dart';
import '/src/screens/onboarding_page.dart';
import '/src/routes/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListenableBuilder(
        listenable: context.pageState,
        builder: (context, _) {
          return Navigator(
            pages: [
              const MaterialPage(child: OnboardingPage()),
              if (context.pageState.value == ActivePage.dashboard)
                const MaterialPage(child: DashboardPage()),
              if (context.pageState.value == ActivePage.detail)
                const MaterialPage(child: DetailPage()),
              if (context.pageState.value == ActivePage.aboutUs)
                const MaterialPage(child: AboutUsPage()),
            ],
            onPopPage: (route, result) {
              if (!route.didPop(result)) {
                return false;
              }

              context.pageState.value = ActivePage.onboarding;
              return true;
            },
          );
        },
      ),
    );
  }
}
