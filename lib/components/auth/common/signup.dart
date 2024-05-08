// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:daily_task/data-access/apis/signup_api.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late SignUpApi _apiService; // Late initialization

  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _apiService = SignUpApi(); // Initialize _apiService in initState
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
                      'Create Account',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 33,
                        fontFamily: 'RobotoSlab',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'This is a sample paragraph.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'RobotoSlab',
                        fontWeight: FontWeight.w400,
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
                            controller: _nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'RobotoSlab',
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Name",
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
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }

                              // Check if '@' is present
                              if (!value.contains('@')) {
                                return 'Email should contain "@" symbol';
                              }

                              // Check if '@' is present
                              if (!value.contains('gmail')) {
                                return 'Email should end with "gmail"';
                              }

                              // Check if '.com' is present
                              if (!value.toLowerCase().endsWith('.com')) {
                                return 'Email should end with ".com"';
                              }

                              return null;
                            },
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'RobotoSlab',
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Email",
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
                            controller: _passwordController,
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
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Password",
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
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    final Map<String, dynamic> signUpData = {
                                      'name': _nameController.text,
                                      'email': _emailController.text,
                                      'password': _passwordController.text,
                                    };

                                    try {
                                      final response =
                                          await _apiService.signUp(signUpData);

                                      if (response.statusCode == 201) {
                                        Navigator.pushNamed(context, 'signin');
                                        // Navigation successful
                                        // You can navigate to the next screen or perform any other action
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Signup Successful",
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
                                        // Signup failed
                                        // Show an error message or take appropriate action
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Signup Failed",
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
                                                .red, // Set background color
                                            behavior: SnackBarBehavior
                                                .floating, // Use floating SnackBar
                                          ),
                                        );
                                      }
                                    } catch (error) {
                                      // Handle error
                                      SnackBar(
                                        content: Text(
                                          "Signup Failed.  $error",
                                          style: const TextStyle(
                                            fontSize: 23, // Set the font size
                                            fontFamily:
                                                'RobotoSlab', // Set the font family
                                            color: Colors.black,
                                            fontWeight: FontWeight
                                                .w700, // Set the text color
                                          ),
                                        ),
                                        duration: const Duration(seconds: 3),
                                        backgroundColor:
                                            Colors.red, // Set background color
                                        behavior: SnackBarBehavior
                                            .floating, // Use floating SnackBar
                                      );
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
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  child: const Text(
                                    'Sign up',
                                    style: TextStyle(
                                      fontSize: 23,
                                      color: Color(0xFF87CEEB),
                                      fontFamily: 'RobotoSlab',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: const Color(0xFF3042E6),
                                child: IconButton(
                                  color: const Color(0xFF87CEEB),
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'signin');
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                    size: 30,
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
