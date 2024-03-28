import 'package:flutter/material.dart';
import '/src/models/pokemon_detail.dart';

class InheritedDetailState extends InheritedWidget {
  final ValueNotifier<PokemonDetail?> detail;

  const InheritedDetailState(
      {super.key, required this.detail, required super.child});

  static InheritedDetailState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedDetailState>()
        as InheritedDetailState;
  }

  @override
  bool updateShouldNotify(InheritedDetailState oldWidget) {
    return detail != oldWidget.detail;
  }
}

extension InheritedDetailStateExt on BuildContext {
  ValueNotifier<PokemonDetail?> get detail =>
      InheritedDetailState.of(this).detail;
}
