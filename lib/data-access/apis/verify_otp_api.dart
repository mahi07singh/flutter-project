// ignore_for_file: prefer_const_declarations, avoid_print

import 'package:http/http.dart' as http;
import 'package:daily_task/data-access/api_path.dart';

class OtpVerificationApi {
  static const String baseUrl = 'http://localhost:9000';

  Future<http.Response> verifyOtp(
      {required String emailOtp,
      Map<String, dynamic>? additionalParams}) async {
    try {
      final url = '$baseUrl${ApiEndPoints.verifyOtp}';
      // Add any additional parameters required for OTP verification
      final Map<String, dynamic> requestBody = {
        'emailOtp': emailOtp,
        // Include additional parameters here
        ...?additionalParams,
      };

      final response = await http.post(Uri.parse(url), body: requestBody);
      return response;
    } catch (error) {
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }
}
