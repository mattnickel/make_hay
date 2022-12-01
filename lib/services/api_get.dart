import 'dart:convert';
import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/task_model.dart';

// Future<List<TaskList>?> fetchTasks(client, category, context) async{
//
//   Uri url = Uri.parse("localhost/api/v1/tasks/category?category=$category");
//   const storage = FlutterSecureStorage();
//   String? token = await storage.read(key: "token");
//   final tokenHeaders = {'token': token, 'content-type': 'application/json'};
//   final response = await client.get(
//     url, headers: tokenHeaders,
//   );
//   List<TaskList>? taskList;
//   if (response != null) {
//     if (response.statusCode == 200) {
//      taskList= parseTasks(response.body).cast<TaskList>();
//     } else {
//       taskList= null;
//     }
//   }
//   return taskList;
// }

// List<Task> parseTasks(responseBody) {
//   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//   final parsedList = parsed.map<Task>((json) => Task.fromJson(json))
//       .toList();
//   return parsedList;
// }

