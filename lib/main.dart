import 'package:flutter/material.dart';

import 'config/constant.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: pColor,
      ),
      home: LoginScreen(),
      routes: {
        'Register': (context) => RegisterScreen(),
        'Home': (context) => HomeScreen(),
        'Game': (context) => Game(
              title: 'dasds',
            ),
      },
    );
  }
}
