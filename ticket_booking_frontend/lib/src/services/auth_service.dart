import 'package:flutter/material.dart';

// PUBLIC_INTERFACE
class AuthService extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userEmail;

  bool get isLoggedIn => _isLoggedIn;
  String? get userEmail => _userEmail;

  // PUBLIC_INTERFACE
  Future<bool> login(String email, String password) async {
    // TODO: Integrate with real API.
    await Future.delayed(const Duration(seconds: 1));
    _isLoggedIn = true;
    _userEmail = email;
    notifyListeners();
    return true;
  }

  // PUBLIC_INTERFACE
  Future<bool> signup(String email, String password) async {
    // TODO: Implement real signup.
    await Future.delayed(const Duration(seconds: 1));
    _isLoggedIn = true;
    _userEmail = email;
    notifyListeners();
    return true;
  }

  // PUBLIC_INTERFACE
  Future<void> logout() async {
    _isLoggedIn = false;
    _userEmail = null;
    notifyListeners();
  }
}
