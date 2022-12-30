import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day/day.dart';
import '../models/task_model.dart';
import '../screens/update_task.dart';
import '../services/database.dart';





class TaskTile extends StatelessWidget {
  final Task task;

 const TaskTile(this.task, {super.key});
  @override
  Widget build(BuildContext context) {
    String newStatus;
    switch (task.status) {
      case "completed": {
        newStatus ="archived";
      } break;
      case "archived": {
        newStatus = "active";
      } break;
      default: {
        newStatus = "completed";
      } break;
    }
    String quickAction;
    switch (task.status) {
      case "completed": {
        quickAction ="Archive";
      } break;
      case "archived": {
        quickAction = "Reactivate";
      } break;
      default: {
        quickAction = "Done";
      } break;
    }
    print (task.taskId);
    late String date = DateFormat('MM/dd/yy').format(DateTime.parse(task.dueDate!.toDate().toString())).toString();
    return Stack(
        children:[
          Container(
            margin: const EdgeInsets.all(20.0),
            height:220,
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          ),
          Wrap(
            children: [
              Container(
                decoration:const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black38,

                    ),
                  ),
                ),
                height:70,
                child: Row(
                  children:[
                    SizedBox(
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.only(left:40.0, top: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Due:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12),
                            ),
                            Text(
                              task.dueDate == null ? "" : date,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Expanded(
                    //     child: IconButton(
                    //       icon: const Icon(Icons.drag_indicator ), onPressed: () {
                    //       print("move");
                    //     },
                    //     )
                    // ),
                    // SizedBox(
                    //   width: 150,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(top: 25),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: const [
                    //         Text(
                    //           "Assigned to:",
                    //           style: TextStyle(
                    //               color: Colors.black,
                    //               fontSize: 12),
                    //         ),
                    //         Text(
                    //           "Matt N",
                    //           style: TextStyle(
                    //               color: Colors.black,
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 18),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(

                height: 120,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40.0, top:10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(task.title ?? "",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:10.0, right:40),
                          child: Text(task.description ?? "",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              )
                          ),
                        ),
                      ]
                  ),
                ),


              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        decoration:const BoxDecoration(
                          border: Border(
                          right: BorderSide(
                            color: Colors.black38,
                              ),
                              top:BorderSide(
                                color: Colors.black38,
                              ),
                          ),
                          ),
                        padding: const EdgeInsets.only(left:40.0 ),
                        child: TextButton(
                          child: const Text(
                            "Edit",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18),

                          ),
                          onPressed: ()async{
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UpdateTask(taskObject:task, action:"Update")));
                            print('Pressed');
                          },

                        ),


                      ),
                    ),

                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration:const BoxDecoration(
                        border: Border(
                          top:BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                      ),
                      child:
                      TextButton(
                        child: Text(
                          quickAction,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18),

                        ),
                        onPressed: ()async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          final uid= prefs.getString("uid")!;
                          dynamic result = DatabaseService(uid: uid).updateTaskStatus(task.taskId, newStatus);
                          if (result== null){
                            print('error creating task');
                          }
                        },

                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),


        ]);
  }
}

