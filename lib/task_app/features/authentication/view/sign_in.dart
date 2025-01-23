import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_app/task_app/features/authentication/controller/state/auth_state_provider.dart';


class SignInView extends StatefulWidget {
  static String path = '/sign_in';

  const SignInView({super.key});


 @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthStateProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign into your account'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          spacing: 18,
          children: [
            TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email')),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<AuthStateProvider>().
                  signIn(email: _emailController.text,
                      password: _passwordController.text);
                  GoRouter.of(context).push('');
                },
                child: const Text('Sign In')),
            if (state.isLoading == true)
              CircularProgressIndicator(
                color: Colors.black,
              ),
          ],
        ),
      ),
    );
  }
}
