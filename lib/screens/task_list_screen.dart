import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:make_hay/screens/update_task.dart';
import 'package:make_hay/services/database.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import '../models/task_model.dart';
import '../page_widgets/task_tile.dart';
import '../screen_widgets/task_list.dart';
import '../services/api_get.dart';

class TaskListScreen extends StatelessWidget {
  String status;
  TaskListScreen(this.status, {super.key});



  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Task>>.value(
        value: DatabaseService(uid: '').tasks,
        initialData:[],
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
         TaskList(status),
         Positioned(
             bottom: 160,
             right: 45,
             child: FloatingActionButton(
                 backgroundColor: Color(0xFFC23B00),
                 onPressed: () async {
                   Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UpdateTask(action: "Create")));
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