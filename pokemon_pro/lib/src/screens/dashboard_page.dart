import 'package:flutter/material.dart';
import 'package:pokemon_pro/src/routes/routes.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.pageState.value = ActivePage.detail,
          child: const Text('This is Dashboard Page!'),
        ),
      ),
    );
  }
}
