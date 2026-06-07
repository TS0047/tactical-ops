import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../data/models/daily_plan.dart';
import '../../../data/models/eisenhower_item.dart';
import '../../../data/models/task.dart';
import '../../../presentation/providers/daily_plan_providers.dart';
import '../../../presentation/providers/task_providers.dart';

class MorningBriefingScreen extends ConsumerWidget {
  const MorningBriefingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(morningBriefingProvider);
    final plan = ref.watch(todayPlanProvider).value;

    if (plan?.isSubmitted == true) {
      return _SubmittedView(plan: plan!);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.morningBriefing),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: LinearProgressIndicator(
            value: state.step == BriefingStep.priorities ? 0.5 : 1.0,
            backgroundColor: AppColors.border,
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppColors.olive),
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: state.step == BriefingStep.priorities
            ? const _PrioritiesStep()
            : const _MatrixStep(),
      ),
    );
  }
}

// ── Step 1: Priorities ─────────────────────────────────────────────────────

class _PrioritiesStep extends ConsumerWidget {
  const _PrioritiesStep();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(morningBriefingProvider.notifier);
    final state = ref.watch(morningBriefingProvider);
    final activeTasks = ref.watch(activeTasksProvider);

    // Resolve task IDs → Task objects for display
    final allTasks = ref.watch(taskListProvider).value ?? [];
    final selectedTasks = state.topFive
        .map((id) => allTasks.where((t) => t.id == id).firstOrNull)
        .toList();

    final count = state.topFive.length;
    final canAdd = count < 5;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Commander's Intent
        Text(AppStrings.commandersIntent,
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: state.commandersIntent,
          decoration:
              const InputDecoration(hintText: 'Today I will focus on...'),
          maxLines: 2,
          onChanged: notifier.setCommandersIntent,
        ),
        const SizedBox(height: 24),

