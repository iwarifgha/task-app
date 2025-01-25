import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TaskModel {
  final String timeCreated;
  String title, description, startDate, endDate;
  final String taskId;

  TaskModel(
      {required this.timeCreated,
      required this.title,
      required this.description,
      required this.taskId,
      required this.startDate,
      required this.endDate});
}

class Task extends TaskModel {
  Task(
      {required super.timeCreated,
      required super.title,
      required super.description,
      required super.taskId,
      required super.startDate,
      required super.endDate});

  Map<String, dynamic> toMap() {
    return {
      'created_at': timeCreated,
      'title': title,
      'description': description,
      'start_date': startDate,
      'end_date': endDate,
      'task_id' : taskId
    };
  }

  factory Task.fromMap(Map<String, dynamic> map, {required String taskId}) {
    return Task(
      taskId: taskId,
      timeCreated: map['created_at']?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      startDate: map['start_date'] ?? '',
      endDate: map['start_date'] ?? '',
    );
  }
}
