import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/task.dart';
import '../../../presentation/providers/task_providers.dart';
import '../../../presentation/providers/infrastructure_providers.dart';
import '../../../presentation/providers/auth_providers.dart';

class MatrixScreen extends ConsumerWidget {
  const MatrixScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(taskListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PRIORITIZATION MATRIX'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context, ref),
        tooltip: 'Add objective to matrix',
        child: const Icon(Icons.add),
      ),
      body: tasksAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (tasks) {
          final active = tasks.where((t) => !t.isCompleted).toList();
          final unassigned =
              active.where((t) => t.quadrant == null).toList();
          final doNow = active
              .where((t) => t.quadrant == EisenhowerQuadrant.urgentImportant)
              .toList();
          final schedule = active
              .where(
                  (t) => t.quadrant == EisenhowerQuadrant.importantNotUrgent)
              .toList();
          final delegate = active
              .where(
                  (t) => t.quadrant == EisenhowerQuadrant.urgentNotImportant)
              .toList();
          final eliminate =
              active.where((t) => t.quadrant == EisenhowerQuadrant.neither).toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // ── Unassigned strip ──────────────────────────────────────
              if (unassigned.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    'UNASSIGNED — ${unassigned.length}',
                    style: const TextStyle(
                      fontFamily: 'ShareTechMono',
                      fontSize: 10,
                      color: AppColors.textMuted,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: unassigned
                      .map((t) => _UnassignedChip(task: t))
                      .toList(),
                ),
                const SizedBox(height: 16),
                const Divider(color: AppColors.border),
                const SizedBox(height: 12),
              ],

              // ── 2×2 Matrix ────────────────────────────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 40), // axis label space
                  Expanded(
                    child: Center(
                      child: Text('URGENT',
                          style: Theme.of(context).textTheme.labelSmall),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text('NOT URGENT',
                          style: Theme.of(context).textTheme.labelSmall),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 40,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text('IMPORTANT',
                          style: Theme.of(context).textTheme.labelSmall),
                    ),
                  ),
                  Expanded(
                    child: _MatrixQuadrant(
                      label: 'DO NOW',
                      color: AppColors.q1,
                      tasks: doNow,
                      quadrant: EisenhowerQuadrant.urgentImportant,
                    ),
                  ),
                  Expanded(
                    child: _MatrixQuadrant(
                      label: 'SCHEDULE',
                      color: AppColors.q2,
                      tasks: schedule,
                      quadrant: EisenhowerQuadrant.importantNotUrgent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 40,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text('NOT IMPORTANT',
                          style: Theme.of(context).textTheme.labelSmall),
                    ),
                  ),
                  Expanded(
                    child: _MatrixQuadrant(
                      label: 'DELEGATE',
                      color: AppColors.q3,
                      tasks: delegate,
                      quadrant: EisenhowerQuadrant.urgentNotImportant,
                    ),
                  ),
                  Expanded(
                    child: _MatrixQuadrant(
                      label: 'ELIMINATE',
                      color: AppColors.q4,
                      tasks: eliminate,
                      quadrant: EisenhowerQuadrant.neither,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

// ── Unassigned chip (tap to assign quadrant) ──────────────────────────────

class _UnassignedChip extends ConsumerWidget {
  const _UnassignedChip({required this.task});
  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _showMoveSheet(context, ref),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.swap_horiz, size: 14, color: AppColors.olive),
            const SizedBox(width: 6),
            Text(
              task.title,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMoveSheet(BuildContext context, WidgetRef ref) =>
      showQuadrantMoveSheet(context, task, ref);
}

// ── Matrix quadrant ───────────────────────────────────────────────────────

class _MatrixQuadrant extends StatelessWidget {
  const _MatrixQuadrant({
    required this.label,
    required this.color,
    required this.tasks,
    required this.quadrant,
  });

  final String label;
  final Color color;
  final List<Task> tasks;
  final EisenhowerQuadrant quadrant;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(minHeight: 120),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label  ${tasks.isNotEmpty ? tasks.length : ''}',
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontFamily: 'ShareTechMono',
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 6),
          if (tasks.isEmpty)
            const Text('—',
                style: TextStyle(color: AppColors.textMuted, fontSize: 11))
          else
            ...tasks.map((t) => _MatrixTaskTile(task: t)),
        ],
      ),
    );
  }
}

