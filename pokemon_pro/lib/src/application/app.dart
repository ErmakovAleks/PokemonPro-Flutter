import 'package:flutter/material.dart';
import '../constants/pokothemes.dart';
import '../routes/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme(),
      darkTheme: darkTheme(),
      initialRoute: AppRouteKeys.onboarding,
      onGenerateRoute: AppRouter,
    );
  }
}
