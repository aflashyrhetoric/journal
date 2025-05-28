import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  static final String baseUrl = _resolveBaseUrl();
  static String _resolveBaseUrl() {
    final String isProductionEnv = dotenv.env['IS_PRODUCTION'] ?? "false";
    final bool isProduction = isProductionEnv == "true";
    return isProduction ? 'https://api.journal.com' : 'http://localhost';
  }

  static const _storage = FlutterSecureStorage();

  static Future<http.Response> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final token = await _storage.read(key: "authToken");

    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode >= 400) {
      throw Exception('HTTP ${response.statusCode}: ${response.body}');
    }

    return response;
  }

  // You can add GET, PUT, DELETE here as needed.
}
