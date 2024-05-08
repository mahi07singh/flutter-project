// ignore_for_file: avoid_print, library_private_types_in_public_api, use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';
import 'package:daily_task/data-access/apis/get-auth-user-api.dart';
import 'package:daily_task/data-access/apis/sign_out_api.dart';
import 'package:flutter/material.dart';

class FeatcherScreen extends StatefulWidget {
  final String title;

  const FeatcherScreen({Key? key, required this.title}) : super(key: key);

  @override
  _FeatcherScreenState createState() => _FeatcherScreenState();
}

class _FeatcherScreenState extends State<FeatcherScreen> {
  final GetApiService getApiService = GetApiService();
  final AuthService authService = AuthService();
  String name = ''; // User ka naam state variable
  bool isUserSignedIn = false; // Flag to track user sign-in status

  @override
  void initState() {
    super.initState();
    if (!isUserSignedIn) {
      _getAuthUserData();
    }
  }

  Future<void> _handleSignOut(BuildContext context) async {
    try {
      await authService.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Sign-out successful'),
          backgroundColor: Colors.green,
        ),
      );
      // Navigate to the sign-in screen after successful sign-out
      Navigator.pushReplacementNamed(context, 'signin');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to sign out'),
          backgroundColor: Colors.red,
        ),
      );
      print('Failed to sign out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF87CEEB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3042E6),
        title: const Text(
          'FeatcherScreen',
          style: TextStyle(
            fontFamily: 'RobotoSlab',
            fontWeight: FontWeight.bold,
            color: Color(0xFF87CEEB),
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Color(0xFF87CEEB),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  name.isNotEmpty ? name.split(' ')[0] : 'Loading...',
                  style: TextStyle(
                    fontFamily: 'RobotoSlab',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF87CEEB),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('This is Home Screen!'),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(
                    name.isNotEmpty ? name : 'Loading...',
                    style: TextStyle(
                      fontFamily: 'RobotoSlab',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF87CEEB),
                    ),
                  ),
                  accountEmail: null,
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Color(0xFF00FF00),
                    child: Text(
                      // Replace 'M' with the first letter of the user's name
                      // in capital case
                      _getInitials(name),
                      style: TextStyle(
                        fontFamily: 'RobotoSlab',
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFF8C00),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF3042E6),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.settings,
                          color: Color(0xFF87CEEB),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'setting');
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Color(0xFF87CEEB),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the drawer
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ListTile(
              title: const Text('Drawer Item 1'),
              onTap: () {
                // Add functionality for the first drawer item
              },
            ),
            ListTile(
              title: const Text('Drawer Item 2'),
              onTap: () {
                // Add functionality for the second drawer item
              },
            ),
            ListTile(
              title: const Text('Sign Out'),
              onTap: () async {
                await _handleSignOut(context);
              },
            ),
            // Add more items as needed
          ],
        ),
      ),
    );
  }

// Function to make the API call
  void _getAuthUserData() async {
    try {
      // Only make the API call if the user is signed in for the first time
      if (!isUserSignedIn) {
        final response = await getApiService.getAuthUser();

        if (response.statusCode == 200) {
          // User ka naam API response se extract karein
          final Map<String, dynamic> responseData = json.decode(response.body);
          final String userNameFromApi = responseData['item']['user']['name'];

          setState(() {
            // Set user ka naam state variable mein
            name = userNameFromApi;
            isUserSignedIn = true; // Update the flag
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Auth user data fetched successfully",
                style: TextStyle(
                  fontFamily: 'RobotoSlab',
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else {
          throw Exception('Failed to fetch auth user data');
        }
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Login Failed. $error",
            style: const TextStyle(
              fontFamily: 'RobotoSlab',
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // Function to get the initials of the user's name
  String _getInitials(String name) {
    List<String> nameParts = name.split(' ');
    String initials = '';

    for (String part in nameParts) {
      if (part.isNotEmpty) {
        initials += part[0].toUpperCase();
      }
    }

    return initials;
  }
}
