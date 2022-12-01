import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../screen_widgets/signup_signin_widgets.dart';

import '../popups/terms_popup.dart';
import '../services/api_login.dart';
import '../services/auth.dart';
import 'login_screen.dart';


class SignupScreen extends StatefulWidget {
  final Function toggleView;
  SignupScreen({required this.toggleView});
  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormBuilderState> _formBKey = GlobalKey<FormBuilderState>();
  late SharedPreferences prefs;
  late Image backgroundImage;
  bool _isLoading = false;
  late bool _isEnabled;
  bool accepted= true;
  late String privacyInfo;
  late String termsInfo;
  bool _showGroup = false;
  final AuthService _auth = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // final usernameController = TextEditingController();
  final joincodeController = TextEditingController();
  String error='';

  @override
  void initState() {
    super.initState();
    _isEnabled = false;
    // Start listening to changes.
    emailController.addListener(_enableSignin);
    passwordController.addListener( _enableSignin);
    // usernameController.addListener( _enableSignin);
    joincodeController.addListener( _enableSignin);
  }
  _enableSignin() {
    setState(() {
      _isEnabled = true;
    });
  }
  Future<String> loadAsset(String s) async {
    return await rootBundle.loadString(s);
  }
  RichText returningUserSection(context){
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text:'Already Signed Up?  ',
            style: const TextStyle(
                color: Colors.white70
            ),
            children: <TextSpan>[
              TextSpan(
                text: "Log in",
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                ),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () {
                    widget.toggleView();
                    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const LoginScreen("")), (Route<dynamic> route) => false);
                  },
              )
            ]
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
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
                      child: Text("Signing Up...",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          )),
                    )
                  ],
                )) : ListView(
              children: <Widget>[
                headerSection(context, "Get Better."),
                returningUserSection(context),
                const Padding(padding: EdgeInsets.only(top:300)),
                signupFormSection(),
                errorSection(error),
                buttonSection(),

              ],
            ),
          ),
          checkboxSection(),
        ],
      ),
    );
  }

  Positioned checkboxSection(){
    return Positioned(
        bottom: 0,
        right: 0,
        child: Container(
            padding: const EdgeInsets.only(top:20),
            width: MediaQuery.of(context).size.width,
            child: Stack(children: [
              Container(
                width:MediaQuery.of(context).size.width,
                color: Colors.black54,
                padding: const EdgeInsets.only(top:5.0, bottom:15, left:50, right:10),
                child: RichText(
                  // textAlign: TextAlign.center,
                    text:TextSpan(
                        text: "I accept the ",
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
                              text: "Privacy Policy,",
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () async{
                                  privacyInfo = await rootBundle.loadString('assets/text/privacy.txt');
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
                            text: " and I understand that there is no tolerance for objectionable content or abusive users.",
                          ),
                        ]
                    )
                ),
              ),

              Checkbox(
                  value: accepted,
                  activeColor: const Color(0xFFC23B00),
                  onChanged: (val){
                    setState(() {
                      accepted=val!;
                    });
                  }),
            ],)
        )
    );
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        onPressed: emailController.text == "" || passwordController.text == "" || accepted== false ? null : () async {

          if (_formBKey.currentState!.validate()) {
            setState(() {
              _isLoading = true;
            });
            dynamic result = await _auth.signUp(emailController.text, passwordController.text);
            if (result == null){
              setState(() {
                _isLoading = false;
                error = 'Error here';
              });
            }

          }
          else print("not valid");

        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC23B00),
          disabledBackgroundColor: const Color(0xFFC23B00).withOpacity(0.58),
          elevation: 0.2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        ),
        child:
        _isLoading
            ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)
            :const Text("Sign Up", style: TextStyle(color: Colors.white)),
      ),
    );
  }
  Padding passwordInfoSection(){
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
          "Password must have 6 characters, upper & lower case letters, numbers, and symbols.",
          style: TextStyle(color: Colors.white, fontSize: 10)
      ),
    );
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();
    passwordController.dispose();
    joincodeController.dispose();
    super.dispose();
  }
  Container signupFormSection() {
    return Container(
      constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
      padding: const EdgeInsets.only(top: 5, bottom: 10, left:20, right:20),
      child: FormBuilder(
        key: _formBKey,
        child: Column(
          children: <Widget>[

            Container(
              alignment: Alignment.center,
              child: FormBuilderTextField(

                controller: emailController,
                // validator: [FormBuilderValidators.email(),FormBuilderValidators.required()],
                cursorColor: Colors.black54,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.black54),
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
                ), name: '',
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              child: FormBuilderTextField(
                controller: passwordController,
                // validator:[FormBuilderValidators.pattern(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#%\$&*~]).{8,}$', errorText: "Invalid password: A capital letter, number, and symbol required"), FormBuilderValidators.required(), FormBuilderValidators.min(6)],
                cursorColor: Colors.black54,
                obscureText: true,
                style: const TextStyle(color: Colors.black54),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                  prefixIcon: Icon(Icons.lock, color: Colors.black54),
                  filled:true,
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
                ), name: '',
              ),
            ),

            const SizedBox(height: 10.0),
            passwordInfoSection(),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left:8.0),
                  child: Text("Join as part of a group:",
                      style:TextStyle(color:Colors.white70)
                  ),
                ),
                const Spacer(),
                Switch(
                    inactiveTrackColor: Colors.white12,
                    value: _showGroup,
                    onChanged: (value) async {
                      setState(() {
                        _showGroup = value;
                      });
                    }
                ),
              ],
            ),
            const SizedBox(height: 0.0),
            Visibility(
              visible: _showGroup,
              child: Container(
                child: FormBuilderTextField(
                  controller: joincodeController,
                  // validator: FormBuilderValidator.min(6)],
                  cursorColor: Colors.black54,
                  style: const TextStyle(color: Colors.black54),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                    prefixIcon: Icon(Icons.group_rounded, color: Colors.black54),
                    filled:true,
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                    hintText: "Group Joincode",
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
                  ), name: '',
                ),
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }


}

