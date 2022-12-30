import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:make_hay/screens/authenticate.dart';
import 'package:provider/provider.dart';

import 'framework.dart';
import 'models/user.dart';

class Wrapper extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: _auth.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const Framework();
              } else {
                return Authenticate();
              }
            }
        )
    );
  }
}