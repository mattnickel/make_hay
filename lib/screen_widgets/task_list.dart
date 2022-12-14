import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/task_model.dart';
import '../page_widgets/task_tile.dart';

class TaskList extends StatefulWidget {
  String status;
  TaskList(this.status, {super.key});


  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context);
    List<Task> filteredTasks= tasks.where((task)=>task.status == widget.status).toList();
      return ListView.builder(
        itemCount: filteredTasks.length ?? 0,
        itemBuilder: (context, index) {
          return TaskTile(filteredTasks[index]);
      }
      );
    }
  }
