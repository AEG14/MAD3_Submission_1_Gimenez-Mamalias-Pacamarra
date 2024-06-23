import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:midterm_activity/src/enum/enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController with ChangeNotifier {
  // Static method to initialize the singleton in GetIt
  static void initialize() {
    GetIt.instance.registerSingleton<AuthController>(AuthController());
  }

  // Static getter to access the instance through GetIt
  static AuthController get instance => GetIt.instance<AuthController>();

  static AuthController get I => GetIt.instance<AuthController>();

  AuthState state = AuthState.unauthenticated;
  SimulatedAPI api = SimulatedAPI();

  login(String userName, String password) async {
    bool isLoggedIn = await api.login(userName, password);
    if (isLoggedIn) {
      state = AuthState.authenticated;
      //should store session
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      notifyListeners();
    }
  }

  ///write code to log out the user and add it to the home page.
  logout() async {
    // Clear session
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    state = AuthState.unauthenticated;
    notifyListeners();
  }

  ///must be called in main before runApp
  ///
  loadSession() async {
    // check secure storage method
    final prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn');
    if (isLoggedIn == true) {
      state = AuthState.authenticated;
    } else {
      state = AuthState.unauthenticated;
    }
    notifyListeners();
  }

  ///https://pub.dev/packages/flutter_secure_storage or any caching dependency of your choice like localstorage, hive, or a db
}

class SimulatedAPI {
  Map<String, String> users = {"testing": "12345678ABCabc!"};

  Future<bool> login(String userName, String password) async {
    await Future.delayed(const Duration(seconds: 4));
    if (users[userName] == null) throw Exception("User does not exist");
    if (users[userName] != password)
      throw Exception("Password does not match!");
    return users[userName] == password;
  }
}
