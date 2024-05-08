// ignore_for_file: file_names, prefer_const_declarations, avoid_print, use_rethrow_when_possible

import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateNewPasswordApi {
  static const String baseUrl = 'http://localhost:9000';

  Future<http.Response> createNewPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      // Use the concatenated URL
      final url = '$baseUrl/v1/auth/create-new-password';

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      final Map<String, dynamic> body = {
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      };

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );

      return response;
    } catch (error) {
      throw error;
    }
  }
}

class ApiError {
  final String message;

  ApiError({required this.message});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      message: json['message'] ?? 'An error occurred',
    );
  }
}
