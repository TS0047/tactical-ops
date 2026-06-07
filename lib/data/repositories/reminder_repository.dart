import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/reminder.dart';
import '../../core/constants/firestore_paths.dart';

class ReminderRepository {
  ReminderRepository(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<List<Reminder>> watchReminders(String uid) => _firestore
      .collection(FirestorePaths.reminders(uid))
      .orderBy('scheduledAt')
      .snapshots()
      .map((s) => s.docs.map((d) => Reminder.fromJson(d.data())).toList());

  Future<void> saveReminder(Reminder reminder) => _firestore
      .doc(FirestorePaths.reminder(reminder.userId, reminder.id))
      .set(reminder.toJson());

  Future<void> deleteReminder(String uid, String id) =>
      _firestore.doc(FirestorePaths.reminder(uid, id)).delete();

  Future<void> updateReminder(Reminder reminder) => _firestore
      .doc(FirestorePaths.reminder(reminder.userId, reminder.id))
      .update(reminder.toJson());
}
