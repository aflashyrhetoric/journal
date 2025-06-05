import 'package:device_info_plus/device_info_plus.dart';
import 'package:journal/auth/auth_store.dart';
import 'package:journal/auth/secure_storage.dart';

import '../api/api_client.dart';
import 'dart:convert';

class LoginService {
  static Future<void> login(String email, String password) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final deviceName = await deviceInfo.iosInfo;

    final response = await ApiClient.post('/api/auth/login', {
      'email': email,
      'password': password,
      'device_name': deviceName.utsname.machine,
    });

    final Map<String, dynamic> json = jsonDecode(response.body);
    final token = json['token'];
    if (token == null) throw Exception('Token missing in response.');

    await secureStorage.write(key: "authToken", value: token);
    // Log user in
    authStore.login();
  }
}
