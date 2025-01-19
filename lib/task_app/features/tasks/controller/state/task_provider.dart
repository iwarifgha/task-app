import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../services/api/firebase/firebase_auth_service.dart';
import '../../../../services/api/firebase/firestore_database_service.dart';
import '../../model/task_model.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;
  final _firebaseAuthProvider = FirebaseAuthService();
  final _fireStoreDatabaseServiceProvider = FirestoreDatabase();
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> addTask(String title, description, userId) async {
    final currentUser = _firebaseAuthProvider.getUser();

    final task = Task(
        time: DateTime.now().toString(),
        title: title,
        description: description,
        userId: currentUser.uid,
        id: ''
    );

    try {
      await _fireStoreDatabaseServiceProvider.addTask(task);
      _tasks.add(task);
      _errorMessage = null;
      notifyListeners();
    }catch (e) {
      _errorMessage = 'Failed to add task. Please try again';
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchTasks(String userId) async {
    try {
      _tasks = await _fireStoreDatabaseServiceProvider.fetchTasks(userId);
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to fetch your tasks. Please try again';
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _fireStoreDatabaseServiceProvider.deleteTask(taskId);
      _tasks.removeWhere((task) => task.id == taskId);
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to delete your task. Please try again';
    } finally {
      notifyListeners();
    }
  }

  Future<void> editTask(
      {required String taskId, required String title, required String description}) async {
    try {
      final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
      if (taskIndex == -1) return;

      final editedTask = Task(
          time: _tasks[taskIndex].time,
          title: title,
          description: description,
          userId: _tasks[taskIndex].userId,
          id: taskId);

      await _fireStoreDatabaseServiceProvider.updateTask(editedTask);
      _tasks[taskIndex] = editedTask;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Could not update task. Please try again' ;
    } finally {
      notifyListeners();
    }
  }

  void clearError(){
    _errorMessage = null;
    notifyListeners();
  }
}
