// ignore_for_file: depend_on_referenced_packages, avoid_print, unused_field

import 'package:daily_task/data-access/services/get_config.dart';
import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<void> signOut() async {
    try {
      // Remove the authentication token locally
      await GetConfig.removeAuthTokenLocally();
      print('Sign-out Successfully: token removed');
    } catch (e) {
      throw Exception('Error during sign-out: $e');
    }
  }
}
