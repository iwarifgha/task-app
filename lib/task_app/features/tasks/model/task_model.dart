import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String time;
  String title, id, description;
  final String userId;

  Task(
      {required this.time,
      required this.title,
      required this.description,
      required this.userId,
      required this.id});

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'title': title,
      'description': description,
      'userId': userId,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map, String id) {
    return Task(
      id: id,
      time: map['time'] ?? Timestamp.now().toString(),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      userId: map['userId'] ?? '',
    );
  }
}
