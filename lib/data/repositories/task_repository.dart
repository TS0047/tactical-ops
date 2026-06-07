import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';
import '../../core/constants/firestore_paths.dart';

class TaskRepository {
  TaskRepository(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<List<Task>> watchTasks(String uid) => _firestore
      .collection(FirestorePaths.tasks(uid))
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((s) => s.docs.map((d) => Task.fromJson(d.data())).toList());

  Future<void> createTask(Task task) => _firestore
      .doc(FirestorePaths.task(task.userId, task.id))
      .set(task.toJson());

  Future<void> updateTask(Task task) => _firestore
      .doc(FirestorePaths.task(task.userId, task.id))
      .update(task.toJson());

  Future<void> deleteTask(String uid, String taskId) =>
      _firestore.doc(FirestorePaths.task(uid, taskId)).delete();

  Future<Task?> getTask(String uid, String taskId) async {
    final doc = await _firestore.doc(FirestorePaths.task(uid, taskId)).get();
    return doc.exists ? Task.fromJson(doc.data()!) : null;
  }
}
