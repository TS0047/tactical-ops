import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/date_utils.dart';
import '../../../data/models/debrief.dart';
import '../../../data/models/task.dart';
import '../../../presentation/providers/debrief_providers.dart';
import '../../../presentation/providers/task_providers.dart';
import '../../../routing/route_names.dart';
import 'debrief_summary_screen.dart';

class NightDebriefScreen extends ConsumerWidget {
  const NightDebriefScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final existing = ref.watch(todayDebriefProvider).value;
    if (existing != null) {
      return DebriefSummaryScreen(dateKey: toDateKey(DateTime.now()));
    }
    return const _DebriefForm();
  }
}

class _DebriefForm extends ConsumerWidget {
  const _DebriefForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(debriefNotifierProvider.notifier);
    final state = ref.watch(debriefNotifierProvider);
    final allTasks = ref.watch(taskListProvider).value ?? [];
    // briefedTaskIdsProvider is reactive — updates as soon as todayPlanProvider loads
    final briefedIds = ref.watch(briefedTaskIdsProvider);

    // Briefed objectives still in the source pool (not yet assigned)
    final unassigned = briefedIds
        .where((id) => !state.assignedTaskIds.contains(id))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.nightDebrief)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Drag-and-drop source strip ──────────────────────────────
          if (unassigned.isNotEmpty) ...[
            Row(
              children: [
                Text("TODAY'S OBJECTIVES",
                    style: Theme.of(context).textTheme.labelSmall),
                const SizedBox(width: 8),
                const Text(
                  'long-press to drag',
                  style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 9,
                      fontFamily: 'ShareTechMono'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: unassigned.map((taskId) {
                final task =
                    allTasks.where((t) => t.id == taskId).firstOrNull;
                final title = task?.title ?? taskId;
                return LongPressDraggable<String>(
                  data: taskId,
                  delay: const Duration(milliseconds: 200),
                  feedback: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.olive.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 12,
                          fontFamily: 'ShareTechMono',
                        ),
                      ),
                    ),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.3,
                    child: _SourceChip(title: title),
                  ),
                  child: _SourceChip(title: title),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Divider(color: AppColors.border),
            const SizedBox(height: 8),
          ],

          // ── Debrief sections ─────────────────────────────────────────
          _ChipSection(
            label: AppStrings.missionsCompleted,
            items: state.completed,
            onAdd: (v) => notifier.addToSection('completed', v),
            onRemove: (i) => notifier.removeFromSection('completed', i),
            required: true,
            onDrop: (id) => notifier.dropTaskIntoSection(id, 'completed'),
          ),
          const SizedBox(height: 16),
          _ChipSection(
            label: AppStrings.victories,
            items: state.wins,
            onAdd: (v) => notifier.addToSection('wins', v),
            onRemove: (i) => notifier.removeFromSection('wins', i),
            onDrop: (id) => notifier.dropTaskIntoSection(id, 'wins'),
          ),
          const SizedBox(height: 16),
          _ChipSection(
            label: AppStrings.obstaclesEncountered,
            items: state.blockers,
            onAdd: (v) => notifier.addToSection('blockers', v),
            onRemove: (i) => notifier.removeFromSection('blockers', i),
            onDrop: (id) => notifier.dropTaskIntoSection(id, 'blockers'),
          ),
          const SizedBox(height: 16),
          _ChipSection(
            label: AppStrings.carryOvers,
            items: state.carryOvers,
            onAdd: (v) => notifier.addToSection('carryOvers', v),
            onRemove: (i) => notifier.removeFromSection('carryOvers', i),
            onDrop: (id) => notifier.dropTaskIntoSection(id, 'carryOvers'),
          ),
          const SizedBox(height: 16),
          Text(AppStrings.operationalStatus,
              style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 8),
          _RagSelector(
            selected: state.moodRating,
            onChanged: notifier.setMood,
          ),
          const SizedBox(height: 16),
          Text(AppStrings.freeNotes,
              style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 8),
          TextField(
            maxLines: 5,
            decoration:
                const InputDecoration(hintText: 'After action notes...'),
            onChanged: notifier.setFreeNotes,
          ),
          if (state.error != null) ...[
            const SizedBox(height: 8),
            Text(state.error!,
                style:
                    const TextStyle(color: AppColors.redLight, fontSize: 12)),
          ],
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: state.isSubmitting
                ? null
                : () async {
                    final ok = await notifier.submit();
                    if (ok && context.mounted) {
                      context.go('/debrief/${toDateKey(DateTime.now())}');
                    }
                  },
            child: state.isSubmitting
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: AppColors.textPrimary))
                : const Text(AppStrings.submitDebrief),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

