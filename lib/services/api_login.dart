import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../framework.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';


// Future signIn(String email, String pass, context, prefs) async {
//
//   String errorMessage;
//   Uri loginUrl =  Uri.parse("https://localhost/api/v1/login");
//   final response = await http.post(
//
//     loginUrl,
//     headers: {"Accept": "Application/json"},
//     body: {"email": email, "password": pass},
//
//   );
//   if(response.statusCode == 200){
//     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const Framework()), (Route<dynamic> route) => false);
//   }else{
//     errorMessage = "Oops... incorrect email or password";
//     if (kDebugMode) {
//       print(response.body);
//     }
//     Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LoginScreen(errorMessage)));
//   }
// }
Future createVerificationCode(email)async{
  String params = "email=$email";
  Uri loginUrl =  Uri.parse("https://localhost/api/v1/passwords/forgot?$params");
  var response = await http.get(
    loginUrl,
    headers: {"Accept": "Application/json"},
  );
  if(response.statusCode == 200) {
    print(response.body);
    return true;
  }else{
    print(response.body);
    return false;
  }
}
Future confirmReset(code)async{
  const storage = FlutterSecureStorage();


  String params = "verify="+code;

  Uri apiUrl =  Uri.parse('https://localhost/api/v1/passwords/confirm?$params');
  var response = await http.get(
    apiUrl,
    headers: {"Accept": "Application/json"},
  );
  if(response.statusCode == 200) {
    await storage.write(key:"resetToken", value: code);
    print(response.body);
    return true;
  }else{
    print("nope");
    print(response.body);
    return false;
  }
}
// Future signUp(String email, String pass, String username, context) async {
//
//   Uri signUpUrl =  Uri.parse('https://localhost/api/v1/signup');
//   final response = await http.post(
//     signUpUrl,
//     headers: {"Accept": "Application/json"},
//     body: {"email":email, "password":pass, "username":username},
//   );
//   if(response.statusCode == 200) {
//     // await setLocals(response);
//     // await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass);
//     print(response.body);
//     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Framework()), (Route<dynamic> route) => false);
//     // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => SetGoals()), (Route<dynamic> route) => false);
//   }else{
//     print("nope");
//     print(response.body);
//     var jsonMessage = json.decode(response.body);
//     String error = jsonMessage["error"].toString();
//     print(error);
//     Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupScreen()));
//   }
// }
Future setPasswordAndLogin(password, context) async{
  final storage = FlutterSecureStorage();
  String? resetToken= await storage.read(key:"resetToken");
  Uri url =  Uri.parse('https://localhost/api/v1/passwords/reset');

  final response = await http.put(
    url,
    headers: {"Accept": "Application/json"},
    body: {"reset":resetToken, "password":password},
  );
  if(response.statusCode == 200) {
    // await setLocals(response);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Framework()), (Route<dynamic> route) => false);
    print(response.body);
    return true;
  }else{
    print("nope");
    print(response.body);
    return false;
  }
}