import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/task_model.dart';
import '../page_widgets/task_tile.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});


  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context);
    if (tasks != null){
      return ListView.builder(
        itemCount: tasks.length ?? 0,
        itemBuilder: (context, index) {
          return TaskTile(tasks[index]);
      }

      );
    }else{
      return Container();
    }
    }
  }
