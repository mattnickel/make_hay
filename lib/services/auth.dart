
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

class AuthService {
//
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FireUser _fireUser(user)  {
    print(user.uid);
    return FireUser(uid: user.uid);

  }
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential response = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = response.user;
      return _fireUser(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential response = await _auth.signInAnonymously();
      User? user = response.user;
      return _fireUser(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signUp(String email, String password) async{
    try {
      UserCredential response = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = response.user;
      return _fireUser(user);
    } on FirebaseAuthException catch (error) {
      print(error.toString());
      return null;
    }
  }
  Future signOut() async {
    try {
      print ('sign out');
      await _auth.signOut();
      print('done');
    } on FirebaseAuthException catch (error) {
      print(error.toString());
      return null;
    }
  }
}
