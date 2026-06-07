import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/daily_plan.dart';
import '../../data/models/eisenhower_item.dart';
import '../../data/models/task.dart';
import '../../core/utils/date_utils.dart';
import 'auth_providers.dart';
import 'infrastructure_providers.dart';
import 'task_providers.dart';

final todayPlanProvider = StreamProvider<DailyPlan?>((ref) {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return Stream.value(null);
  return ref
      .watch(dailyPlanRepositoryProvider)
      .watchPlan(user.uid, todayNormalized());
});

// ── Morning Briefing wizard state ──────────────────────────────────────────

enum BriefingStep { priorities, matrix }

class MorningBriefingState {
  const MorningBriefingState({
    this.step = BriefingStep.priorities,
    this.commandersIntent = '',
    this.topFive = const [],   // stores task IDs (0-5 items)
    this.matrixItems = const [],
    this.isSubmitting = false,
    this.error,
  });

  final BriefingStep step;
  final String commandersIntent;
  final List<String> topFive; // task IDs, not free text
  final List<EisenhowerItem> matrixItems;
  final bool isSubmitting;
  final String? error;

  MorningBriefingState copyWith({
    BriefingStep? step,
    String? commandersIntent,
    List<String>? topFive,
    List<EisenhowerItem>? matrixItems,
    bool? isSubmitting,
    Object? error = _sentinel,
  }) =>
      MorningBriefingState(
        step: step ?? this.step,
        commandersIntent: commandersIntent ?? this.commandersIntent,
        topFive: topFive ?? this.topFive,
        matrixItems: matrixItems ?? this.matrixItems,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        error: identical(error, _sentinel) ? this.error : error as String?,
      );

  static const _sentinel = Object();
}

class MorningBriefingNotifier extends Notifier<MorningBriefingState> {
  @override
  MorningBriefingState build() {
    final plan = ref.watch(todayPlanProvider).value;
    return _fromExisting(plan);
  }

  static MorningBriefingState _fromExisting(DailyPlan? plan) {
    if (plan == null) return const MorningBriefingState();
    return MorningBriefingState(
      commandersIntent: plan.commandersIntent ?? '',
      topFive: plan.topFive, // already task IDs
      matrixItems: plan.matrixItems,
    );
  }

  void setCommandersIntent(String v) =>
      state = state.copyWith(commandersIntent: v);

  // ── Top 5 management (task-ID based) ────────────────────────────────────

  /// Add a task to the Top 5 by its ID.
  void addTopFiveTask(String taskId) {
    if (state.topFive.length >= 5) return;
    if (state.topFive.contains(taskId)) return;
    state = state.copyWith(topFive: [...state.topFive, taskId]);
  }

  /// Remove a task from the Top 5 by list index.
  void removeTopFiveTask(int index) {
    final list = List<String>.from(state.topFive)..removeAt(index);
    state = state.copyWith(topFive: list);
  }

  void reorderTopFive(int oldIndex, int newIndex) {
    final list = List<String>.from(state.topFive);
    if (newIndex > oldIndex) newIndex--;
    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
    state = state.copyWith(topFive: list);
  }

  /// Create a new Task in Firestore and add it to the Top 5.
  Future<void> addNewObjective(String title) async {
    final user = ref.read(authStateProvider).value;
    if (user == null) return;
    if (state.topFive.length >= 5) return;

    final taskId = const Uuid().v4();
    final now = DateTime.now();
    final task = Task(
      id: taskId,
      userId: user.uid,
      title: title,
      category: TaskCategory.mission,
      priority: TaskPriority.medium,
      status: TaskStatus.active,
      isCompleted: false,
      createdAt: now,
      updatedAt: now,
    );
    await ref.read(taskRepositoryProvider).createTask(task);
    addTopFiveTask(taskId);
  }

  void goToMatrix() => state = state.copyWith(step: BriefingStep.matrix);
  void goToPriorities() => state = state.copyWith(step: BriefingStep.priorities);

  // ── Matrix management ────────────────────────────────────────────────────

  void addMatrixItem(EisenhowerItem item) {
    state = state.copyWith(matrixItems: [...state.matrixItems, item]);
  }

  /// Add an existing Task to the matrix. If the task is already linked in
  /// another quadrant, moves it rather than adding a duplicate.
  Future<void> addMatrixItemFromTask(
      Task task, EisenhowerQuadrant quadrant) async {
    // Check if this task is already linked somewhere in the matrix
    final existing = state.matrixItems
        .where((i) => i.linkedTaskId == task.id)
        .firstOrNull;

    if (existing != null) {
      // Move it to the new quadrant instead of duplicating
      await moveMatrixItem(existing.id, quadrant);
      return;
    }

    final item = EisenhowerItem(
      id: const Uuid().v4(),
      text: task.title,
      quadrant: quadrant,
      linkedTaskId: task.id,
    );
    state = state.copyWith(matrixItems: [...state.matrixItems, item]);
    final user = ref.read(authStateProvider).value;
    if (user == null) return;
    await ref.read(taskRepositoryProvider).updateTask(
      task.copyWith(quadrant: quadrant, updatedAt: DateTime.now()),
    );
  }

  void removeMatrixItem(String id) {
    state = state.copyWith(
        matrixItems: state.matrixItems.where((i) => i.id != id).toList());
  }

  void toggleMatrixItem(String id) {
    state = state.copyWith(
      matrixItems: state.matrixItems
          .map((i) => i.id == id ? i.copyWith(isCompleted: !i.isCompleted) : i)
          .toList(),
    );
  }

  /// Move an item to a different quadrant. If the item has a linked task,
  /// also updates Task.quadrant in Firestore.
  Future<void> moveMatrixItem(String id, EisenhowerQuadrant newQuadrant) async {
    final item = state.matrixItems.where((i) => i.id == id).firstOrNull;
    if (item == null) return;

    state = state.copyWith(
      matrixItems: state.matrixItems
          .map((i) => i.id == id ? i.copyWith(quadrant: newQuadrant) : i)
          .toList(),
    );

    if (item.linkedTaskId != null) {
      final user = ref.read(authStateProvider).value;
      if (user == null) return;
      final task = await ref
          .read(taskRepositoryProvider)
          .getTask(user.uid, item.linkedTaskId!);
      if (task != null) {
        await ref.read(taskRepositoryProvider).updateTask(
          task.copyWith(quadrant: newQuadrant, updatedAt: DateTime.now()),
        );
      }
    }
  }

  Future<void> submit() async {
    final user = ref.read(authStateProvider).value;
    if (user == null) return;
    state = state.copyWith(isSubmitting: true, error: null);
    try {
      final existing = await ref
          .read(dailyPlanRepositoryProvider)
          .getPlan(user.uid, todayNormalized());
      final now = DateTime.now();
      final plan = DailyPlan(
        id: toDateKey(todayNormalized()),
        userId: user.uid,
        date: todayNormalized(),
        topFive: state.topFive, // task IDs
        matrixItems: state.matrixItems,
        commandersIntent:
            state.commandersIntent.isEmpty ? null : state.commandersIntent,
        isSubmitted: true,
        createdAt: existing?.createdAt ?? now,
        updatedAt: now,
      );
      await ref.read(dailyPlanRepositoryProvider).savePlan(plan);
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: e.toString());
      return;
    }
    state = state.copyWith(isSubmitting: false);
  }
}

final morningBriefingProvider = NotifierProvider.autoDispose<
    MorningBriefingNotifier,
    MorningBriefingState>(MorningBriefingNotifier.new);
