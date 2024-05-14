import 'package:daily_task/components/auth/common/verify_email.dart';
import 'package:daily_task/components/auth/common/signin.dart';
import 'package:daily_task/components/auth/common/signup.dart';
import 'package:daily_task/components/auth/common/verify_otp.dart';
import 'package:daily_task/components/auth/common/create-new-password.dart';
import 'package:daily_task/screens/home_screen.dart';
import 'package:daily_task/screens/setting.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const SignIn(),
    routes: {
      'signup': (context) => const SignUp(),
      'signin': (context) => const SignIn(),
      'forgetPassword': (context) => const VerifyEmail(),
      'verifyOtp': (context) => const VerifyOtp(),
      'createNewPassword': (context) => const CreateNewPassword(),
      'home': (context) => const HomeScreen(),
      'setting': (context) => const SettingScreen()
    },
  ));
}
