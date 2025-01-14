
import 'package:flutter/material.dart';
import 'package:task_app/lib/task_app/features/authentication/controller/service/auth_service.dart';
import 'package:task_app/lib/task_app/features/authentication/view/welcome.dart';
import 'package:task_app/lib/task_app/features/tasks/view/home.dart';

class Base extends StatelessWidget {
    Base({super.key});

  final authServiceProvider = TodoAuthProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: authServiceProvider.getAuthState(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasData && snapshot.data != null){
            return const HomeView();
          } else {
            return const WelcomeView();
          }
        });
  }
}
