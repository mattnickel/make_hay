import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';

class DatabaseService{
  late final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userDataCollection = FirebaseFirestore.instance.collection('user_data');
  final CollectionReference tasksCollection = FirebaseFirestore.instance.collection('tasks');



  Future<void> updateUserData( String name) async {
    return await userDataCollection.doc(uid).set({
      'name': name,
    });
  }
  Future<void> updateTasks(String taskName, String taskDescription, String taskStatus) async {
    return await tasksCollection.doc().set({
      'user': uid,
      'task': taskName,
      'description': taskDescription,
      'status':taskStatus
    });
  }
  Future<void> updateTaskStatus(String taskId, String taskStatus) async {
    return await tasksCollection.doc(taskId).update({
      'status':taskStatus
    });
  }
  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot){
    final query = tasksCollection.where("status", isEqualTo: "active");
    return snapshot.docs.map((doc){
        return Task(
            taskId: doc.id,
            title: doc.data().toString().contains('task')
                ? doc.get('task')
                : '',
            description: doc.data().toString().contains('description') ? doc
                .get('description') : '',
            status: doc.data().toString().contains('status')
                ? doc.get('status')
                : ''
        );
      
    }).toList();
  }
  Stream<List<Task>> get tasks{
    return tasksCollection.snapshots()
        .map(_taskListFromSnapshot);
  }
}
