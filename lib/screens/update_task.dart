import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:make_hay/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task_model.dart';
import '../models/user.dart';

class UpdateTask extends StatefulWidget {
  final Task? taskObject;
  const UpdateTask({super.key, this.taskObject});

  @override
  UpdateTaskState createState() => UpdateTaskState();

}
class UpdateTaskState extends State<UpdateTask> {

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late String status;
  bool _isEnabled = false;
  late final CollectionReference taskCollection;
  late String uid;
  late Task task;

  @override
  void initState() {
    super.initState();
    titleController.addListener(_enable);
    descriptionController.addListener( _enable);
    Task? task = widget.taskObject;
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
          Positioned(
              top:100,
              left:0,
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.arrow_back),
                // color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                }, label: const Text("Back", style:TextStyle(color:Colors.white),
              ),
              )
          ),
          Container(
            padding:const EdgeInsets.only(top:80),
            height:MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [

              const Padding(
            padding: EdgeInsets.only(top:100, left:20, right:20),
            child: Padding(padding: EdgeInsets.only(bottom:30),
                child: Text("Create/Update Task",
                    style:TextStyle(
                      color: Colors.white,
                      fontSize:30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center
                )
            ),

            ),
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
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
            child: DropdownButtonFormField(
              // itemHeight:50,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top:0, bottom:0, left:10),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFC23B00), width: 0),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 0),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 0),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              dropdownColor: Colors.white,

              style: const TextStyle(color: Colors.black, fontSize: 16),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              value: widget.taskObject?.status.toString() ?? "active",
              items: const [
                DropdownMenuItem(value: "active", child: Text("Active")),
                DropdownMenuItem(value: "completed", child: Text("Completed")),
                DropdownMenuItem(value: "archived", child: Text("Archived")),
              ],
              onChanged: (value){
                setState(() {
                  status = value.toString();
                });
              },
            ),

              ),
              Container(
                padding: const EdgeInsets.only(top:20),
            width:MediaQuery.of(context).size.width,
            child:ElevatedButton(
              onPressed:  titleController.text == "" || descriptionController.text == "" ? null : () async {
                dynamic result = DatabaseService(uid: uid).updateTasks(titleController.text, descriptionController.text, status);
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
                padding: const EdgeInsets.symmetric(vertical:15),
                disabledBackgroundColor: const Color(0xFFC23B00).withOpacity(0.58),
                elevation: 0.2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
              ),
              child: const Text("Save Task", style: TextStyle(color: Colors.white, fontSize: 16)),

            ),
              ),

            ]
            ),
          )

        ],
      ),
    );
  }
}