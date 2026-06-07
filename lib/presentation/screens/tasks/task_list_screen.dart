import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/date_utils.dart';
import '../../../data/models/task.dart';
import '../../../presentation/providers/auth_providers.dart';
import '../../../presentation/providers/infrastructure_providers.dart';
import '../../../presentation/providers/task_providers.dart';
import '../../../routing/route_names.dart';

class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(taskListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.objectives)),
      body: tasksAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (tasks) {
          if (tasks.isEmpty) {
            return const Center(
              child: Text(
                AppStrings.noObjectives,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontFamily: 'ShareTechMono',
                  fontSize: 14,
                  letterSpacing: 1,
                ),
              ),
            );
          }

          // Sort active tasks: DO NOW first, then SCHEDULE, DELEGATE, ELIMINATE, unset last
          const quadrantOrder = {
            EisenhowerQuadrant.urgentImportant: 0,
            EisenhowerQuadrant.importantNotUrgent: 1,
            EisenhowerQuadrant.urgentNotImportant: 2,
            EisenhowerQuadrant.neither: 3,
          };
          final active = tasks.where((t) => !t.isCompleted).toList()
            ..sort((a, b) {
              final ao = a.quadrant != null ? (quadrantOrder[a.quadrant] ?? 4) : 4;
              final bo = b.quadrant != null ? (quadrantOrder[b.quadrant] ?? 4) : 4;
              return ao.compareTo(bo);
            });
          final done = tasks.where((t) => t.isCompleted).toList();

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              if (active.isNotEmpty) ...[
                _sectionHeader(context, 'ACTIVE — ${active.length}'),
                ...active.map((t) => _TaskTile(task: t)),
              ],
              if (done.isNotEmpty) ...[
                const SizedBox(height: 8),
                _sectionHeader(context, 'COMPLETE — ${done.length}'),
                ...done.map((t) => _TaskTile(task: t)),
              ],
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(Routes.newTask),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String label) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(label, style: Theme.of(context).textTheme.labelSmall),
      );
}

class _TaskTile extends ConsumerWidget {
  const _TaskTile({required this.task});

  final Task task;

  Color _priorityColor() {
    switch (task.priority) {
      case TaskPriority.critical:
        return AppColors.redLight;
      case TaskPriority.high:
        return AppColors.amber;
      case TaskPriority.medium:
        return AppColors.olive;
      case TaskPriority.low:
        return AppColors.textMuted;
    }
  }

  /// Small colored dot indicating which quadrant this task belongs to.
  Widget? _quadrantDot() {
    if (task.quadrant == null) return null;
    final color = switch (task.quadrant!) {
      EisenhowerQuadrant.urgentImportant => AppColors.q1,
      EisenhowerQuadrant.importantNotUrgent => AppColors.q2,
      EisenhowerQuadrant.urgentNotImportant => AppColors.q3,
      EisenhowerQuadrant.neither => AppColors.q4,
    };
    final label = switch (task.quadrant!) {
      EisenhowerQuadrant.urgentImportant => 'DO NOW',
      EisenhowerQuadrant.importantNotUrgent => 'SCHEDULE',
      EisenhowerQuadrant.urgentNotImportant => 'DELEGATE',
      EisenhowerQuadrant.neither => 'ELIMINATE',
    };
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 9,
            fontFamily: 'ShareTechMono',
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => _complete(ref),
              backgroundColor: AppColors.ragGreen,
              foregroundColor: Colors.white,
              icon: Icons.check,
              label: 'COMPLETE',
            ),
            SlidableAction(
              onPressed: (_) => _delete(ref),
              backgroundColor: AppColors.ragRed,
              foregroundColor: Colors.white,
              icon: Icons.delete_outline,
              label: 'DELETE',
            ),
          ],
        ),
        child: Card(
          child: InkWell(
            onTap: () => context.push('/tasks/${task.id}'),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 3,
                    height: 36,
                    decoration: BoxDecoration(
                      color: _priorityColor(),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: TextStyle(
                            color: task.isCompleted
                                ? AppColors.textMuted
                                : AppColors.textPrimary,
                            fontSize: 14,
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            if (task.dueDate != null) ...[
                              Text(
                                toMilitaryDate(task.dueDate!),
                                style: const TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 11,
                                  fontFamily: 'ShareTechMono',
                                ),
                              ),
                              if (task.quadrant != null)
                                const SizedBox(width: 8),
                            ],
                            if (_quadrantDot() != null) _quadrantDot()!,
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    task.category.name.toUpperCase(),
                    style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 10,
                        fontFamily: 'ShareTechMono'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _complete(WidgetRef ref) async {
    final uid = ref.read(authStateProvider).value?.uid;
    if (uid == null) return;
    await ref.read(taskRepositoryProvider).updateTask(
        task.copyWith(isCompleted: !task.isCompleted, updatedAt: DateTime.now()));
  }

  Future<void> _delete(WidgetRef ref) async {
    final uid = ref.read(authStateProvider).value?.uid;
    if (uid == null) return;
    await ref.read(taskRepositoryProvider).deleteTask(uid, task.id);
  }
}