        // Top 5 header
        Row(
          children: [
            Text(AppStrings.topFive,
                style: Theme.of(context).textTheme.titleLarge),
            const Spacer(),
            Text(
              '$count / 5',
              style: const TextStyle(
                color: AppColors.olive,
                fontFamily: 'ShareTechMono',
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Reorderable list of selected tasks
        if (state.topFive.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'No objectives selected.\nPick from your list or add a new one.',
              style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 12,
                  fontFamily: 'ShareTechMono'),
              textAlign: TextAlign.center,
            ),
          )
        else
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.topFive.length,
            onReorder: notifier.reorderTopFive,
            itemBuilder: (_, i) {
              final task = selectedTasks[i];
              final title = task?.title ?? state.topFive[i];
              return Padding(
                key: ValueKey(state.topFive[i]),
                padding: const EdgeInsets.only(bottom: 6),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ListTile(
                    dense: true,
                    leading: Text(
                      '${i + 1}',
                      style: const TextStyle(
                        color: AppColors.olive,
                        fontFamily: 'ShareTechMono',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title: Text(title,
                        style: const TextStyle(
                            color: AppColors.textPrimary, fontSize: 13)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => notifier.removeTopFiveTask(i),
                          child: const Icon(Icons.close,
                              size: 16, color: AppColors.textMuted),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.drag_handle,
                            color: AppColors.textMuted, size: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

        const SizedBox(height: 12),

        // Action buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: canAdd
                    ? () => _showTaskPicker(context, ref, activeTasks,
                        state.topFive, notifier)
                    : null,
                icon: const Icon(Icons.checklist_outlined, size: 16),
                label: const Text('PICK OBJECTIVE'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton.icon(
                onPressed:
                    canAdd ? () => _showNewObjectiveDialog(context, notifier) : null,
                icon: const Icon(Icons.add, size: 16),
                label: const Text('NEW OBJECTIVE'),
              ),
            ),
          ],
        ),

        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            if (state.topFive.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Add at least one objective.')));
              return;
            }
            notifier.goToMatrix();
          },
          child: const Text('NEXT: PRIORITIZATION MATRIX →'),
        ),
      ],
    );
  }

  void _showTaskPicker(
    BuildContext context,
    WidgetRef ref,
    List<Task> activeTasks,
    List<String> selectedIds,
    MorningBriefingNotifier notifier,
  ) {
    final available =
        activeTasks.where((t) => !selectedIds.contains(t.id)).toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      builder: (sheetCtx) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'SELECT OBJECTIVE',
            style: TextStyle(
                fontFamily: 'ShareTechMono',
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5),
          ),
          const SizedBox(height: 12),
          if (available.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'All objectives are selected\nor no objectives exist yet.',
                style: TextStyle(
                    color: AppColors.textMuted,
                    fontFamily: 'ShareTechMono',
                    fontSize: 12),
                textAlign: TextAlign.center,
              ),
            )
          else
            ...available.map(
              (t) => ListTile(
                title: Text(t.title,
                    style: const TextStyle(color: AppColors.textPrimary)),
                subtitle: t.quadrant != null
                    ? Text(
                        _quadrantLabel(t.quadrant!),
                        style: const TextStyle(
                            color: AppColors.textMuted, fontSize: 10),
                      )
                    : null,
                onTap: () {
                  notifier.addTopFiveTask(t.id);
                  Navigator.pop(sheetCtx);
                },
              ),
            ),
        ],
      ),
    );
  }

  void _showNewObjectiveDialog(
      BuildContext context, MorningBriefingNotifier notifier) {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('NEW OBJECTIVE',
            style: TextStyle(fontFamily: 'ShareTechMono', fontSize: 14)),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Objective title...'),
          onSubmitted: (_) {
            if (ctrl.text.trim().isNotEmpty) {
              notifier.addNewObjective(ctrl.text.trim());
              Navigator.pop(dialogCtx);
            }
          },
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: const Text('CANCEL')),
          ElevatedButton(
            onPressed: () {
              if (ctrl.text.trim().isNotEmpty) {
                notifier.addNewObjective(ctrl.text.trim());
              }
              Navigator.pop(dialogCtx);
            },
            child: const Text('CREATE'),
          ),
        ],
      ),
    );
  }

  String _quadrantLabel(EisenhowerQuadrant q) => switch (q) {
        EisenhowerQuadrant.urgentImportant => 'DO NOW',
        EisenhowerQuadrant.importantNotUrgent => 'SCHEDULE',
        EisenhowerQuadrant.urgentNotImportant => 'DELEGATE',
        EisenhowerQuadrant.neither => 'ELIMINATE',
      };
}

// ── Step 2: Eisenhower Matrix ──────────────────────────────────────────────

