import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../data/models/task.dart';
import '../../../presentation/providers/auth_providers.dart';
import '../../../presentation/providers/infrastructure_providers.dart';

class TaskFormScreen extends ConsumerStatefulWidget {
  const TaskFormScreen({super.key, this.taskId});

  final String? taskId;

  @override
  ConsumerState<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends ConsumerState<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  TaskCategory _category = TaskCategory.mission;
  TaskPriority _priority = TaskPriority.medium;
  DateTime? _dueDate;
  bool _loading = false;
  Task? _existing;

  @override
  void initState() {
    super.initState();
    if (widget.taskId != null) _loadExisting();
  }

  Future<void> _loadExisting() async {
    final uid = ref.read(authStateProvider).value?.uid;
    if (uid == null) return;
    final task =
        await ref.read(taskRepositoryProvider).getTask(uid, widget.taskId!);
    if (task != null && mounted) {
      setState(() {
        _existing = task;
        _titleCtrl.text = task.title;
        _descCtrl.text = task.description ?? '';
        _category = task.category;
        _priority = task.priority;
        _dueDate = task.dueDate;
      });
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final uid = ref.read(authStateProvider).value?.uid;
    if (uid == null) return;
    setState(() => _loading = true);
    final now = DateTime.now();
    final task = Task(
      id: _existing?.id ?? const Uuid().v4(),
      userId: uid,
      title: _titleCtrl.text.trim(),
      description: _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim(),
      category: _category,
      priority: _priority,
      dueDate: _dueDate,
      isCompleted: _existing?.isCompleted ?? false,
      createdAt: _existing?.createdAt ?? now,
      updatedAt: now,
    );
    await ref.read(taskRepositoryProvider).createTask(task);
    if (mounted) context.pop();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.dark(primary: AppColors.olive),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskId == null
            ? AppStrings.newObjective
            : 'EDIT OBJECTIVE'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _titleCtrl,
              decoration: const InputDecoration(labelText: 'MISSION TITLE'),
              textCapitalization: TextCapitalization.sentences,
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descCtrl,
              decoration: const InputDecoration(labelText: 'DETAILS (OPTIONAL)'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<TaskCategory>(
              value: _category,
              decoration: const InputDecoration(labelText: 'CATEGORY'),
              dropdownColor: AppColors.surfaceElevated,
              items: TaskCategory.values
                  .map((c) => DropdownMenuItem(
                        value: c,
                        child: Text(c.name.toUpperCase()),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _category = v!),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<TaskPriority>(
              value: _priority,
              decoration: const InputDecoration(labelText: 'PRIORITY'),
              dropdownColor: AppColors.surfaceElevated,
              items: TaskPriority.values
                  .map((p) => DropdownMenuItem(
                        value: p,
                        child: Text(p.name.toUpperCase()),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _priority = v!),
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                _dueDate == null
                    ? 'SET DUE DATE'
                    : 'DUE: ${_dueDate!.day}/${_dueDate!.month}/${_dueDate!.year}',
                style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontFamily: 'ShareTechMono',
                    fontSize: 13),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.calendar_today_outlined,
                        color: AppColors.olive),
                    onPressed: _pickDate,
                  ),
                  if (_dueDate != null)
                    IconButton(
                      icon: const Icon(Icons.clear, color: AppColors.textMuted),
                      onPressed: () => setState(() => _dueDate = null),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _loading ? null : _save,
              child: _loading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: AppColors.textPrimary))
                  : const Text(AppStrings.save),
            ),
          ],
        ),
      ),
    );
  }
}
