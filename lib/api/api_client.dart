import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:journal/auth/secure_storage.dart';

class ApiClient {
  static final String baseUrl = _resolveBaseUrl();
  static String _resolveBaseUrl() {
    final String isProductionEnv = dotenv.env['IS_PRODUCTION'] ?? "false";
    final bool isProduction = isProductionEnv == "true";
    return isProduction ? 'https://api.journal.com' : 'http://localhost';
  }

  /// Performs a GET request to the specified endpoint
  static Future<http.Response> get(String endpoint) async {
    final token = await secureStorage.read(key: "authToken");

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json', // <-- ADD THIS

      if (token != null) 'Authorization': 'Bearer $token',
    };

    // Print the token
    // print("Headers : $headers");

    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
    );

    if (response.statusCode >= 400) {
      throw Exception('HTTP ${response.statusCode}: ${response.body}');
    }

    return response;
  }

  /// Performs a POST request to the specified endpoint with the provided body.
  static Future<http.Response> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final token = await secureStorage.read(key: "authToken");

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

  static Future<http.Response> put(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final token = await secureStorage.read(key: "authToken");

    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final response = await http.put(
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
