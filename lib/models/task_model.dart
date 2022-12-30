import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Task {

  String title;
  String? description;
  String status;
  String taskId;
  Timestamp? dueDate;

  // String dueDate;
  // String assignedTo;


  Task({

    required this.taskId,
    required this.title,
    this.description,
    required this.status,
    this.dueDate,
    // required this.assignedTo
  });

}
//   factory Task.fromJson(Map<String, dynamic> json) =>Task(
//     id: json['id'],
//     title: json['title'],
//     description: json['description'],
//     dueDate: json['due_date'],
//     assignedTo: json['assigned_to'],
//   );
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = id;
//     data['title'] = title;
//     data['description'] = description;
//     data['due_date'] = dueDate;
//     data['assigned_to'] = assignedTo;
//
//     return data;
//   }
// }


// class TaskList {
  // late final List<Task> tasks;
  //
  // TaskList({
  //   required this.tasks,
  // });
  //
  // factory TaskList.fromJson(List<dynamic> parsedJson) {
  //
  //   List<Task> tasks = <Task>[];
  //   tasks = parsedJson.map((i)=>Task.fromJson(i)).toList();
  //
  //   return TaskList(
  //       tasks: tasks
  //   );
  // }
// }