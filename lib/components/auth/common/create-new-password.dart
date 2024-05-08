// ignore: duplicate_ignore
// create_new_password.dart
// ignore_for_file: avoid_print, file_names, library_private_types_in_public_api, use_build_context_synchronously

import 'package:daily_task/data-access/apis/new-password-api.dart';
import 'package:flutter/material.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({Key? key}) : super(key: key);

  @override
  _CreateNewPasswordState createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF87CEEB),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.10,
                ),
                child: const Column(
                  children: [
                    Image(
                      image: AssetImage('assets/signup.webp'),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'Create New Password',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 33,
                        fontFamily: 'RobotoSlab',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.1,
                    top: MediaQuery.of(context).size.height * 0.40,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _newPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }

                              // Check if password contains at least one lowercase letter
                              if (!value.contains(RegExp(r'[a-z]'))) {
                                return 'Password should contain at least one lowercase letter';
                              }

                              // Check if password contains at least one uppercase letter
                              if (!value.contains(RegExp(r'[A-Z]'))) {
                                return 'Password should contain at least one uppercase letter';
                              }

                              // Check if password contains '@'
                              if (!value.contains('@')) {
                                return 'Password should contain "@" symbol';
                              }

                              // Check if password contains at least one digit
                              if (!value.contains(RegExp(r'\d'))) {
                                return 'Password should contain at least one digit';
                              }

                              // Check if password length is at least 8 characters
                              if (value.length < 8) {
                                return 'Password should be at least 8 characters long';
                              }

                              return null;
                            },
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'RobotoSlab',
                              fontWeight: FontWeight.w500,
                            ),
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "New Password",
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontFamily: 'RobotoSlab',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _confirmPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }

                              // Check if the confirmed password matches the new password
                              if (value != _newPasswordController.text) {
                                return 'Passwords do not match';
                              }

                              // Check if password contains at least one lowercase letter
                              if (!value.contains(RegExp(r'[a-z]'))) {
                                return 'Password should contain at least one lowercase letter';
                              }

                              // Check if password contains at least one uppercase letter
                              if (!value.contains(RegExp(r'[A-Z]'))) {
                                return 'Password should contain at least one uppercase letter';
                              }

                              // Check if password contains '@'
                              if (!value.contains('@')) {
                                return 'Password should contain "@" symbol';
                              }

                              // Check if password contains at least one digit
                              if (!value.contains(RegExp(r'\d'))) {
                                return 'Password should contain at least one digit';
                              }

                              // Check if password length is at least 8 characters
                              if (value.length < 8) {
                                return 'Password should be at least 8 characters long';
                              }

                              return null;
                            },
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'RobotoSlab',
                              fontWeight: FontWeight.w500,
                            ),
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Confirm Password",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontFamily: 'RobotoSlab',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  // Create an instance of CreateNewPasswordApi
                                  CreateNewPasswordApi createNewPasswordApi =
                                      CreateNewPasswordApi();

                                  // Validate form
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    // Call the API to create a new password
                                    try {
                                      final response =
                                          await createNewPasswordApi
                                              .createNewPassword(
                                        newPassword:
                                            _newPasswordController.text,
                                        confirmPassword:
                                            _confirmPasswordController.text,
                                      );

                                      if (response.statusCode == 200) {
                                        // Password successfully changed
                                        // Add any additional logic here
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "New Password Created Successfully",
                                              style: TextStyle(
                                                fontFamily:
                                                    'RobotoSlab', // Set the font family
                                                color: Colors.black,
                                                fontWeight: FontWeight
                                                    .w700, // Set the text color
                                              ),
                                            ),
                                            duration: Duration(seconds: 3),
                                            backgroundColor: Colors
                                                .green, // Set background color
                                            behavior: SnackBarBehavior
                                                .floating, // Use floating SnackBar
                                          ),
                                        );
                                      } else {
                                        // Failed to change password, show error message
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Signup Failed",
                                              style: TextStyle(
                                                fontFamily: 'RobotoSlab',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            duration: Duration(seconds: 3),
                                            backgroundColor: Colors.red,
                                            behavior: SnackBarBehavior.floating,
                                          ),
                                        );
                                      }
                                    } catch (error) {
                                      // Handle API call error
                                      print('Error: $error');
                                      _showErrorSnackBar(
                                          'Failed to create a new password');
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF3042E6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: const Text(
                                    'Confirm',
                                    style: TextStyle(
                                      fontSize: 23,
                                      color: Color(0xFF87CEEB),
                                      fontFamily: 'RobotoSlab',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'signin');
                                },
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF3042E6),
                                    fontFamily: 'RobotoSlab',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
