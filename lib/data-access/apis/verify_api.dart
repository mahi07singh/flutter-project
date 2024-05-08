// ignore_for_file: prefer_const_declarations

import 'package:http/http.dart' as http;
import 'package:daily_task/data-access/api_path.dart';

class EmailVerificationApi {
  static const String baseUrl = 'http://localhost:9000';

  Future<http.Response> verifyEmail(String email) async {
    try {
      final url = '$baseUrl${ApiEndPoints.verifyEmail}';
      final response = await http.post(Uri.parse(url), body: {'email': email});
      return response;
    } catch (error) {
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }
}
