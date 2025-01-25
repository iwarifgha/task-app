import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_app/task_app/features/projects/model/project/projects_model.dart';

import '../../../../services/api/firebase/firebase_auth_service.dart';
import '../../../../services/api/firebase/firestore_database_service.dart';
import '../../../tasks/model/task/task_model.dart';
import 'package:uuid/uuid.dart';

class ProjectsStateProvider with ChangeNotifier {
  List<Project> _projects = [];

  List<Project> get tasks => _projects;
  final _firebaseAuthProvider = FirebaseAuthService();
  var uuid = Uuid();
  final _fireStoreDatabaseServiceProvider = FirestoreDatabase();
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> addProject(
      {required String title, duration, goal, timeCreated}) async {
    final currentUser = _firebaseAuthProvider.getUser();

    final project = Project(
        projectId: uuid.v4(),
        userId: currentUser.uid,
        title: title,
        goal: goal,
        duration: duration,
        tasks: [],
        timeCreated: Timestamp.now().toString());

    try {
      await _fireStoreDatabaseServiceProvider.addProject(project: project);
      _projects.add(project);
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to add task. Please try again';
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchProjects(String userId) async {
    try {
      _projects = await _fireStoreDatabaseServiceProvider.fetchProjects(userId);
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to fetch your home. Please try again';
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteProject(String projectId) async {
    try {
      await _fireStoreDatabaseServiceProvider.deleteProject(projectId);
      _projects.removeWhere((project) => project.projectId == projectId);
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to delete your task. Please try again';
    } finally {
      notifyListeners();
    }
  }

  Future<void> editProject(
      {required String projectId, String? title, String? duration}) async {
    try {
      final projectIndex =
          _projects.indexWhere((project) => project.projectId == projectId);
      if (projectIndex == -1) return;

      final specificProject = _projects[projectIndex];
      final editedProject = Project(
          projectId: projectId,
          userId: specificProject.userId,
          title: title ?? specificProject.title,
          goal: specificProject.goal,
          duration: specificProject.duration,
          tasks: specificProject.tasks,
          timeCreated: specificProject.timeCreated);

      await _fireStoreDatabaseServiceProvider.updateProject(projectId: '');
      _projects[projectIndex] = editedProject;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Could not update task. Please try again';
    } finally {
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
