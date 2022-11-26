import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:make_hay/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:make_hay/services/auth.dart';
import 'package:make_hay/wrapper.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'models/user.dart';

Future<void> main() async {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          highlightColor: Colors.black,

        ),
        home: Wrapper(),
      );
  }
}