import 'package:flutter/material.dart';
import 'package:MoneyBuddy/LoginScreen.dart';
import 'package:logger/logger.dart';
import 'firebaseservice.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initialize();
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

