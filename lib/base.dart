
import 'package:flutter/material.dart';
import 'package:task_app/task_app/features/authentication/controller/service/auth_service.dart';
import 'package:task_app/task_app/features/authentication/view/welcome.dart';
import 'package:task_app/task_app/features/projects/view/projects_view.dart';

class Base extends StatelessWidget {
    Base({super.key});

  final authServiceProvider = TaskAppAuthServiceProvider();

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
