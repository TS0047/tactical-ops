import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/task_repository.dart';
import '../../data/repositories/daily_plan_repository.dart';
import '../../data/repositories/debrief_repository.dart';
import '../../data/repositories/reminder_repository.dart';
import '../../data/repositories/quote_repository.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final authRepositoryProvider = Provider<AuthRepository>((ref) =>
    AuthRepository(ref.watch(firebaseAuthProvider), ref.watch(firestoreProvider)));

final taskRepositoryProvider = Provider<TaskRepository>(
    (ref) => TaskRepository(ref.watch(firestoreProvider)));

final dailyPlanRepositoryProvider = Provider<DailyPlanRepository>(
    (ref) => DailyPlanRepository(ref.watch(firestoreProvider)));

final debriefRepositoryProvider = Provider<DebriefRepository>(
    (ref) => DebriefRepository(ref.watch(firestoreProvider)));

final reminderRepositoryProvider = Provider<ReminderRepository>(
    (ref) => ReminderRepository(ref.watch(firestoreProvider)));

final quoteRepositoryProvider = Provider<QuoteRepository>(
    (ref) => QuoteRepository(ref.watch(firestoreProvider)));
