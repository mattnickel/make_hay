import 'package:flutter/material.dart';
import 'package:make_hay/screens/signup_screen.dart';
import '../framework.dart';
import 'login_screen.dart';

class Authenticate extends StatefulWidget  {

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LoginScreen(toggleView:  toggleView);
    } else {
      return SignupScreen(toggleView:  toggleView);
    }

    }
}
