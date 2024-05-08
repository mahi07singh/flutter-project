// ignore_for_file:unused_field, use_build_context_synchronously

import 'package:daily_task/data-access/apis/signin_api.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF87CEEB), // Solid color background
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
                      image: AssetImage('assets/signin.webp'),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'Hello',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 33,
                        fontFamily: 'RobotoSlab',
                        fontWeight:
                            FontWeight.w600, // Use normal instead of italic
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
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }

                              // Check if '@' is present
                              if (!value.contains('@')) {
                                return 'Missing "@" symbol';
                              }

                              // Check if '@' is present
                              if (!value.contains('gmail')) {
                                return 'Missing "gmail"';
                              }

                              // Check if '.com' is present
                              if (!value.toLowerCase().endsWith('.com')) {
                                return 'Missing".com"';
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
                                return 'At least one lowercase letter';
                              }

                              // Check if password contains at least one uppercase letter
                              if (!value.contains(RegExp(r'[A-Z]'))) {
                                return 'At least one uppercase letter';
                              }

                              // Check if password contains '@'
                              if (!value.contains('@')) {
                                return 'Password should contain "@" symbol';
                              }

                              // Check if password contains at least one digit
                              if (!value.contains(RegExp(r'\d'))) {
                                return 'At least one digit';
                              }

                              // Check if password length is at least 8 characters
                              if (value.length < 8) {
                                return 'At least 8 characters long';
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
                                    // Form is valid, perform login
                                    Map<String, dynamic> signInData = {
                                      'email': _emailController.text,
                                      'password': _passwordController.text,
                                    };

                                    // Call the API
                                    try {
                                      final response =
                                          await _apiService.signIn(signInData);

                                      // Check the status code
                                      if (response.statusCode == 200) {
                                        Navigator.pushNamed(context, 'home');
                                        // Login successful
                                        // You can navigate to the next screen or perform any other action

                                        // Show SnackBar for success using ScaffoldMessenger
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Login Successful",
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
                                        // Login failed
                                        // Extract error message from the response body
                                        final Map<String, dynamic>
                                            responseData =
                                            json.decode(response.body);
                                        final String errorMessage =
                                            responseData['message'] ??
                                                'Unknown error';

                                        // Show SnackBar for error using ScaffoldMessenger
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Login Failed. $errorMessage",
                                              style: const TextStyle(
                                                fontFamily:
                                                    'RobotoSlab', // Set the font family
                                                color: Colors.black,
                                                fontWeight: FontWeight
                                                    .w700, // Set the text color
                                              ),
                                            ),
                                            duration:
                                                const Duration(seconds: 3),
                                            backgroundColor: Colors
                                                .red, // Set background color
                                            behavior: SnackBarBehavior
                                                .floating, // Use floating SnackBar
                                          ),
                                        );
                                      }
                                    } catch (error) {
                                      // Show SnackBar for error using ScaffoldMessenger
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Login Failed.  $error",
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
                                          backgroundColor: Colors
                                              .red, // Set background color
                                          behavior: SnackBarBehavior
                                              .floating, // Use floating SnackBar
                                        ),
                                      );
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(
                                      0xFF3042E6), // Set the background color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        5.0), // Set the button radius
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: const Text(
                                    'Sign in',
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
                                    Navigator.pushNamed(context, 'signup');
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                    size: 30, // Customize the size
                                  ),
                                ),
                              )
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
                                  Navigator.pushNamed(context, 'signup');
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize:
                                        18, // Adjust the font size as needed
                                    color: Color(0xFF3042E6),
                                    fontFamily: 'RobotoSlab',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, 'forgetPassword');
                                },
                                child: const Text(
                                  'Forget Password',
                                  style: TextStyle(
                                    fontSize:
                                        18, // Adjust the font size as needed
                                    color: Color(0xFF3042E6),
                                    fontFamily: 'RobotoSlab',
                                    fontWeight: FontWeight.w700,
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
                              GestureDetector(
                                onTap: () {},
                                child: Image.asset(
                                  'assets/facebookIcon.png', // Replace with your image asset path
                                  width: 100, // Customize the width
                                  height: 100, // Customize the height
                                ),
                              ),
                              Image.asset(
                                'assets/googleIcon.png', // Replace with your image asset path
                                width: 100, // Customize the width
                                height: 100, // Customize the height
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
