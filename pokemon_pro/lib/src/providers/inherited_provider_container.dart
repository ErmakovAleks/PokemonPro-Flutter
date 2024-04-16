import 'package:flutter/material.dart';

class InheritedProviderContainer<T> extends InheritedWidget {
  final T provider;
  const InheritedProviderContainer({
    super.key,
    required this.provider,
    required super.child,
  });

  static InheritedProviderContainer of<T>(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<InheritedProviderContainer<T>>()
        as InheritedProviderContainer<T>;
  }

  @override
  bool updateShouldNotify(InheritedProviderContainer oldWidget) {
    return provider != oldWidget.provider;
  }
}
