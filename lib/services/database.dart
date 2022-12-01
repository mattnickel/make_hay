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
  Future<void> updateTasks(String taskName, String taskDescription) async {
    return await tasksCollection.doc().set({
      'user': uid,
      'task': taskName,
      'description': taskDescription,
    });
  }
List<Task> _taskListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Task(
          title: doc.data().toString().contains('task') ? doc.get('task') : '',
          description: doc.data().toString().contains('description') ? doc.get('description') : '',
      );
    }).toList();
  }

  Stream<List<Task>> get tasks{
    return tasksCollection.snapshots()
    .map(_taskListFromSnapshot);
  }
}