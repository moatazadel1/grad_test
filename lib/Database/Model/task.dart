import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  static const String collectName = "Tasks";
  String? id;
  String? title;
  String? description; // Corrected spelling
  Timestamp? dateTime;
  bool isDone;

  Task({
    this.id,
    this.title,
    this.description, // Corrected spelling
    this.dateTime,
    this.isDone = false,
  });

  Task.fromFirestore(Map<String, dynamic>? data)
      : this(
          id: data?["id"],
          title: data?["title"],
          description: data?["description"],
          dateTime: data?["dateTime"],
          isDone: data?["isDone"],
        );

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "dateTime": dateTime,
      "isDone": isDone,
    };
  }
}
