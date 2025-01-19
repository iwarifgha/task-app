import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task App'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
                'Welcome, Please sign in below. Already have an account? Then Sign in'),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/sign_in'),
                child: const Text('Sign in ')),
            TextButton(
                onPressed: () => Navigator.pushNamed(context, '/sign_up'),
                child: const Text('Sign up free account'))
          ],
        ),
      ),
    );
  }
}
