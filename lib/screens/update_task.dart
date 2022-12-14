import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:make_hay/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class UpdateTask extends StatefulWidget {
  @override
  UpdateTaskState createState() => UpdateTaskState();

}
class UpdateTaskState extends State<UpdateTask> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  bool _isEnabled = false;
  late final CollectionReference taskCollection;
  late String uid;


  @override
  void initState() {
    super.initState();
    titleController.addListener(_enable);
    descriptionController.addListener( _enable);
    _getId;

  }
  _getId()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid= prefs.getString("uid")!;
  }
  _enable() {
    setState(() {
      _isEnabled = true;
    });
    _getId();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: const EdgeInsets.only(top:100, left:20, right:20),
            child: ListView(
              children: <Widget>[
                TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value == null) {
                    return 'Task title cannot be empty';
                    }
                    return null;
                    },
                  cursorColor: Colors.black54,
                  style: const TextStyle(color: Colors.black54),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 10.0),
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                    hintText: "Task Title",
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(color: Color(00000000)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: Color(0xff00eebc)),
                    ),
                    hintStyle: TextStyle(color: Colors.black54),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top:20),
                child: TextFormField(
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null) {
                      return 'Task title cannot be empty';
                    }
                    return null;
                  },
                  cursorColor: Colors.black54,
                  style: const TextStyle(color: Colors.black54),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 10.0),
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                    hintText: "Task Description",
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(color: Color(00000000)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(color: Color(0xff00eebc)),
                    ),
                    hintStyle: TextStyle(color: Colors.black54),
                  ),
                ),
                ),
              Padding(padding: const EdgeInsets.only(top:20),
                  child:ElevatedButton(
                    onPressed:  titleController.text == "" || descriptionController.text == "" ? null : () async {
                      dynamic result = DatabaseService(uid: uid).updateTasks(titleController.text, descriptionController.text, "active");
                      if (result== null){
                        print('error creating task');
                      } else {
                        print ('task created');
                        Navigator.of(context).pop();
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
                    child: const Text("Create Task", style: TextStyle(color: Colors.black)),

                  ),
              )
              ]
              )
      )
      ]
      ),
    );
  }
}