// ignore_for_file: dead_code, prefer_const_declarations, use_rethrow_when_possible

import 'package:daily_task/data-access/api_path.dart';
import 'package:daily_task/data-access/services/get_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://localhost:9000';

  Future<http.Response> signIn(Map<String, dynamic> values) async {
    try {
      // Concatenate the URL
      final url = '$baseUrl${ApiEndPoints.authSignin}';

      // Send POST request with values
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(values),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String authToken = responseData['authToken'] ?? '';
        await GetConfig.saveAuthToken(authToken);
      }

      return response;
    } catch (error) {
      throw error;
    }
  }
}
