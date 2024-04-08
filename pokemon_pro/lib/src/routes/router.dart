import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/about_us_page.dart';
import '../screens/dashboard_page.dart';
import '../screens/detail_page.dart';
import '../screens/onboarding_page.dart';
import '../models/pokemon_detail_model.dart';

abstract class AppRouteKeys {
  static const String onboarding = 'onboarding';
  static const String dashboard = 'dashboard';
  static const String detail = 'detail';
  static const String aboutUs = 'aboutUs';
}

// ignore: body_might_complete_normally_nullable, non_constant_identifier_names
Route<dynamic>? AppRouter(RouteSettings settings) {
  switch (settings.name) {
    case AppRouteKeys.aboutUs:
      return nativePageRoute(
        settings: settings,
        builder: (context) => const AboutUsPage(),
      );
    case AppRouteKeys.dashboard:
      return nativePageRoute(
        settings: settings,
        builder: (context) => const DashboardPage(),
      );
    case AppRouteKeys.onboarding:
      return nativePageRoute(
        settings: settings,
        builder: (context) => const OnboardingPage(),
      );
    case AppRouteKeys.detail:
      return nativePageRoute(
        settings: settings,
        builder: (context) =>
            DetailPage(details: settings.arguments as PokemonDetailModel),
      );
  }
}

PageRoute<T>? nativePageRoute<T>({
  required WidgetBuilder builder,
  required RouteSettings settings,
}) {
  if (Platform.isAndroid) {
    return MaterialPageRoute<T>(
      builder: builder,
      settings: settings,
    );
  } else {
    return CupertinoPageRoute<T>(
      builder: builder,
      settings: settings,
    );
  }
}
