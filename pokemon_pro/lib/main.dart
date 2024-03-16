import 'package:flutter/material.dart';
import '/src/routes/routes.dart';
import '/src/application/app.dart';

void main() {
  runApp(InheritedNavigatorState(
      pageState: ValueNotifier<ActivePage>(ActivePage.onboarding),
      child: const App()));
}
