import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/debrief.dart';
import '../../core/constants/firestore_paths.dart';
import '../../core/utils/date_utils.dart';

class DebriefRepository {
  DebriefRepository(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<Debrief?> watchDebrief(String uid, DateTime date) {
    final key = toDateKey(date);
    return _firestore
        .doc(FirestorePaths.debrief(uid, key))
        .snapshots()
        .map((s) => s.exists ? Debrief.fromJson(s.data()!) : null);
  }

  Future<Debrief?> getDebrief(String uid, DateTime date) async {
    final key = toDateKey(date);
    final doc = await _firestore.doc(FirestorePaths.debrief(uid, key)).get();
    return doc.exists ? Debrief.fromJson(doc.data()!) : null;
  }

  Future<void> saveDebrief(Debrief debrief) {
    final key = toDateKey(debrief.date);
    return _firestore
        .doc(FirestorePaths.debrief(debrief.userId, key))
        .set(debrief.toJson());
  }

  Future<List<Debrief>> getRecentDebriefs(String uid, int days) async {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    final snap = await _firestore
        .collection(FirestorePaths.debriefs(uid))
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(cutoff))
        .orderBy('date', descending: true)
        .get();
    return snap.docs.map((d) => Debrief.fromJson(d.data())).toList();
  }
}
