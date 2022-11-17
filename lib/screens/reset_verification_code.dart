import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/new_password.dart';
import '../services/api_login.dart';



class ResetVerificationCode extends StatefulWidget {
  @override
  _ResetVerificationCodeState createState() => _ResetVerificationCodeState();
}

class _ResetVerificationCodeState extends State<ResetVerificationCode> {
  late String errorMessage;
  final resetController = TextEditingController();
  bool isLoading = false;

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
            headerSection(context),
            formSection(),
            errorSection(),
            buttonSection(context),

          ],
        ),
      ),
    );
  }

  Container buttonSection(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 0),
      child: ElevatedButton(
        onPressed: resetController.text =='' ? null :() async{
          setState(() {
            isLoading = true;
          });
          bool confirmed = await confirmReset(resetController.text);
          await Future.delayed(Duration(seconds: 2), () {});
          if (confirmed){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewPassword()));
          } else{
            setState(() {
              isLoading = false;
              errorMessage = "Invalid verification code. Please try again";
            });

          }

        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC23B00),
          elevation: 0.2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        ),
        child: isLoading
            ? CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),)
            :Text("Confirm", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Container formSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: TextFormField(
              controller: resetController,
              cursorColor: Colors.black54,
              keyboardType: TextInputType.text,
              obscureText: true,
              onChanged: (val){
                setState(() {

                });
              },
              style: TextStyle(color: Colors.black54),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                prefixIcon: Icon(Icons.lock, color: Colors.black54),
                filled:true,
                fillColor: Colors.white,
                focusColor: Colors.white,
                hintText: "Verification Code",
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
  Container errorSection(){
    return Container(
      child:
      errorMessage != null
          ? Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline), SizedBox(width: 5.0),
                Text(
                    errorMessage
                ),
              ],
            ),
          ))
          : null,
    );
  }
  Column headerSection(context) {
    return Column(
      children: [
        Container(
          padding:EdgeInsets.only(top:30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              icon: Icon(Icons.arrow_back),
              label: Text("Back"),
              onPressed:(){
                Navigator.pop(context);
              },

            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 60.0),
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: const [

              Align(
                alignment: Alignment.centerLeft,
                child: Text("Confirm Reset",
                    style: TextStyle(
                        color: Color(0xff606060),
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
              Text("Enter your verification code sent to your email address before resetting your password.",
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

