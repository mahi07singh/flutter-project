// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously

import 'package:daily_task/screens/home_learn_screen.dart';
import 'package:daily_task/screens/home_search_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Define colors for each icon
  final List<Color> _iconColors = [
    const Color.fromARGB(255, 66, 165, 245), // Home
    const Color.fromARGB(255, 66, 165, 245), // Screen 2
    const Color.fromARGB(255, 66, 165, 245), // Screen 3
    const Color.fromARGB(255, 66, 165, 245), // Screen 4
  ];

  final List<Widget> _screens = [
    const FeatcherScreen(title: 'Home'),
    const PlaceholderWidget(title: 'Learning'),
    const PlaceholderWidget(title: 'Screen 3'),
    const PlaceholderWidget(title: 'Screen 4'),
  ];

  // Set the default selected index to 0 (Home)
  _HomeScreenState() {
    _updateIconColors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF87CEEB),
      body: _screens[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(0xFF3042E6), // Set background color
          primaryColor: const Color(0xFF00FF00), // Set selected item color
          textTheme: Theme.of(context).textTheme.copyWith(
                // ignore: deprecated_member_use
                caption: const TextStyle(
                    fontFamily: 'RobotoSlab',
                    color: Color(0xFF87CEEB)), // Set unselected item color
              ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              // Update icon colors based on the selected index
              _updateIconColors();
            });
          },
          selectedItemColor: const Color(0xFF00FF00),
          unselectedItemColor: const Color(0xFF87CEEB),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            _buildBottomNavigationBarItem(Icons.home, 'Home', 0),
            _buildBottomNavigationBarItem(Icons.star, 'Screen 2', 1),
            _buildBottomNavigationBarItem(Icons.search, 'Screen 3', 2),
            _buildBottomNavigationBarItem(Icons.person, 'Screen 4', 3),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: CircleAvatar(
        backgroundColor: _iconColors[index],
        radius: 20.0, // Set radius for the circle
        child: Icon(icon,
            color: _currentIndex == index
                ? Color(0xFFFF8C00)
                : const Color(0xFF3042E6)),
      ),
      label: label,
    );
  }

  // Update icon colors based on the selected index
  void _updateIconColors() {
    for (int i = 0; i < _iconColors.length; i++) {
      _iconColors[i] = i == _currentIndex
          ? const Color(0xFF00FF00)
          : const Color(0xFF87CEEB);
    }
  }
}
