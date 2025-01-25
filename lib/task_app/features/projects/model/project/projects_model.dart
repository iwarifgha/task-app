import 'package:task_app/task_app/features/tasks/model/task/task_model.dart';

//Abstract class
abstract class ProjectsModel {
  final String projectId;
  final String userId;
  final String title;
  final String goal;
  final String duration;
  final String timeCreated;
  final List<Task> tasks;

  ProjectsModel({required this.timeCreated, 
      required this.projectId,
      required this.userId,
      required this.title,
      required this.goal,
      required this.duration,
      required this.tasks});
}

//Project model
class Project extends ProjectsModel {
  Project(
      {required super.projectId,
      required super.userId,
      required super.title,
      required super.goal,
      required super.duration,
      required super.tasks, required super.timeCreated});

  Map<String, dynamic> toMap() {
    return {
      'project_id': projectId,
      'user_id': userId,
      'title': title,
      'goal': goal,
      'duration': duration,
      'created_at': timeCreated
    };
  }

  factory Project.fromMap(Map<String, dynamic> json) {
    return Project(
        projectId: json['project_id'],
        userId: json['time'],
        title: json['title'] ?? '',
        goal: json['description'] ?? '',
        duration: json['userId'] ?? '',
        timeCreated: json['created_at'] ?? '',
        tasks: List<Task>.from(json['tasks']));
  }
}
