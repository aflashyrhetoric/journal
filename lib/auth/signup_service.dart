import '../api/api_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:convert';

class SignupService {
  static const _storage = FlutterSecureStorage();

  static Future<void> signup(String name, String email, String password) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    final deviceName = await deviceInfo.iosInfo;

    final response = await ApiClient.post('/api/auth/signup', {
      'name': name,
      'email': email,
      'password': password,
      'device_name': deviceName.utsname.machine,
    });

    final Map<String, dynamic> json = jsonDecode(response.body);
    final token = json['token'];
    if (token == null) throw Exception('Token missing in response.');

    await _storage.write(key: "authToken", value: token);
  }
}
