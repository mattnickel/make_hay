import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../popups/terms_popup.dart';
import '../screens/login_screen.dart';
import '../screens/reset_password.dart';
import '../screens/signup_screen.dart';

Container headerSection(context, headerText) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5.0),
    child: Column(
      children: [
        Image.asset("assets/images/make_hay_logo.png", width: 170),
        // Padding(
        //   padding: const EdgeInsets.only(top: 3.0),
        //   child: Text(headerText,
        //       style: TextStyle(
        //           color: Colors.white70,
        //           fontSize: 30.0,
        //           fontWeight: FontWeight.bold
        //       )
        //   ),
        // ),

      ],
    ),
  );
}
// RichText returningUserSection(context){
//   return RichText(
//       textAlign: TextAlign.center,
//       text: TextSpan(
//           text:'Already Signed Up?  ',
//           style: const TextStyle(
//               color: Colors.white70
//           ),
//           children: <TextSpan>[
//             TextSpan(
//               text: "Log in",
//               style: const TextStyle(
//                 decoration: TextDecoration.underline,
//               ),
//               recognizer: new TapGestureRecognizer()
//                 ..onTap = () {
//                   widget.toggleView()
//                   // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const LoginScreen("")), (Route<dynamic> route) => false);
//                 },
//             )
//           ]
//       )
//   );
// }

Container formSection(emailController, passwordController) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
    child: Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: TextFormField(
            controller: emailController,
            validator: (value) {
              if (value == null) {
                return 'Email cannot be empty';
              }
              return null;
            },
            cursorColor: Colors.black54,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.black54),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: 16.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.email, color: Colors.black54),
              filled: true,
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
        const SizedBox(height: 20.0),
        TextFormField(
          controller: passwordController,
          validator: (value) {
            if (value != null  && value.length < 6) {
              return 'Password must have 6+ characters';
            }
            return null;
          },
          cursorColor: Colors.black54,
          obscureText: true,
          style: const TextStyle(color: Colors.black54),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: 16.0, horizontal: 10.0),
            prefixIcon: Icon(Icons.lock, color: Colors.black54),
            filled: true,
            fillColor: Colors.white,
            focusColor: Colors.white,
            hintText: "Password",
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

      ],
    ),
  );
}

Container errorSection(error){
  return Container(
    child:
    error.length > 1
        ? Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline), const SizedBox(width: 5.0),
              Text(
                  error
              ),
            ],
          ),
        ))
        : null,
  );
}
Positioned termsSection(termsInfo, privacyInfo, context){
  return Positioned(
    bottom: 0,
    right: 0,
    child: Container(
      width: MediaQuery.of(context).size.width,
      color:Colors.black54,
      child: Align(
          alignment:Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0, top:10.0),
            child: RichText(
                textAlign: TextAlign.center,
                text:TextSpan(
                    text: "By logging in, you're agreeing to our \n",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: "Terms of Use",
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () async {
                              termsInfo = await rootBundle.loadString('assets/text/terms.txt');
                              await showDialog(
                                  context:context,
                                  builder:(BuildContext context){
                                    return termsPopup("Terms of Use", termsInfo, context);
                                  }
                              );
                            },
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          )
                      ),
                      const TextSpan(
                        text: " and ",
                      ),
                      TextSpan(
                          text: "Privacy Policy",
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () async{
                              privacyInfo = await rootBundle.loadString('assets/text/privacy.txt');
                              print("here");
                              await showDialog(
                                  context:context,
                                  builder:(BuildContext context){
                                    return termsPopup("Privacy Policy", privacyInfo, context);
                                  }
                              );

                            },
                          style: const TextStyle(
                            decoration: TextDecoration.underline,)
                      ),
                      const TextSpan(
                        text: ".",
                      ),
                    ]
                )
            ),
          )
      ),
    ),
  );
}
// RichText newUserSection(context){
//   return RichText(
//       textAlign: TextAlign.center,
//       text: TextSpan(
//           text:'New user?  ',
//           style: const TextStyle(
//               color: Colors.white70
//           ),
//           children: <TextSpan>[
//             TextSpan(
//               text: "Sign up",
//               style: const TextStyle(
//                 decoration: TextDecoration.underline,
//               ),
//               recognizer: new TapGestureRecognizer()
//                 ..onTap = () {
//                   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => SignupScreen()), (Route<dynamic> route) => false);
//                 },
//             )
//           ]
//       )
//   );
// }
Align forgotPasswordSection(context){
  return Align(
    alignment: Alignment.center,
    child: TextButton(child:
    const Text(
      'Forgot Password?',
      style: TextStyle(
        color: Colors.white70,
        decoration: TextDecoration.underline,
      ),
    ),
      onPressed: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ResetPassword()));
      },),
  );
}
