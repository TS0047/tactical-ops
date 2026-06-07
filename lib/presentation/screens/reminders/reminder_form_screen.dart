import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../data/models/reminder.dart';
import '../../../presentation/providers/auth_providers.dart';
import '../../../presentation/providers/infrastructure_providers.dart';

class ReminderFormScreen extends ConsumerStatefulWidget {
  const ReminderFormScreen({super.key, this.reminderId});

  final String? reminderId;

  @override
  ConsumerState<ReminderFormScreen> createState() =>
      _ReminderFormScreenState();
}

class _ReminderFormScreenState extends ConsumerState<ReminderFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _bodyCtrl = TextEditingController();
  DateTime _scheduledAt = DateTime.now().add(const Duration(hours: 1));
  ReminderRepeat _repeat = ReminderRepeat.none;
  bool _loading = false;

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _scheduledAt,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx)
            .copyWith(colorScheme: const ColorScheme.dark(primary: AppColors.olive)),
        child: child!,
      ),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_scheduledAt),
    );
    if (time == null) return;
    setState(() => _scheduledAt =
        DateTime(date.year, date.month, date.day, time.hour, time.minute));
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final uid = ref.read(authStateProvider).value?.uid;
    if (uid == null) return;
    setState(() => _loading = true);
    final reminder = Reminder(
      id: widget.reminderId ?? const Uuid().v4(),
      userId: uid,
      title: _titleCtrl.text.trim(),
      body: _bodyCtrl.text.trim().isEmpty ? null : _bodyCtrl.text.trim(),
      scheduledAt: _scheduledAt,
      repeat: _repeat,
      createdAt: DateTime.now(),
    );
    await ref.read(reminderRepositoryProvider).saveReminder(reminder);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.reminderId == null
              ? AppStrings.newReminder
              : 'EDIT ALERT')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _titleCtrl,
              decoration: const InputDecoration(labelText: 'ALERT TITLE'),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _bodyCtrl,
              decoration:
                  const InputDecoration(labelText: 'BODY (OPTIONAL)'),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'SCHEDULED: ${_scheduledAt.day}/${_scheduledAt.month}/${_scheduledAt.year} ${_scheduledAt.hour.toString().padLeft(2, '0')}${_scheduledAt.minute.toString().padLeft(2, '0')}H',
                style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontFamily: 'ShareTechMono',
                    fontSize: 13),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.access_time_outlined,
                    color: AppColors.olive),
                onPressed: _pickDateTime,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<ReminderRepeat>(
              value: _repeat,
              decoration: const InputDecoration(labelText: 'REPEAT'),
              dropdownColor: AppColors.surfaceElevated,
              items: ReminderRepeat.values
                  .map((r) => DropdownMenuItem(
                        value: r,
                        child: Text(r.name.toUpperCase()),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _repeat = v!),
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
