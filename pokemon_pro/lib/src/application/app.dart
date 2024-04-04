import 'package:flutter/material.dart';
import '../constants/pokofonts.dart';
import '../constants/pokocolors.dart';
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

  ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      primaryTextTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: PokoFonts.paytoneOne,
          fontSize: 36,
          color: PokoColors.abbey,
        ),
        displayMedium: TextStyle(
          fontFamily: PokoFonts.paytoneOne,
          fontSize: 24,
          color: PokoColors.abbey,
        ),
        displaySmall: TextStyle(
          fontFamily: PokoFonts.paytoneOne,
          fontSize: 19,
          color: PokoColors.abbey,
        ),
        bodyLarge: TextStyle(
          fontFamily: PokoFonts.jakartaSans,
          fontWeight: FontWeight.w800,
          fontSize: 34,
          color: PokoColors.abbey,
        ),
        bodyMedium: TextStyle(
          fontFamily: PokoFonts.jakartaSans,
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: PokoColors.abbey,
        ),
        bodySmall: TextStyle(
          fontFamily: PokoFonts.jakartaSans,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        labelMedium: TextStyle(
          fontFamily: PokoFonts.jakartaSans,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        labelSmall: TextStyle(
          fontFamily: PokoFonts.jakartaSans,
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: PokoColors.heather,
        ),
        headlineMedium: TextStyle(
          fontFamily: PokoFonts.jakartaSans,
          fontWeight: FontWeight.w500,
          fontSize: 24,
          color: PokoColors.abbey,
        ),
        headlineSmall: TextStyle(
          fontFamily: PokoFonts.jakartaSans,
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: PokoColors.heather,
        ),
      ),
      appBarTheme: const AppBarTheme(
        color: PokoColors.wildSand,
        iconTheme: IconThemeData(color: PokoColors.abbey),
        titleTextStyle: TextStyle(
          fontFamily: PokoFonts.jakartaSans,
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: PokoColors.abbey,
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: PokoColors.wildSand,
        primaryContainer: PokoColors.wildSand,
        secondaryContainer: PokoColors.abbey,
        tertiaryContainer: PokoColors.wildSand,
        onPrimaryContainer: PokoColors.gold,
      ),
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      primaryTextTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: PokoFonts.paytoneOne,
          fontSize: 36,
          color: PokoColors.wildSand,
        ),
        displayMedium: TextStyle(
          fontFamily: PokoFonts.paytoneOne,
          fontSize: 24,
          color: PokoColors.wildSand,
        ),
        displaySmall: TextStyle(
          fontFamily: PokoFonts.paytoneOne,
          fontSize: 19,
          color: PokoColors.wildSand,
        ),
        bodyLarge: TextStyle(
          fontFamily: PokoFonts.jakartaSans,
          fontWeight: FontWeight.w800,
          fontSize: 34,
          color: PokoColors.wildSand,
        ),
        bodyMedium: TextStyle(
          fontFamily: PokoFonts.jakartaSans,
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: PokoColors.wildSand,
        ),
        bodySmall: TextStyle(
          fontFamily: PokoFonts.jakartaSans,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        labelMedium: TextStyle(
          fontFamily: PokoFonts.jakartaSans,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        labelSmall: TextStyle(
            fontFamily: PokoFonts.jakartaSans,
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: PokoColors.heather),
        headlineMedium: TextStyle(
          fontFamily: PokoFonts.jakartaSans,
          fontWeight: FontWeight.w500,
          fontSize: 24,
          color: PokoColors.wildSand,
        ),
        headlineSmall: TextStyle(
          fontFamily: PokoFonts.jakartaSans,
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: PokoColors.heather,
        ),
      ),
      appBarTheme: const AppBarTheme(
        color: PokoColors.darkAbbey,
        iconTheme: IconThemeData(color: PokoColors.wildSand),
        titleTextStyle: TextStyle(
          fontFamily: PokoFonts.jakartaSans,
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: PokoColors.wildSand,
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: PokoColors.darkAbbey,
        primaryContainer: PokoColors.darkAbbey,
        secondaryContainer: PokoColors.heather,
        tertiaryContainer: PokoColors.wildSand,
        onPrimaryContainer: PokoColors.gold,
      ),
    );
  }
}
