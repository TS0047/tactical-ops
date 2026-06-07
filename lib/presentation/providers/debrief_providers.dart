import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/debrief.dart';
import '../../core/utils/date_utils.dart';
import 'auth_providers.dart';
import 'daily_plan_providers.dart';
import 'infrastructure_providers.dart';
import 'task_providers.dart';

final todayDebriefProvider = StreamProvider<Debrief?>((ref) {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return Stream.value(null);
  return ref
      .watch(debriefRepositoryProvider)
      .watchDebrief(user.uid, todayNormalized());
});

final pastDebriefListProvider = FutureProvider<List<Debrief>>((ref) async {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return [];
  return ref.watch(debriefRepositoryProvider).getRecentDebriefs(user.uid, 30);
});

// ── Briefed task IDs provider (reactive — updates as plan loads) ───────────

/// Reactively derives today's Top 5 task IDs from the plan stream.
/// Using a separate provider avoids resetting DebriefNotifier state when
/// the plan loads after the notifier is first built.
final briefedTaskIdsProvider = Provider<List<String>>((ref) {
  final plan = ref.watch(todayPlanProvider).value;
  return plan?.topFive.where((id) => id.isNotEmpty).toList() ?? [];
});

// ── Night Debrief form state ───────────────────────────────────────────────

class DebriefState {
  const DebriefState({
    this.completed = const [],
    this.wins = const [],
    this.blockers = const [],
    this.carryOvers = const [],
    this.moodRating = RagStatus.green,
    this.freeNotes = '',
    this.isSubmitting = false,
    this.error,
    this.assignedTaskIds = const {},
  });

  final List<String> completed;
  final List<String> wins;
  final List<String> blockers;
  final List<String> carryOvers;
  final RagStatus moodRating;
  final String freeNotes;
  final bool isSubmitting;
  final String? error;

  /// Which briefed task IDs have already been dropped into a section.
  final Set<String> assignedTaskIds;

  DebriefState copyWith({
    List<String>? completed,
    List<String>? wins,
    List<String>? blockers,
    List<String>? carryOvers,
    RagStatus? moodRating,
    String? freeNotes,
    bool? isSubmitting,
    Object? error = _sentinel,
    Set<String>? assignedTaskIds,
  }) =>
      DebriefState(
        completed: completed ?? this.completed,
        wins: wins ?? this.wins,
        blockers: blockers ?? this.blockers,
        carryOvers: carryOvers ?? this.carryOvers,
        moodRating: moodRating ?? this.moodRating,
        freeNotes: freeNotes ?? this.freeNotes,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        error: identical(error, _sentinel) ? this.error : error as String?,
        assignedTaskIds: assignedTaskIds ?? this.assignedTaskIds,
      );

  static const _sentinel = Object();
}

class DebriefNotifier extends Notifier<DebriefState> {
  @override
  DebriefState build() {
    final overdue = ref.read(overdueTasksProvider);
    return DebriefState(
      carryOvers: overdue.map((t) => t.title).toList(),
    );
  }

  void addToSection(String section, String value) {
    if (value.trim().isEmpty) return;
    switch (section) {
      case 'completed':
        state = state.copyWith(completed: [...state.completed, value.trim()]);
      case 'wins':
        state = state.copyWith(wins: [...state.wins, value.trim()]);
      case 'blockers':
        state = state.copyWith(blockers: [...state.blockers, value.trim()]);
      case 'carryOvers':
        state =
            state.copyWith(carryOvers: [...state.carryOvers, value.trim()]);
    }
  }

  void removeFromSection(String section, int index) {
    switch (section) {
      case 'completed':
        final l = List<String>.from(state.completed)..removeAt(index);
        state = state.copyWith(completed: l);
      case 'wins':
        final l = List<String>.from(state.wins)..removeAt(index);
        state = state.copyWith(wins: l);
      case 'blockers':
        final l = List<String>.from(state.blockers)..removeAt(index);
        state = state.copyWith(blockers: l);
      case 'carryOvers':
        final l = List<String>.from(state.carryOvers)..removeAt(index);
        state = state.copyWith(carryOvers: l);
    }
  }

  void setMood(RagStatus status) => state = state.copyWith(moodRating: status);

  void setFreeNotes(String v) => state = state.copyWith(freeNotes: v);

  /// Called when a briefed-objective chip is dragged into a debrief section.
  /// Resolves the task ID to a title, adds it to the section, marks it
  /// assigned, and (for 'completed') marks the Task as complete in Firestore.
  Future<void> dropTaskIntoSection(String taskId, String section) async {
    final tasks = ref.read(taskListProvider).value ?? [];
    final task = tasks.where((t) => t.id == taskId).firstOrNull;
    final title = task?.title ?? taskId;

    addToSection(section, title);
    state = state.copyWith(
      assignedTaskIds: {...state.assignedTaskIds, taskId},
    );

    if (section == 'completed' && task != null) {
      await ref.read(taskRepositoryProvider).updateTask(
        task.copyWith(isCompleted: true, updatedAt: DateTime.now()),
      );
    }
  }

  Future<bool> submit() async {
    if (state.completed.isEmpty) {
      state = state.copyWith(
          error: 'Add at least one completed mission before submitting.');
      return false;
    }
    final user = ref.read(authStateProvider).value;
    if (user == null) return false;
    state = state.copyWith(isSubmitting: true, error: null);
    try {
      final now = DateTime.now();
      final debrief = Debrief(
        id: toDateKey(todayNormalized()),
        userId: user.uid,
        date: todayNormalized(),
        completed: state.completed,
        wins: state.wins,
        blockers: state.blockers,
        carryOvers: state.carryOvers,
        moodRating: state.moodRating,
        freeNotes: state.freeNotes.isEmpty ? null : state.freeNotes,
        submittedAt: now,
      );
      await ref.read(debriefRepositoryProvider).saveDebrief(debrief);
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: e.toString());
      return false;
    }
    state = state.copyWith(isSubmitting: false);
    return true;
  }
}

final debriefNotifierProvider =
    NotifierProvider.autoDispose<DebriefNotifier, DebriefState>(
        DebriefNotifier.new);
