import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_login.dart';

import './reset_verification_code.dart';




class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});



  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late String errorMessage;
  late String email;
  final emailController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getEmail();
    // Start listening to changes.

  }
  _getEmail() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email")!;
      setState(() {
        emailController.text = email;
      });
  }
  _setEmail(email) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
  }
  @override

  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/adventure3.png'),
                fit:BoxFit.cover
            )
        ),
        child: ListView(
          children: <Widget>[
            headerSection(),
            formSection(),
            errorSection(),
            buttonSection(context),

          ],
        ),
      ),
    );
  }

  Container errorSection(){
    return Container(
      child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline), const SizedBox(width: 5.0),
                Text(
                    errorMessage
                ),
              ],
            ),
          ))
    );
  }
  Container buttonSection(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      margin: const EdgeInsets.only(top: 0),
      child:
      ElevatedButton(

        onPressed: emailController.text==''? null :()async {
          setState(() {
            isLoading = true;
          });
          bool emailExists= await createVerificationCode(emailController.text);
          await Future.delayed(const Duration(seconds: 2), () {});
          if (emailExists) {
            _setEmail(emailController.text);
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => ResetVerificationCode()));
          }else {
            setState(() {
              isLoading = true;
              errorMessage = "Email is invalid. Check spelling or try a different email";
            });
          }

        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC23B00),
          elevation: 0.2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        ),
        child:  isLoading
            ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)
            :const Text("Send Password Reset Email", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Container formSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: TextFormField(
              controller: emailController,
              cursorColor: Colors.black54,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.black54),
              onChanged: (tex) {
                setState(() {});
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                prefixIcon: Icon(Icons.email, color: Colors.black54),
                filled:true,
                fillColor: Colors.white,
                focusColor: Colors.white,
                hintText: "Email",
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(color: Color(00000000)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(color: Color(0xff00eebc)),
                ),
                hintStyle: TextStyle(color: Colors.black54),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Column headerSection() {
    return Column(
      children: [
        Container(
          padding:const EdgeInsets.only(top:30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              icon: const Icon(Icons.arrow_back),
              label: const Text("Back"),
              onPressed:(){
                Navigator.pop(context);
              },

            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 60.0),
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: const [

              Align(
                alignment: Alignment.centerLeft,
                child: Text("Reset Password",
                    style: TextStyle(
                        color: Color(0xff606060),
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
              Text("Enter your email address and we will send you a verification code to reset your password.",
                  style: TextStyle(
                    color: Colors.black45,)
              )
            ],
          ),
        ),
      ],
    );
  }
}

