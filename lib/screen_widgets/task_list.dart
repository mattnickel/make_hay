import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task_model.dart';
import '../page_widgets/task_tile.dart';

class TaskList extends StatefulWidget {
  String status;
  String uid;
  TaskList(this.status, this.uid, {super.key});


  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context);
    List<Task> filteredTasks = tasks.where((task)=>task.status == widget.status).toList();
    if (filteredTasks.isNotEmpty) {
      return ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
        itemCount: filteredTasks.length ?? 0,
        itemBuilder: (context, index) {
          return TaskTile(filteredTasks[index], widget.uid);
      }
      );
    }else{
      return Container(
        margin:  const EdgeInsets.only(top:100, left:40, right:40),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white54),
          borderRadius: BorderRadius.circular(20)
        ),
        child: const Padding(
          padding: EdgeInsets.only(top: 80, bottom:80),
          child: Center(
            child: Text("Currently no tasks here.")
          ),
        ),
      );
    }
    }
  }
