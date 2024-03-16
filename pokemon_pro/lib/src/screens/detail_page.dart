import 'package:flutter/material.dart';
import 'package:pokemon_pro/src/routes/routes.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.pageState.value = ActivePage.onboarding,
          child: const Text('This is Detail Page!'),
        ),
      ),
    );
  }
}
