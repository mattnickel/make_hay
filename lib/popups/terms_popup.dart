import 'package:flutter/material.dart';

AlertDialog termsPopup(title, info, context) {
  return AlertDialog(
      contentPadding: const EdgeInsets.only(left: 25, right: 25),
      title: Center(
        child: Padding(
          padding:const EdgeInsets.only(bottom: 15),
          child: Text(
            title,
            style: const TextStyle(fontSize:18,fontWeight: FontWeight.bold ),

          ),),
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      content: Container(
        child: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  Text(info),
                ]
            )
        ),
      ),
      actions: <Widget>[
        Container(
          width:MediaQuery.of(context).size.width,
          child: Align(
            alignment: Alignment.center,
            child:
            Container(
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
                  'CONTINUE',

                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),

                ),
              ),
            ),

          ),
        ),
      ]
  );

}