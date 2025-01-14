import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/tasks/model/task_model.dart';

class FirestoreDatabase {
  final _fireStore = FirebaseFirestore.instance;

  Future<void> addTask(Task task) async {
    try {
      await _fireStore.collection('tasks').doc(null).set(task.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Task>> fetchTasks(String userId) async {
    try {
      final snapshot = await _fireStore
          .collection('tasks')
          .where('userId', isEqualTo: userId)
          .get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Task.fromMap(data, doc.id);
      }).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await _fireStore.collection('tasks').doc(task.id).update(task.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _fireStore.collection('tasks').doc(taskId).delete();
    } catch (e) {
      throw Exception(e);
    }
  }


}
