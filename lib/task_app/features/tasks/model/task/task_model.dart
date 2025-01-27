import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TaskModel {
  final String timeCreated;
  String title, description;
  final DateTime startDate, endDate;
  final String taskId;
  final bool isCompleted;

  TaskModel(
      {required this.timeCreated,
      required this.title,
      required this.description,
      required this.taskId,
      required this.startDate,
      required this.endDate,
      required this.isCompleted
      });
}

class Task extends TaskModel {
  Task(
      {required super.timeCreated,
      required super.title,
      required super.description,
      required super.taskId,
      required super.startDate,
      required super.endDate,
      required super.isCompleted
      });

  Map<String, dynamic> toMap() {
    return {
      'created_at': timeCreated,
      'title': title,
      'description': description,
      'start_date': Timestamp.fromDate(startDate),
      'end_date': Timestamp.fromDate(endDate),
      'task_id': taskId,
      'is_completed': isCompleted
    };
  }

  factory Task.fromMap(Map<String, dynamic> map, {required String taskId}) {
    return Task(
      taskId: taskId,
      timeCreated: map['created_at'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      startDate: (map['start_date'] as Timestamp).toDate(),
      endDate: (map['end_date'] as Timestamp).toDate(),
      isCompleted: map['is_completed'] ?? false
    );
  }
}
