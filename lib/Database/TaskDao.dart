import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_app/Database/Model/task.dart';
import 'package:new_app/Database/UserDao.dart';

class TaskDao {
  static CollectionReference<Task> getTaskCollection(String uid) {
    return UserDao.getUserCollection()
        .doc(uid)
        .collection(Task.collectName)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              Task.fromFirestore(snapshot.data()),
          toFirestore: (task, options) => task.toFirestore(),
        );
  }

  static Future<void> createTask(Task task, String uid) async {
    var docRef = getTaskCollection(uid).doc();
    task.id = docRef.id;
    await docRef.set(task);
  }

  static Future<List<Task>> getAllTasks(String uid) async {
    var taskSnapshot = await getTaskCollection(uid).get();
    var tasklist = taskSnapshot.docs
        .map((snapshot) => snapshot.data())
        .toList()
        .cast<Task>(); // Ensure the list is of type Task
    return tasklist;
  }

  static Stream<List<Task>> listenForTasks(String uid) async* {
    var stream = getTaskCollection(uid).snapshots();
    yield* stream.map((querySnapshot) =>
        querySnapshot.docs.map((doc) => doc.data()).toList());
  }

  static Future<void> removeTask(String taskId, String uid) async {
    await getTaskCollection(uid).doc(taskId).delete();
  }
}
