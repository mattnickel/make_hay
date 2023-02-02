import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:make_hay/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';
import '../screens/update_task.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  final String uid;
  const TaskTile(this.task, this.uid, {super.key});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  late bool sub1Checked;
  late bool sub2Checked;
  late bool sub3Checked;

  @override
  void initState() {
    super.initState();
    sub1Checked = widget.task.subtask1Status ?? false;
    sub2Checked = widget.task.subtask2Status ?? false;
    sub3Checked = widget.task.subtask3Status?? false;
  }

  @override
  Widget build(BuildContext context) {
    bool? late = false;
    if (widget.task.dueDate !=null) {
      late = widget.task.dueDate?.toDate().isBefore(DateTime.now().subtract(const Duration(days: 1)));
    }
    String newStatus;
    switch (widget.task.status) {
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
    switch (widget.task.status) {
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
    late String date = DateFormat('MM/dd/yy').format(DateTime.parse(widget.task.dueDate!.toDate().toString())).toString();

    return Stack(
        children:[
          Container(
            margin: const EdgeInsets.all(20.0),
            height:250,
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
                            if (late!) ...[
                              Text(
                                widget.task.dueDate == null ? "" : date,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              ),
                            ] else ...[
                              Text(
                                widget.task.dueDate == null ? "" : date,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              )
                            ]
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40.0, top:10, right:40.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom:8.0),
                          child: Text(widget.task.title,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            Visibility(
                              visible:  widget.task.subtask1Title != "",
                              child: SizedBox(
                                height:30,
                                child: Checkbox(
                                    activeColor:const Color(0xFFC23B00),
                                    value: sub1Checked,
                                    shape: const CircleBorder(),
                                    // fillColor:MaterialStateProperty.resolveWith(Color(0xFFC23B00)),
                                    onChanged: (value){
                                      setState((){
                                        sub1Checked = value!;
                                        DatabaseService(uid: widget.uid).updateSubTaskStatus( widget.task.taskId, "subtask1", widget.task.subtask1Title, sub1Checked);
                                        });
                                    }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:0.0, right:40),
                              child: Text(widget.task.subtask1Title?.toString() ?? "",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  )
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Visibility(
                              visible: widget.task.subtask2Title != "",
                              child: SizedBox(
                                height:30,
                                child: Checkbox(
                                    activeColor:const Color(0xFFC23B00),
                                    value: sub2Checked,
                                    shape: const CircleBorder(),
                                    // fillColor:MaterialStateProperty.resolveWith(Color(0xFFC23B00)),
                                    onChanged: (value){
                                      setState((){
                                        sub2Checked = value!;
                                      });
                                      DatabaseService(uid: widget.uid).updateSubTaskStatus( widget.task.taskId, "subtask2", widget.task.subtask2Title, sub2Checked);
                                    }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right:40),
                              child: Text(widget.task.subtask2Title?.toString() ?? "",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  )
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Visibility(
                              visible: widget.task.subtask3Title != "",
                              child: SizedBox(
                                height:30,
                                child: Checkbox(
                                    activeColor:const Color(0xFFC23B00),
                                    value: sub3Checked,
                                    shape: const CircleBorder(),
                                    // fillColor:MaterialStateProperty.resolveWith(Color(0xFFC23B00)),
                                    onChanged: (value){
                                      setState((){
                                        sub3Checked = value!;
                                    });
                                      DatabaseService(uid: widget.uid).updateSubTaskStatus( widget.task.taskId, "subtask3", widget.task.subtask3Title, sub3Checked);
                                  }
                              ),
                            ),
                          ),
                            Padding(
                              padding: const EdgeInsets.only(right:40),
                              child: Text(widget.task.subtask3Title?.toString() ?? "",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  )
                              ),
                            ),
                          ],
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
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UpdateTask(taskObject:widget.task, uid: widget.uid, action:"Update")));
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
                          dynamic result = DatabaseService(uid: uid).updateTaskStatus(widget.task.taskId, newStatus);
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

