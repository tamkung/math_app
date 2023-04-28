// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:math_app/screens/login/changepassword.dart';
import 'package:math_app/screens/index.dart';
import 'package:math_app/screens/learning/learn1.dart';
import 'package:math_app/screens/profile.dart';
import 'package:splashscreen/splashscreen.dart';

import 'config/constant.dart';
import 'screens/home.dart';
import 'screens/login/login.dart';
import 'screens/login/register.dart';
import 'screens/game.dart';
import 'screens/video/videoscreen.dart';
import 'testTime/test.dart';

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
      home: SplashScreen(
        seconds: 5,
        image: Image.asset('assets/images/index-logo.png'),
        imageBackground: AssetImage('assets/images/intro-bg.png'),
        navigateAfterSeconds: const HomeScreen(),
        backgroundColor: Colors.white,
        photoSize: 100.0,
        loaderColor: Colors.red,
      ),
      routes: {
        'Index': (context) => IndexScreen(),
        'Register': (context) => RegisterScreen(),
        'Home': (context) => HomeScreen(),
        'Profile': (context) => Profile(),
        'ChangePassword': (context) => Changepassword(),
        'Learn1': (context) => Learn1(),
        'Video': (context) => VideoScreen(),
        'Game': (context) => Game(
              title: '',
            ),
      },
    );
  }
}
