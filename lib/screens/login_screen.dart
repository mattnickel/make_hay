import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:make_hay/screens/signup_screen.dart';
import 'package:make_hay/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../framework.dart';
import '../screen_widgets/signup_signin_widgets.dart';
import '../services/api_login.dart';




class LoginScreen extends StatefulWidget {
  final Function toggleView;
  LoginScreen({required this.toggleView});
  @override

  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  late SharedPreferences prefs;
  late Image backgroundImage;
  bool _isLoading = false;
  bool _isEnabled = false;
  late String email;
  late String uid;
  late String privacyInfo;
  late String termsInfo;
  String error='';
  Future<String> loadAsset(String s) async {
    return await rootBundle.loadString(s);
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getEmail();
    emailController.addListener(_enableSignin);
    passwordController.addListener(_enableSignin);
  }
  RichText newUserSection(context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'New user?  ',
            style: const TextStyle(
                color: Colors.white70
            ),
            children: <TextSpan>[
              TextSpan(
                text: "Sign up",
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                ),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () {
                    widget.toggleView();
                  },
              )
            ]
        )
    );
  }
  _getEmail() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email")!;
    setState(() {
      emailController.text = email;
    });
  }
  _setUserPrefs(id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = emailController.text;
    prefs.setString("email", email)!;
    prefs.setString("uid", id)!;
  }
  _enableSignin() {
    setState(() {
      _isEnabled = true;
    });
  }
  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      margin: const EdgeInsets.only(top: 0),
      child: ElevatedButton(
        onPressed:  emailController.text == "" || passwordController.text == "" ? null : () async {
          setState(() {
            _isLoading = true;
          });
          dynamic result = await _auth.signInWithEmailAndPassword(emailController.text, passwordController.text);
          _setUserPrefs(result.uid);
          if (result== null){
            print('error signing in');
          } else {
            print ('signed in');
            print(result.uid);
            // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Framework()), (Route<dynamic> route) => false);
          }
          // ]
          // await Future.delayed(Duration(seconds: 1));
          // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Framework()), (Route<dynamic> route) => false);
        },

        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC23B00),
          disabledBackgroundColor: const Color(0xFFC23B00).withOpacity(0.58),
          elevation: 0.2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        ),
        child: const Text("Sign In", style: TextStyle(color: Colors.black)),

      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(

            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/get_moving.png'),
                    fit:BoxFit.cover
                )
            ),
            child: _isLoading ? Center (
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black54),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text("Logging In...",
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          )),
                    )
                  ],
                )) : ListView(
              children: <Widget>[
                headerSection(context, "Get more done."),
                newUserSection(context),
                const Padding(padding: EdgeInsets.only(top:300)),
                formSection(emailController, passwordController),
                errorSection(error),
                buttonSection(),
                forgotPasswordSection(context),

              ],
            ),

          ),
          // termsSection(privacyInfo, termsInfo, context),
        ],
      ),

    );
  }







  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }



}




