import 'package:flutter/cupertino.dart';
import 'package:task_app/task_app/features/authentication/controller/service/auth_service.dart';

class AuthStateProvider extends ChangeNotifier {
  //when sign in is clicked show loading while api is working
  //when done dismiss loading.

  final _authServiceProvider = TaskAppAuthServiceProvider();

  void signOut() {
    try{
      _authServiceProvider.signOut();
      notifyListeners();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}