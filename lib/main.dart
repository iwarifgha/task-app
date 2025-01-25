import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/routes.dart';
import 'package:task_app/task_app/features/authentication/controller/state/auth_state_provider.dart';
import 'package:task_app/task_app/features/projects/controller/state/projects_state_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authStateProvider = AuthStateProvider();
  await authStateProvider.initializeAuthProvider();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProjectsStateProvider()),
        ChangeNotifierProvider(create: (context) => authStateProvider),
      ],
      builder: (context, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRoutes,
        );
      }));
}
