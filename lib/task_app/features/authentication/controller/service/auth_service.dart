import 'package:firebase_auth/firebase_auth.dart';

import '../../../../services/api/firebase/firebase_auth_service.dart';

class TodoAuthProvider {
  final firebaseAuthProvider = FirebaseAuthService();

  User getCurrentUser() {
    try {
      final user = firebaseAuthProvider.getUser();
      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User?> getAuthState() async {
    try {
      final status = await firebaseAuthProvider.getAuthState();
      return status;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await firebaseAuthProvider.signIn(email: email, password: password);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      await firebaseAuthProvider.signUp(email: email, password: password);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signOut({required String email, required String password}) async {
    try {
      await firebaseAuthProvider.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
