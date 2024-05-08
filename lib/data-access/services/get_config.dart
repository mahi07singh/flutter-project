// ignore_for_file:, avoid_print

import 'package:shared_preferences/shared_preferences.dart';

class GetConfig {
  static Future<Map<String, String>> getAPIConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String authToken = prefs.getString('authToken') ?? '';
    final Map<String, String> config = {
      'Authorization': ' $authToken',
      'x-device-id': prefs.getString('deviceId') ?? '',
      'Content-Type': 'application/json', // Default Content-Type
    };

    return config;
  }

  static Future<void> saveAuthToken(String authToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('authToken', authToken);
  }

  static Future<void> removeAuthTokenLocally() async {
    try {
      // Remove the authentication token locally
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('authToken');
    } catch (e) {
      print('Error removing auth token locally: $e');
    }
  }
}
