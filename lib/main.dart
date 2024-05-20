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

      /// TODO Replace with your first screen class name
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("My first flutter app"),
    );
  }
}
