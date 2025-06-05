import 'package:journal/auth/auth_store.dart';
import 'package:journal/auth/secure_storage.dart';

class LogoutService {
  static Future<void> logout() async {
    final hasKey = await secureStorage.containsKey(key: "authToken");
    if (hasKey) {
      await secureStorage.delete(key: "authToken");
      // Log user in
      authStore.logout();
    }
  }
}
