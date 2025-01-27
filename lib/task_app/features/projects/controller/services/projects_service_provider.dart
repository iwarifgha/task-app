import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_app/task_app/features/projects/model/project/projects_model.dart';
import 'package:task_app/task_app/features/tasks/model/task/task_model.dart';
import 'package:task_app/task_app/services/api/firebase/firebase_auth_service.dart';
import 'package:task_app/task_app/services/api/firebase/firestore_database_service.dart';
import 'package:uuid/uuid.dart';

class ProjectsServiceProvider {
  final _firebaseAuthProvider = FirebaseAuthService();
  var uuid = Uuid();
  final _fireStoreDatabaseServiceProvider = FirestoreDatabase();

  Future<Project> addProject(
      {required String title,
      required String duration,
      required String goal,
      required String timeCreated,
      required List<Task> tasks}) async {
    final currentUser = _firebaseAuthProvider.getUser();

    final project = Project(
        projectId: uuid.v4(),
        userId: currentUser.uid,
        title: title,
        goal: goal,
        duration: duration,
        tasks: tasks,
        allTasksCompleted: false,
        timeCreated: timeCreated);
    try {
      await _fireStoreDatabaseServiceProvider.addProject(project: project);
      return project;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Project>> fetchProjects(String userId) async {
    try {
      final projects =
          await _fireStoreDatabaseServiceProvider.fetchProjects(userId);
      return projects;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteProject(String projectId) async {
    try {
      await _fireStoreDatabaseServiceProvider.deleteProject(projectId);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Project> editProject(
      {required String projectId, String? title, String? duration}) async {
    try {
      final project = await _fireStoreDatabaseServiceProvider.updateProject(
          projectId: projectId, title: title, duration: duration);
      return project;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
