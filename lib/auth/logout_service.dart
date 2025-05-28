import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LogoutService {
  static const _storage = FlutterSecureStorage();

  static Future<void> logout() async {
    final hasKey = await _storage.containsKey(key: "authToken");
    if (hasKey) {
      await _storage.delete(key: "authToken");
    }
  }
}