class _MatrixStep extends ConsumerWidget {
  const _MatrixStep();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(morningBriefingProvider.notifier);
    final state = ref.watch(morningBriefingProvider);
    final activeTasks = ref.watch(activeTasksProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(AppStrings.matrix,
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Row(
          children: [
            const Expanded(child: SizedBox()),
            Expanded(
                child: Center(
                    child: Text(AppStrings.urgent,
                        style: Theme.of(context).textTheme.labelSmall))),
            Expanded(
                child: Center(
                    child: Text(AppStrings.notUrgent,
                        style: Theme.of(context).textTheme.labelSmall))),
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
                child: Text(AppStrings.important,
                    style: Theme.of(context).textTheme.labelSmall),
              ),
            ),
            Expanded(
              child: _Quadrant(
                quadrant: EisenhowerQuadrant.urgentImportant,
                label: 'DO NOW',
                color: AppColors.q1,
                items: state.matrixItems
                    .where((i) =>
                        i.quadrant == EisenhowerQuadrant.urgentImportant)
                    .toList(),
                topFive: state.topFive,
                availableTasks: activeTasks,
                onAdd: notifier.addMatrixItem,
                onAddFromTask: (t) =>
                    notifier.addMatrixItemFromTask(t, EisenhowerQuadrant.urgentImportant),
                onRemove: notifier.removeMatrixItem,
                onToggle: notifier.toggleMatrixItem,
                onMove: notifier.moveMatrixItem,
              ),
            ),
            Expanded(
              child: _Quadrant(
                quadrant: EisenhowerQuadrant.importantNotUrgent,
                label: 'SCHEDULE',
                color: AppColors.q2,
                items: state.matrixItems
                    .where((i) =>
                        i.quadrant == EisenhowerQuadrant.importantNotUrgent)
                    .toList(),
                topFive: state.topFive,
                availableTasks: activeTasks,
                onAdd: notifier.addMatrixItem,
                onAddFromTask: (t) => notifier.addMatrixItemFromTask(
                    t, EisenhowerQuadrant.importantNotUrgent),
                onRemove: notifier.removeMatrixItem,
                onToggle: notifier.toggleMatrixItem,
                onMove: notifier.moveMatrixItem,
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
                child: Text(AppStrings.notImportant,
                    style: Theme.of(context).textTheme.labelSmall),
              ),
            ),
            Expanded(
              child: _Quadrant(
                quadrant: EisenhowerQuadrant.urgentNotImportant,
                label: 'DELEGATE',
                color: AppColors.q3,
                items: state.matrixItems
                    .where((i) =>
                        i.quadrant == EisenhowerQuadrant.urgentNotImportant)
                    .toList(),
                topFive: state.topFive,
                availableTasks: activeTasks,
                onAdd: notifier.addMatrixItem,
                onAddFromTask: (t) => notifier.addMatrixItemFromTask(
                    t, EisenhowerQuadrant.urgentNotImportant),
                onRemove: notifier.removeMatrixItem,
                onToggle: notifier.toggleMatrixItem,
                onMove: notifier.moveMatrixItem,
              ),
            ),
            Expanded(
              child: _Quadrant(
                quadrant: EisenhowerQuadrant.neither,
                label: 'ELIMINATE',
                color: AppColors.q4,
                items: state.matrixItems
                    .where((i) => i.quadrant == EisenhowerQuadrant.neither)
                    .toList(),
                topFive: state.topFive,
                availableTasks: activeTasks,
                onAdd: notifier.addMatrixItem,
                onAddFromTask: (t) => notifier.addMatrixItemFromTask(
                    t, EisenhowerQuadrant.neither),
                onRemove: notifier.removeMatrixItem,
                onToggle: notifier.toggleMatrixItem,
                onMove: notifier.moveMatrixItem,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: notifier.goToPriorities,
                child: const Text('← BACK'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: state.isSubmitting ? null : () => notifier.submit(),
                child: state.isSubmitting
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.textPrimary))
                    : const Text(AppStrings.submitBriefing),
              ),
            ),
          ],
        ),
        if (state.error != null) ...[
          const SizedBox(height: 8),
          Text(state.error!,
              style: const TextStyle(
                  color: AppColors.redLight, fontSize: 12)),
        ],
      ],
    );
  }
}

// ── Quadrant widget ────────────────────────────────────────────────────────

class _Quadrant extends StatelessWidget {
  const _Quadrant({
    required this.quadrant,
    required this.label,
    required this.color,
    required this.items,
    required this.topFive,
    required this.availableTasks,
    required this.onAdd,
    required this.onAddFromTask,
    required this.onRemove,
    required this.onToggle,
    required this.onMove,
  });

  final EisenhowerQuadrant quadrant;
  final String label;
  final Color color;
  final List<EisenhowerItem> items;
  final List<String> topFive;
  final List<Task> availableTasks;
  final void Function(EisenhowerItem) onAdd;
  final void Function(Task) onAddFromTask;
  final void Function(String) onRemove;
  final void Function(String) onToggle;
  final void Function(String id, EisenhowerQuadrant newQuadrant) onMove;

