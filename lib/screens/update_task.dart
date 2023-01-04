import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:make_hay/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task_model.dart';
import '../models/user.dart';

class UpdateTask extends StatefulWidget {
  final Task? taskObject;
  final String action;
  final String uid;


  const UpdateTask({super.key, this.taskObject, required this.uid, required this.action});

  @override
  UpdateTaskState createState() => UpdateTaskState();

}
class UpdateTaskState extends State<UpdateTask> {
  final titleController = TextEditingController();
  final timeController = TextEditingController();
  final subtask1Controller = TextEditingController();
  final subtask2Controller = TextEditingController();
  final subtask3Controller = TextEditingController();
  late String status;
  late final CollectionReference taskCollection;
  late Task? task;
  bool dateOn= false;
  bool statusOn= false;
  late DateTime dueDate;
  DateTime selectedDate = DateTime.now();
  DateTime? picked;
  late String titleAction;


  @override
  void initState() {
    super.initState();
    task = widget.taskObject;
    // titleController.addListener(_getId);
    titleController.text =task?.title ?? "";
    subtask1Controller.text =task?.subtask1Title ?? "";
    subtask2Controller.text =task?.subtask2Title ?? "";
    subtask3Controller.text =task?.subtask3Title ?? "";
    timeController.text = widget.taskObject?.dueDate != null ? DateFormat('MM/dd/yy').format(DateTime.parse(task!.dueDate!.toDate().toString())).toString() : "";
    dateOn = widget.taskObject?.dueDate != null;
    statusOn = widget.taskObject?.status != "";
    status = widget.taskObject?.status ?? "active";
    titleAction = widget.action;

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

              Padding(
            padding: const EdgeInsets.only(top:100, left:20, right:20),
            child: Padding(padding: const EdgeInsets.only(bottom:30),
                child: Text("$titleAction Task",
                    style:const TextStyle(
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
            style: const TextStyle(color: Colors.black),

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
                borderSide: BorderSide(color: Color(0x00000000)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: Color(0xff00eebc)),
              ),
              hintStyle: TextStyle(color: Colors.black54),
            ),
              ),
              Padding(padding: const EdgeInsets.only(top:20, left:40),
            child: TextFormField(
              controller: subtask1Controller,
              cursorColor: Colors.black54,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 10.0),
                filled: true,
                fillColor: Colors.white,
                focusColor: Colors.white,
                hintText: "SubTask (Optional)",
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: Color(0x00000000)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: Color(0xff00eebc)),
                ),
                hintStyle: TextStyle(color: Colors.black54),
              ),
            ),
              ),
                Padding(padding: const EdgeInsets.only(top:20, left:40),
                  child: TextFormField(
                    controller: subtask2Controller,
                    cursorColor: Colors.black54,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 10.0),
                      filled: true,
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      hintText: "SubTask (Optional)",
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0x00000000)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0xff00eebc)),
                      ),
                      hintStyle: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top:20, left:40),
                  child: TextFormField(
                    controller: subtask3Controller,
                    validator: (value) {
                      if (value == null) {
                        return 'Task title cannot be empty';
                      }
                      return null;
                    },
                    cursorColor: Colors.black54,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 10.0),
                      filled: true,
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      hintText: "SubTask (optional)",
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Color(0x00000000)),
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
            child: Visibility(
              visible: dateOn,
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

              ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left:8.0),
                      child: Text("Assign a due date:",
                          style:TextStyle(color:Colors.white70)
                      ),
                    ),
                    const Spacer(),
                    Switch(
                        activeColor: const Color(0xFFC23B00),
                        inactiveTrackColor: Colors.white12,
                        value: dateOn,
                        onChanged: (val) async {
                          setState(() {
                            dateOn =val;
                          });
                        }
                    ),
                  ],
                ),
                const SizedBox(height: 0.0),
                Visibility(
                  visible: dateOn,
                  child: DateTimeField(
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    decoration: const InputDecoration(floatingLabelBehavior: FloatingLabelBehavior.never,
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.only(top:15, bottom:0, left:10),
                        enabled: true,
                          border: OutlineInputBorder(

                          )
                        // labelText: "Select Date",


                      ),
                      controller: timeController,
                      format: DateFormat.yMMMEd(),
                      // initialValue: task?.dueDate! ?? null,
                      // decoration: const InputDecoration(
                      //     labelText: "Select Time:"
                      // ),
                      onShowPicker: (context, currentValue) async {
                        picked = (await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                          lastDate:DateTime.now().add(const Duration(days:365)
                        )))!;
                          if (picked != selectedDate) {
                            setState(() {
                              selectedDate = picked!;
                            });
                          }
                        return selectedDate;
                      },
                      onChanged: (tex) {
                        setState(() {});
                      },
                      onSaved: (input) => dueDate = input!
                  ),
                ),
                const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.only(top:20),
            width:MediaQuery.of(context).size.width,
            child:ElevatedButton(
              onPressed: () async {
                dynamic result;
                if(task != null) {
                  print(task?.taskId);
                 result = DatabaseService(uid: widget.uid).updateTasks(
                    task!.taskId,
                    titleController.text,
                    status,
                    picked,
                    subtask1Controller.text,
                    false,
                    subtask2Controller.text,
                    false,
                    subtask3Controller.text,
                    false,);
                }else {
                  result = DatabaseService(uid: widget.uid).updateTasks(
                    "",
                    titleController.text,
                    status,
                    picked,
                    subtask1Controller.text,
                    false,
                    subtask2Controller.text,
                    false,
                    subtask3Controller.text,
                    false,);
                }
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
              child: Text("$titleAction Task", style: const TextStyle(color: Colors.white, fontSize: 16)),

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