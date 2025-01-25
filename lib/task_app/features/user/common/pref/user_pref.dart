import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String hasOnboardedKey = 'hasOnboarded';
  static const String isSignedInKey = 'isSignedIn';

  Future<bool> getOnboardState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(hasOnboardedKey) ?? false;
  }

  Future<bool> getSignedInState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(hasOnboardedKey) ?? false;
  }

  Future<bool> setSignedInState(bool isSignedIn) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(isSignedInKey, isSignedIn);
  }

  Future<bool> setOnboardedState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(hasOnboardedKey, true);
  }

}