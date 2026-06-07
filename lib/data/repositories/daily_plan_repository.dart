import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/daily_plan.dart';
import '../../core/constants/firestore_paths.dart';
import '../../core/utils/date_utils.dart';

class DailyPlanRepository {
  DailyPlanRepository(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<DailyPlan?> watchPlan(String uid, DateTime date) {
    final key = toDateKey(date);
    return _firestore
        .doc(FirestorePaths.dailyPlan(uid, key))
        .snapshots()
        .map((s) => s.exists ? DailyPlan.fromJson(s.data()!) : null);
  }

  Future<DailyPlan?> getPlan(String uid, DateTime date) async {
    final key = toDateKey(date);
    final doc =
        await _firestore.doc(FirestorePaths.dailyPlan(uid, key)).get();
    return doc.exists ? DailyPlan.fromJson(doc.data()!) : null;
  }

  Future<void> savePlan(DailyPlan plan) {
    final key = toDateKey(plan.date);
    final data = plan.toJson();
    // json_serializable doesn't auto-call toJson() on nested list items
    data['matrixItems'] = plan.matrixItems.map((i) => i.toJson()).toList();
    return _firestore
        .doc(FirestorePaths.dailyPlan(plan.userId, key))
        .set(data);
  }

  Future<List<DailyPlan>> getRecentPlans(String uid, int days) async {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    final snap = await _firestore
        .collection(FirestorePaths.dailyPlans(uid))
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(cutoff))
        .orderBy('date', descending: true)
        .get();
    return snap.docs.map((d) => DailyPlan.fromJson(d.data())).toList();
  }
}
