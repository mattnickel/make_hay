import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Task {

  String title;
  Object? subtask1;
  Object? subtask2;
  Object? subtask3;
  String? subtask1Title;
  bool? subtask1Status;
  String? subtask2Title;
  bool? subtask2Status;
  String? subtask3Title;
  bool? subtask3Status;
  String status;
  String taskId;
  Timestamp? dueDate;

  // String dueDate;
  // String assignedTo;


  Task({
    required this.taskId,
    required this.title,
    this.subtask1Title,
    this.subtask1Status,
    this.subtask2Title,
    this.subtask2Status,
    this.subtask3Title,
    this.subtask3Status,
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