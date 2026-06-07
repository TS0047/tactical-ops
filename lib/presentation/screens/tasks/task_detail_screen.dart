import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/date_utils.dart';
import '../../../data/models/task.dart';
import '../../../presentation/providers/auth_providers.dart';
import '../../../presentation/providers/infrastructure_providers.dart';
import '../../../presentation/providers/task_providers.dart';

class TaskDetailScreen extends ConsumerWidget {
  const TaskDetailScreen({super.key, required this.taskId});

  final String taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskListProvider).value ?? [];
    final task = tasks.cast<Task?>().firstWhere(
          (t) => t?.id == taskId,
          orElse: () => null,
        );

    if (task == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('OBJECTIVE')),
        body: const Center(child: Text('Not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('OBJECTIVE'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => context.push('/tasks/$taskId/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.redLight),
            onPressed: () => _confirmDelete(context, ref, task),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _field(context, 'MISSION', task.title),
          if (task.description != null) _field(context, 'DETAILS', task.description!),
          _field(context, 'CATEGORY', task.category.name.toUpperCase()),
          _field(context, 'PRIORITY', task.priority.name.toUpperCase()),
          _field(context, 'STATUS',
              task.isCompleted ? 'COMPLETE' : 'ACTIVE'),
          if (task.dueDate != null)
            _field(context, 'DUE DATE', toMilitaryDate(task.dueDate!)),
          _field(context, 'CREATED', toMilitaryDate(task.createdAt)),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => _toggleComplete(ref, task),
            icon: Icon(task.isCompleted
                ? Icons.undo_outlined
                : Icons.check_circle_outline),
            label: Text(task.isCompleted ? 'MARK ACTIVE' : 'MARK COMPLETE'),
            style: ElevatedButton.styleFrom(
              backgroundColor: task.isCompleted
                  ? AppColors.amber
                  : AppColors.ragGreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(BuildContext context, String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.labelSmall),
            const SizedBox(height: 4),
            Text(value, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      );

  Future<void> _toggleComplete(WidgetRef ref, Task task) async {
    await ref.read(taskRepositoryProvider).updateTask(
          task.copyWith(
            isCompleted: !task.isCompleted,
            updatedAt: DateTime.now(),
          ),
        );
  }

  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, Task task) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('DELETE OBJECTIVE',
            style: TextStyle(fontFamily: 'ShareTechMono')),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('CANCEL')),
          TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('DELETE',
                  style: TextStyle(color: AppColors.redLight))),
        ],
      ),
    );
    if (confirmed == true) {
      final uid = ref.read(authStateProvider).value?.uid;
      final repo = ref.read(taskRepositoryProvider);
      if (uid == null || !context.mounted) return;
      context.pop(); // navigate back before Firestore stream fires
      await repo.deleteTask(uid, task.id); // ref may be deactivated after pop
    }
  }
}
