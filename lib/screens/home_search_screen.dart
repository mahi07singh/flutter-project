import 'package:flutter/material.dart';

class PlaceholderWidget extends StatelessWidget {
  final String title;

  const PlaceholderWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'Placeholder for $title Screen',
      style: const TextStyle(
        fontFamily: 'RobotoSlab',
      ),
    ));
  }
}
