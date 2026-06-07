import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/task.dart';
import 'auth_providers.dart';
import 'infrastructure_providers.dart';

final taskListProvider = StreamProvider<List<Task>>((ref) {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return Stream.value([]);
  return ref.watch(taskRepositoryProvider).watchTasks(user.uid);
});

final activeTasksProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(taskListProvider).value ?? [];
  return tasks.where((t) => !t.isCompleted).toList();
});

final completedTasksProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(taskListProvider).value ?? [];
  return tasks.where((t) => t.isCompleted).toList();
});

final overdueTasksProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(activeTasksProvider);
  final now = DateTime.now();
  return tasks
      .where((t) => t.dueDate != null && t.dueDate!.isBefore(now))
      .toList();
});

/// Resolve a single task by ID. Returns null if not found or still loading.
final taskByIdProvider = Provider.family<Task?, String>((ref, id) {
  return ref
      .watch(taskListProvider)
      .value
      ?.where((t) => t.id == id)
      .firstOrNull;
});

/// Active tasks sorted by quadrant priority (DO NOW → SCHEDULE → DELEGATE → ELIMINATE → unset).
final sortedActiveTasksProvider = Provider<List<Task>>((ref) {
  const order = {
    EisenhowerQuadrant.urgentImportant: 0,
    EisenhowerQuadrant.importantNotUrgent: 1,
    EisenhowerQuadrant.urgentNotImportant: 2,
    EisenhowerQuadrant.neither: 3,
  };
  final tasks = ref.watch(activeTasksProvider);
  return [...tasks]..sort((a, b) {
      final ao = a.quadrant != null ? (order[a.quadrant] ?? 4) : 4;
      final bo = b.quadrant != null ? (order[b.quadrant] ?? 4) : 4;
      return ao.compareTo(bo);
    });
});
