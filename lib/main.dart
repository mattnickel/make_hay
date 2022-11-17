import 'package:flutter/material.dart';
import 'package:make_hay/screens/login_screen.dart';
import 'framework.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Make Hay',
      theme: ThemeData(
        primaryColor: Colors.black,
        backgroundColor: Colors.black,
        scaffoldBackgroundColor:Colors.black,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),

      ),
      home: const LoginScreen(''),
    );
  }
}