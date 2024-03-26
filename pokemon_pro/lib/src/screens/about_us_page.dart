import 'package:flutter/material.dart';
import 'package:pokemon_pro/src/routes/routes.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.pageState.value = ActivePage.dashboard,
          child: const Text('This is About Us Page!'),
        ),
      ),
    );
  }
}
