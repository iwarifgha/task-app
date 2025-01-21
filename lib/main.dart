
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/task_app/features/authentication/view/sign_in.dart';
import 'package:task_app/task_app/features/authentication/view/sign_up.dart';
import 'package:task_app/task_app/features/authentication/view/welcome.dart';
import 'package:task_app/task_app/features/home/controller/state/home_state_provider.dart';
import 'package:task_app/task_app/features/home/view/add_task.dart';
import 'package:task_app/task_app/features/home/view/home.dart';
import 'base.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => HomeStateProvider()),

    ],
    builder: (context, _){
      return  MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/' : (context) =>  Base(),
          '/welcome' : (context) => const WelcomeView(),
          '/sign_up' : (context) => const SignUpView(),
          '/sign_in' : (context) => const SignInView(),
          '/home' : (context) => const HomeView(),
          '/add_task' : (context) => const AddTaskView(),
        },
      );
    }
  ));
}