// ── Source chip (briefed objective waiting to be dragged) ──────────────────

class _SourceChip extends StatelessWidget {
  const _SourceChip({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.olive.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.drag_indicator,
              size: 12, color: AppColors.textMuted),
          const SizedBox(width: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textPrimary,
              fontFamily: 'ShareTechMono',
            ),
          ),
        ],
      ),
    );
  }
}

// ── Chip section with optional DragTarget ─────────────────────────────────

class _ChipSection extends StatefulWidget {
  const _ChipSection({
    required this.label,
    required this.items,
    required this.onAdd,
    required this.onRemove,
    this.required = false,
    this.onDrop,
  });

  final String label;
  final List<String> items;
  final void Function(String) onAdd;
  final void Function(int) onRemove;
  final bool required;
  final void Function(String taskId)? onDrop;

  @override
  State<_ChipSection> createState() => _ChipSectionState();
}

class _ChipSectionState extends State<_ChipSection> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(widget.label,
                style: Theme.of(context).textTheme.labelSmall),
            if (widget.required)
              const Text(' *',
                  style: TextStyle(
                      color: AppColors.redLight,
                      fontFamily: 'ShareTechMono',
                      fontSize: 10)),
            if (widget.onDrop != null) ...[
              const SizedBox(width: 8),
              const Text(
                '← drop here',
                style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 9,
                    fontFamily: 'ShareTechMono'),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            ...widget.items.asMap().entries.map(
                  (e) => Chip(
                    label: Text(e.value,
                        style: const TextStyle(fontSize: 12)),
                    deleteIcon: const Icon(Icons.close, size: 14),
                    onDeleted: () => widget.onRemove(e.key),
                  ),
                ),
            SizedBox(
              width: 160,
              height: 36,
              child: TextField(
                controller: _ctrl,
                style: const TextStyle(fontSize: 12),
                decoration: const InputDecoration(
                  hintText: 'Add...',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
                onSubmitted: (v) {
                  if (v.trim().isNotEmpty) {
                    widget.onAdd(v.trim());
                    _ctrl.clear();
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onDrop == null) return _content();

    return DragTarget<String>(
      onAcceptWithDetails: (details) => widget.onDrop!(details.data),
      builder: (ctx, candidateData, _) {
        final hovering = candidateData.isNotEmpty;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: hovering
                ? AppColors.olive.withValues(alpha: 0.08)
                : Colors.transparent,
            border: Border.all(
              color: hovering ? AppColors.olive : Colors.transparent,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: _content(),
        );
      },
    );
  }
}

// ── RAG selector ──────────────────────────────────────────────────────────

class _RagSelector extends StatelessWidget {
  const _RagSelector({required this.selected, required this.onChanged});

  final RagStatus selected;
  final void Function(RagStatus) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: RagStatus.values.map((r) {
        final isSelected = r == selected;
        final color = r == RagStatus.green
            ? AppColors.ragGreen
            : r == RagStatus.amber
                ? AppColors.ragAmber
                : AppColors.ragRed;
        final label = r == RagStatus.green
            ? AppStrings.ragGreen
            : r == RagStatus.amber
                ? AppStrings.ragAmber
                : AppStrings.ragRed;
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () => onChanged(r),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? color.withValues(alpha: 0.2)
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected ? color : AppColors.border,
                  width: isSelected ? 1.5 : 1,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration:
                        BoxDecoration(color: color, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 6),
                  Text(label,
                      style: TextStyle(
                        fontFamily: 'ShareTechMono',
                        fontSize: 12,
                        color:
                            isSelected ? color : AppColors.textMuted,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      )),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
