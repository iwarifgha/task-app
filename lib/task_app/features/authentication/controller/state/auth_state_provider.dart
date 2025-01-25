import 'package:flutter/cupertino.dart';
import 'package:task_app/task_app/features/authentication/controller/service/auth_service.dart';
import 'package:task_app/task_app/features/user/common/pref/user_pref.dart';

class AuthStateProvider extends ChangeNotifier {
  final _userPreferences = UserPreferences();
  final _authServiceProvider = TaskAppAuthServiceProvider();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _hasOnboarded = false;
  bool get hasOnboarded => _hasOnboarded;

  _setSignedInState(bool value) async {
    final user = await _authServiceProvider.getAuthState();
    if (user != null) {
      _isSignedIn = await _userPreferences.setSignedInState(value);
      notifyListeners();
    }
    return;
  }

  _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> initializeAuthProvider() async {
    _hasOnboarded = await _userPreferences.getOnboardState();
    final isSignedIn = await _userPreferences.getSignedInState();
    _isSignedIn = isSignedIn;
    notifyListeners();
  }

  Future<void> setOnboardedState() async {
    final onBoardState = await _userPreferences.setOnboardedState();
    _hasOnboarded = onBoardState;
    notifyListeners();
  }

  Future<void> signIn({required String email, required String password}) async {
    _setLoading(true);
    try {
      await Future.delayed(Duration(seconds: 5));
      _authServiceProvider.signIn(email: email, password: password);
      _setSignedInState(true);
      print('You are signed in $_isSignedIn');
    } catch (e) {
      throw Exception('An error happened $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    _setLoading(true);
    try {
      await Future.delayed(Duration(seconds: 5));
      _authServiceProvider.signIn(email: email, password: password);
    } catch (e) {
      throw Exception('An error happened');
    } finally {
      _setLoading(false);
    }
  }

  void signOut() {
    try {
      _authServiceProvider.signOut();
      _setSignedInState(false);
      notifyListeners();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
