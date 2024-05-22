import 'package:flutter/material.dart';
import 'package:flutter_first_project/LoginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WemosConnect',
      home: LoginScreen(),
    );
  }
}

