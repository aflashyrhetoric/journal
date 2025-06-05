import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journal/auth/secure_storage.dart';

class AuthStore extends ChangeNotifier {
  bool isLoggedIn = false;
  bool isInitialized = false;

  AuthStore() {
    initialize();
  }

  void initialize() async {
    final token = await secureStorage.read(key: "authToken");

    isLoggedIn = token != null && token.isNotEmpty;
    isInitialized = true;
    notifyListeners();
  }

  void login() {
    isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    isLoggedIn = false;
    notifyListeners();
  }
}

final AuthStore authStore = AuthStore();

final authStoreProvider = ChangeNotifierProvider<AuthStore>((ref) => authStore);
