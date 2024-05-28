import 'package:flutter/material.dart';
import 'package:flutter_first_project/LoginScreen.dart';
import 'package:logger/logger.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final logger = Logger();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoneyBuddy',
      home: LoginScreen(),
    );
  }
}

