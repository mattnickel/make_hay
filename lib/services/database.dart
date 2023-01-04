import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

class DatabaseService{
  late final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userDataCollection = FirebaseFirestore.instance.collection('user_data');
  final CollectionReference tasksCollection = FirebaseFirestore.instance.collection('tasks');


  Future<void> updateSubTaskStatus (taskId, subtaskNumber,title, status)async{
    return await tasksCollection.doc(taskId).update({
      subtaskNumber: {"title":title, "status":status},
    });
  }
  Future<void> updateUserData( String name) async {
    return await userDataCollection.doc(uid).set({
      'name': name,
    });
  }
  Future<void> updateTasks(taskId, taskName,  taskStatus, date, subtask1Title, subtask1Status,subtask2Title, subtask2Status,subtask3Title, subtask3Status) async {
    if(taskId ==""){
      taskId = null;
    }
    return await tasksCollection.doc(taskId).set({
      'user': uid,
      'task': taskName,
      'status':taskStatus,
      'due': date,
      'subtask1':{"title": subtask1Title, "status" : subtask1Status},
      'subtask2':{"title": subtask2Title, "status" : subtask2Status},
      'subtask3':{"title": subtask3Title, "status" : subtask3Status}

    });
  }
  Future<void> updateTaskStatus(String taskId, String taskStatus) async {
    return await tasksCollection.doc(taskId).update({
      'status':taskStatus
    });
  }
  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot){
    // final query = tasksCollection.where("status", isEqualTo: "active").where("user", isEqualTo: uid);
    return snapshot.docs.map((doc){
      print(doc.data().toString());
        return Task(

            taskId: doc.id,
            title: doc.data().toString().contains('task')
                ? doc.get('task')
                : '',
            subtask1Title: doc.data().toString().contains('subtask1')
                ? doc.get('subtask1')["title"]
                : null,
            subtask1Status: doc.data().toString().contains('subtask1')
              ? doc.get('subtask1')["status"]
              : null,
          subtask2Title: doc.data().toString().contains('subtask2')
              ? doc.get('subtask2')["title"]
              : null,
          subtask2Status: doc.data().toString().contains('subtask2')
              ? doc.get('subtask2')["status"]
              : null,
          subtask3Title: doc.data().toString().contains('subtask3')
              ? doc.get('subtask3')["title"]
              : null,
          subtask3Status: doc.data().toString().contains('subtask3')
              ? doc.get('subtask3')["status"]
              : null,
            status: doc.data().toString().contains('status')
                ? doc.get('status')
                : '',
            dueDate: doc.data().toString().contains('due')
                ? doc.get('due')
                : null,
        );
      
    }).toList();
  }
  Stream<List<Task>> get tasks{
    print(uid);
    return tasksCollection.where("user", isEqualTo: uid).snapshots()
        .map(_taskListFromSnapshot);
  }
}
