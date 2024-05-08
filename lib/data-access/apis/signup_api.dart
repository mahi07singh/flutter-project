//api
// ignore_for_file: avoid_print, dead_code, use_rethrow_when_possible, prefer_const_declarations
import 'package:daily_task/data-access/api_path.dart';
import 'package:http/http.dart' as http;

class SignUpApi {
  static const String baseUrl = 'http://localhost:9000';

  Future<http.Response> signUp(Map<String, dynamic> values) async {
    try {
      // Use the concatenated URL
      final url = '$baseUrl${ApiEndPoints.authSignup}';
      final response = await http.post(Uri.parse(url), body: values);
      return response;
    } catch (error) {
      throw error;
    }
  }
}
