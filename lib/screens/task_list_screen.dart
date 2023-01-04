import 'package:flutter/material.dart';
import 'package:make_hay/screens/update_task.dart';
import 'package:make_hay/services/database.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../screen_widgets/task_list.dart';

class TaskListScreen extends StatelessWidget {
  final String status;
  final String uid;
  const TaskListScreen(this.status, this.uid, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Task>>.value(
        value: DatabaseService(uid: uid).tasks,
        initialData:const [],
        child: Stack(
       children: [
         SizedBox(
           height: MediaQuery
               .of(context)
               .size
               .height,
           width: MediaQuery
               .of(context)
               .size
               .width,
         ),
         TaskList(status, uid),
         Positioned(
             bottom: 160,
             right: 45,
             child: FloatingActionButton(
                 backgroundColor: const Color(0xFFC23B00),
                 onPressed: () async {
                   Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UpdateTask(action: "Create", uid:uid)));
                 },
                 child:
                 const Icon(Icons.add, color: Colors.white)
             )
         ),
       ],
     )
    );

  }
}