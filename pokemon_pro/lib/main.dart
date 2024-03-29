import 'package:flutter/material.dart';
import 'src/models/pokemon_detail.dart';
import '/src/routes/detail_state.dart';
import '/src/routes/routes.dart';
import '/src/application/app.dart';

void main() {
  runApp(InheritedNavigatorState(
      pageState: ValueNotifier<ActivePage>(ActivePage.onboarding),
      child: InheritedDetailState(
          detail: ValueNotifier<PokemonDetail?>(null), child: const App())));
}
