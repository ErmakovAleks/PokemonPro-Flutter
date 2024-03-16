import 'package:flutter/material.dart';

enum ActivePage {
  onboarding('/'),
  dashboard('/dashboard'),
  detail('/detail');

  final String path;

  const ActivePage(this.path);
}

class InheritedNavigatorState extends InheritedWidget {
  final ValueNotifier<ActivePage> pageState;

  const InheritedNavigatorState(
      {super.key, required this.pageState, required super.child});

  static InheritedNavigatorState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedNavigatorState>()
        as InheritedNavigatorState;
  }

  @override
  bool updateShouldNotify(InheritedNavigatorState oldWidget) {
    return pageState != oldWidget.pageState;
  }
}

extension InheritedNavigatorStateExt on BuildContext {
  ValueNotifier<ActivePage> get pageState =>
      InheritedNavigatorState.of(this).pageState;
}