class _MatrixTaskTile extends ConsumerWidget {
  const _MatrixTaskTile({required this.task});
  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          // Tap title → task detail
          Expanded(
            child: GestureDetector(
              onTap: () => context.push('/tasks/${task.id}'),
              child: Text(
                task.title,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // Tap move icon → quadrant picker
          GestureDetector(
            onTap: () => showQuadrantMoveSheet(context, task, ref),
            child: const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Icon(Icons.swap_horiz,
                  size: 14, color: AppColors.textMuted),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Shared "move to quadrant" bottom sheet ────────────────────────────────

final _quadrantMeta = [
  (EisenhowerQuadrant.urgentImportant, 'DO NOW', AppColors.q1),
  (EisenhowerQuadrant.importantNotUrgent, 'SCHEDULE', AppColors.q2),
  (EisenhowerQuadrant.urgentNotImportant, 'DELEGATE', AppColors.q3),
  (EisenhowerQuadrant.neither, 'ELIMINATE', AppColors.q4),
];

void showQuadrantMoveSheet(
    BuildContext context, Task task, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.surface,
    builder: (sheetCtx) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ASSIGN TO QUADRANT',
              style: TextStyle(
                fontFamily: 'ShareTechMono',
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '"${task.title}"',
              style: const TextStyle(
                  color: AppColors.textMuted, fontSize: 11),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            ..._quadrantMeta.map((meta) {
              final (q, label, color) = meta;
              final isCurrent = q == task.quadrant;
              return ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                enabled: !isCurrent,
                leading: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: isCurrent ? AppColors.textMuted : color,
                    shape: BoxShape.circle,
                  ),
                ),
                title: Text(
                  label + (isCurrent ? '  (current)' : ''),
                  style: TextStyle(
                    fontFamily: 'ShareTechMono',
                    fontSize: 12,
                    color: isCurrent
                        ? AppColors.textMuted
                        : AppColors.textPrimary,
                  ),
                ),
                onTap: isCurrent
                    ? null
                    : () {
                        Navigator.pop(sheetCtx);
                        _updateTaskQuadrant(task, q, ref);
                      },
              );
            }),
          ],
        ),
      ),
    ),
  );
}

Future<void> _updateTaskQuadrant(
    Task task, EisenhowerQuadrant q, WidgetRef ref) async {
  final user = ref.read(authStateProvider).value;
  if (user == null) return;
  await ref.read(taskRepositoryProvider).updateTask(
    task.copyWith(quadrant: q, updatedAt: DateTime.now()),
  );
}

// ── Add new task from Matrix tab ──────────────────────────────────────────

void _showAddTaskDialog(BuildContext context, WidgetRef ref) {
  final ctrl = TextEditingController();
  EisenhowerQuadrant? selected;

  const meta = [
    (EisenhowerQuadrant.urgentImportant, 'DO NOW', AppColors.q1),
    (EisenhowerQuadrant.importantNotUrgent, 'SCHEDULE', AppColors.q2),
    (EisenhowerQuadrant.urgentNotImportant, 'DELEGATE', AppColors.q3),
    (EisenhowerQuadrant.neither, 'ELIMINATE', AppColors.q4),
  ];

  showDialog(
    context: context,
    builder: (dialogCtx) => StatefulBuilder(
      builder: (ctx, setDialogState) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('NEW OBJECTIVE',
            style: TextStyle(fontFamily: 'ShareTechMono', fontSize: 14)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: ctrl,
              autofocus: true,
              decoration:
                  const InputDecoration(hintText: 'Objective title...'),
            ),
            const SizedBox(height: 16),
            const Text('ASSIGN TO',
                style: TextStyle(
                    fontFamily: 'ShareTechMono',
                    fontSize: 10,
                    color: AppColors.textMuted,
                    letterSpacing: 1.5)),
            const SizedBox(height: 8),
            ...meta.map((m) {
              final (q, label, color) = m;
              return RadioListTile<EisenhowerQuadrant>(
                dense: true,
                contentPadding: EdgeInsets.zero,
                activeColor: color,
                value: q,
                groupValue: selected,
                title: Text(label,
                    style: TextStyle(
                        fontFamily: 'ShareTechMono',
                        fontSize: 12,
                        color: selected == q ? color : AppColors.textPrimary)),
                onChanged: (v) => setDialogState(() => selected = v),
              );
            }),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: const Text('CANCEL')),
          ElevatedButton(
            onPressed: selected == null
                ? null
                : () async {
                    final title = ctrl.text.trim();
                    if (title.isEmpty) return;
                    Navigator.pop(dialogCtx);
                    await _createTaskInMatrix(title, selected!, ref);
                  },
            child: const Text('CREATE'),
          ),
        ],
      ),
    ),
  );
}

Future<void> _createTaskInMatrix(
    String title, EisenhowerQuadrant quadrant, WidgetRef ref) async {
  final user = ref.read(authStateProvider).value;
  if (user == null) return;
  final now = DateTime.now();
  final task = Task(
    id: const Uuid().v4(),
    userId: user.uid,
    title: title,
    category: TaskCategory.mission,
    priority: TaskPriority.medium,
    status: TaskStatus.active,
    isCompleted: false,
    quadrant: quadrant,
    createdAt: now,
    updatedAt: now,
  );
  await ref.read(taskRepositoryProvider).createTask(task);
}
