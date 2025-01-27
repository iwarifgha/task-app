import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_app/task_app/features/projects/controller/services/projects_service_provider.dart';
import 'package:task_app/task_app/features/projects/model/project/projects_model.dart';

class ProjectsStateProvider with ChangeNotifier {
  List<Project> _projects = [];

  List<Project> get projects => _projects;
  final _projectServiceProvider = ProjectsServiceProvider();
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> addProject(
      {required String title,
      required String duration,
      required String goal,
      required String timeCreated}) async {
    try {
      final project = await _projectServiceProvider.addProject(
          title: title,
          duration: duration,
          goal: goal,
          timeCreated: timeCreated,
          tasks: []);
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
      _projects = await _projectServiceProvider.fetchProjects(userId);
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
      await _projectServiceProvider.deleteProject(projectId);
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

      // final specificProject = _projects[projectIndex];
      // final editedProject = Project(
      //     projectId: projectId,
      //     userId: specificProject.userId,
      //     title: title ?? specificProject.title,
      //     goal: specificProject.goal,
      //     duration: specificProject.duration,
      //     tasks: specificProject.tasks,
      //     timeCreated: specificProject.timeCreated);

      final newProject = await _projectServiceProvider.editProject(
          projectId: projectId, title: title, duration: duration);
      _projects[projectIndex] = newProject;
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