  @override
  Widget build(BuildContext context) {
    // Tasks not already in this quadrant
    final linkedIds = items.map((i) => i.linkedTaskId).whereType<String>().toSet();
    final pickable = availableTasks
        .where((t) => !linkedIds.contains(t.id))
        .toList();

    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        border: Border.all(color: color.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(4),
      ),
      constraints: const BoxConstraints(minHeight: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(label,
                    style: TextStyle(
                        color: color,
                        fontSize: 10,
                        fontFamily: 'ShareTechMono',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1)),
              ),
              // Link a task from objectives
              GestureDetector(
                onTap: () => _pickTask(context, pickable),
                child: const Icon(Icons.link,
                    size: 14, color: AppColors.textMuted),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ...items.map((item) => _ItemChip(
                item: item,
                isInTopFive: topFive.contains(item.linkedTaskId ?? item.text),
                onRemove: () => onRemove(item.id),
                onToggle: () => onToggle(item.id),
                onMove: (newQ) => onMove(item.id, newQ),
              )),
          InkWell(
            onTap: () => _addItem(context),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.add, size: 14, color: AppColors.textMuted),
                  SizedBox(width: 2),
                  Text('ADD',
                      style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 10,
                          fontFamily: 'ShareTechMono')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addItem(BuildContext context) {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text('ADD TO $label',
            style: const TextStyle(
                fontFamily: 'ShareTechMono', fontSize: 14)),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Item text...'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: const Text('CANCEL')),
          ElevatedButton(
            onPressed: () {
              if (ctrl.text.trim().isNotEmpty) {
                onAdd(EisenhowerItem(
                  id: const Uuid().v4(),
                  text: ctrl.text.trim(),
                  quadrant: quadrant,
                ));
              }
              Navigator.pop(dialogCtx);
            },
            child: const Text('ADD'),
          ),
        ],
      ),
    );
  }

  void _pickTask(BuildContext context, List<Task> pickable) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      builder: (sheetCtx) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('LINK OBJECTIVE TO $label',
              style: const TextStyle(
                  fontFamily: 'ShareTechMono',
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: 12)),
          const SizedBox(height: 12),
          if (pickable.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'No objectives available to link.',
                style: TextStyle(
                    color: AppColors.textMuted,
                    fontFamily: 'ShareTechMono',
                    fontSize: 12),
                textAlign: TextAlign.center,
              ),
            )
          else
            ...pickable.map(
              (t) => ListTile(
                title: Text(t.title,
                    style: const TextStyle(color: AppColors.textPrimary)),
                onTap: () {
                  Navigator.pop(sheetCtx);
                  onAddFromTask(t);
                },
              ),
            ),
        ],
      ),
    );
  }
}

// ── Item chip ──────────────────────────────────────────────────────────────

class _ItemChip extends StatelessWidget {
  const _ItemChip({
    required this.item,
    required this.isInTopFive,
    required this.onRemove,
    required this.onToggle,
    required this.onMove,
  });

  final EisenhowerItem item;
  final bool isInTopFive;
  final VoidCallback onRemove;
  final VoidCallback onToggle;
  final void Function(EisenhowerQuadrant) onMove;

  static final _quadrantMeta = [
    (EisenhowerQuadrant.urgentImportant, 'DO NOW', AppColors.q1),
    (EisenhowerQuadrant.importantNotUrgent, 'SCHEDULE', AppColors.q2),
    (EisenhowerQuadrant.urgentNotImportant, 'DELEGATE', AppColors.q3),
    (EisenhowerQuadrant.neither, 'ELIMINATE', AppColors.q4),
  ];

