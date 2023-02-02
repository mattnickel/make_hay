
import 'package:flutter/material.dart';

AlertDialog betaPopup(context) {
  return AlertDialog(
      contentPadding: const EdgeInsets.only(left: 25, right: 25),
      title: const Center(
        child: Padding(
          padding:EdgeInsets.only(bottom: 15),
          child: Text(
            "Thank you for your interest!",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold ),


          ),),
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      content: SingleChildScrollView(
          child: Column(
              children: const <Widget>[
                Text("Someone will reach out to you via email shortly. This feature is currently in beta version and is not yet available to the public. There may be an opportunity to participate as part of a test group for free.",
                  style: TextStyle(color: Colors.black),
                )
              ]
          )
      ),
      actions: <Widget>[
        SizedBox(
          width:MediaQuery.of(context).size.width,
          child: Align(
            alignment: Alignment.center,
            child:
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC23B00),
                  elevation: 0.2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                ),
                onPressed: () {
                  //saveIssue();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Close',

                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),

                ),
              ),
            ),

          ),
        ),
      ]
  );

}