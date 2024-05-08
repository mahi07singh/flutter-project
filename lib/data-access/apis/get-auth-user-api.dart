// ignore_for_file: file_names, use_rethrow_when_possible, prefer_const_declarations

import 'package:daily_task/data-access/api_path.dart';
import 'package:daily_task/data-access/services/get_config.dart';
import 'package:http/http.dart' as http;

class GetApiService {
  static const String baseUrl = 'http://localhost:9000';

  Future<http.Response> getAuthUser() async {
    try {
      final url = '$baseUrl${ApiEndPoints.getAuthUser}';

      // Use GetConfig to get the API configuration headers
      final config = await GetConfig.getAPIConfig();

      // Make a GET request with the provided headers
      final response = await http.get(Uri.parse(url), headers: config);

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to fetch auth user data');
      }
    } catch (error) {
      throw error;
    }
  }
}