  void _showMoveSheet(BuildContext context) {
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
                'MOVE TO QUADRANT',
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
                '"${item.text}"',
                style: const TextStyle(
                    color: AppColors.textMuted, fontSize: 11),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              ..._quadrantMeta.map((meta) {
                final (q, label, color) = meta;
                final isCurrent = q == item.quadrant;
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
                          onMove(q);
                        },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showMoveSheet(context),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          children: [
            GestureDetector(
              onTap: onToggle,
              child: Icon(
                item.isCompleted
                    ? Icons.check_box_outlined
                    : Icons.check_box_outline_blank,
                size: 14,
                color: item.isCompleted
                    ? AppColors.ragGreen
                    : AppColors.textMuted,
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                item.text,
                style: TextStyle(
                  fontSize: 11,
                  color: item.isCompleted
                      ? AppColors.textMuted
                      : AppColors.textPrimary,
                  decoration:
                      item.isCompleted ? TextDecoration.lineThrough : null,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isInTopFive)
              const Padding(
                padding: EdgeInsets.only(left: 2),
                child: Icon(Icons.star, size: 10, color: AppColors.olive),
              ),
            const Padding(
              padding: EdgeInsets.only(left: 2),
              child: Icon(Icons.open_with, size: 10, color: AppColors.textMuted),
            ),
            const SizedBox(width: 2),
            GestureDetector(
              onTap: onRemove,
              child:
                  const Icon(Icons.close, size: 12, color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Submitted view ─────────────────────────────────────────────────────────

class _SubmittedView extends ConsumerWidget {
  const _SubmittedView({required this.plan});

  final DailyPlan plan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTasks = ref.watch(taskListProvider).value ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.morningBriefing)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Row(
            children: [
              Icon(Icons.check_circle, color: AppColors.ragGreen, size: 20),
              SizedBox(width: 8),
              Text('BRIEFED',
                  style: TextStyle(
                    color: AppColors.ragGreen,
                    fontFamily: 'ShareTechMono',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
            ],
          ),
          const SizedBox(height: 20),
          if (plan.commandersIntent != null) ...[
            Text(AppStrings.commandersIntent,
                style: Theme.of(context).textTheme.labelSmall),
            const SizedBox(height: 4),
            Text(plan.commandersIntent!,
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 16),
          ],
          Text(AppStrings.topFive,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          ...plan.topFive.asMap().entries.map<Widget>((e) {
            final task =
                allTasks.where((t) => t.id == e.value).firstOrNull;
            final title = task?.title ?? e.value;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Text('${e.key + 1}.',
                      style: const TextStyle(
                          color: AppColors.olive,
                          fontFamily: 'ShareTechMono',
                          fontSize: 13)),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Text(title,
                          style: Theme.of(context).textTheme.bodyLarge)),
                ],
              ),
            );
          }),
          const SizedBox(height: 24),

          // Matrix read-only view
          Text(AppStrings.matrix,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _ReadOnlyQuadrant(
                  label: 'DO NOW',
                  color: AppColors.q1,
                  items: plan.matrixItems
                      .where((i) =>
                          i.quadrant == EisenhowerQuadrant.urgentImportant)
                      .toList(),
                ),
              ),
              Expanded(
                child: _ReadOnlyQuadrant(
                  label: 'SCHEDULE',
                  color: AppColors.q2,
                  items: plan.matrixItems
                      .where((i) =>
                          i.quadrant == EisenhowerQuadrant.importantNotUrgent)
                      .toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _ReadOnlyQuadrant(
                  label: 'DELEGATE',
                  color: AppColors.q3,
                  items: plan.matrixItems
                      .where((i) =>
                          i.quadrant == EisenhowerQuadrant.urgentNotImportant)
                      .toList(),
                ),
              ),
              Expanded(
                child: _ReadOnlyQuadrant(
                  label: 'ELIMINATE',
                  color: AppColors.q4,
                  items: plan.matrixItems
                      .where((i) => i.quadrant == EisenhowerQuadrant.neither)
                      .toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Re-brief available before 14:00.')));
            },
            child: const Text(AppStrings.reBrief),
          ),
        ],
      ),
    );
  }
}

// ── Read-only quadrant (shown after briefing submitted) ────────────────────

class _ReadOnlyQuadrant extends StatelessWidget {
  const _ReadOnlyQuadrant({
    required this.label,
    required this.color,
    required this.items,
  });

  final String label;
  final Color color;
  final List<EisenhowerItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        border: Border.all(color: color.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(4),
      ),
      constraints: const BoxConstraints(minHeight: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontFamily: 'ShareTechMono',
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              )),
          const SizedBox(height: 6),
          if (items.isEmpty)
            const Text('—',
                style: TextStyle(color: AppColors.textMuted, fontSize: 11))
          else
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Icon(
                        item.isCompleted
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank,
                        size: 12,
                        color: item.isCompleted
                            ? AppColors.ragGreen
                            : AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        item.text,
                        style: TextStyle(
                          fontSize: 11,
                          color: item.isCompleted
                              ? AppColors.textMuted
                              : AppColors.textPrimary,
                          decoration: item.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
