import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/date_utils.dart';
import '../../../data/models/reminder.dart';
import '../../../presentation/providers/auth_providers.dart';
import '../../../presentation/providers/infrastructure_providers.dart';
import '../../../routing/route_names.dart';

final _reminderListProvider = StreamProvider<List<Reminder>>((ref) {
  final uid = ref.watch(authStateProvider).value?.uid;
  if (uid == null) return Stream.value([]);
  return ref.watch(reminderRepositoryProvider).watchReminders(uid);
});

class RemindersListScreen extends ConsumerWidget {
  const RemindersListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(_reminderListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.reminders)),
      body: remindersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (reminders) {
          if (reminders.isEmpty) {
            return const Center(
              child: Text('No active alerts.\nStand by.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.textMuted,
                      fontFamily: 'ShareTechMono',
                      fontSize: 14)),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: reminders.length,
            separatorBuilder: (_, __) => const SizedBox(height: 4),
            itemBuilder: (_, i) {
              final r = reminders[i];
              return Card(
                child: ListTile(
                  leading: Icon(
                    Icons.notifications_outlined,
                    color: r.isActive ? AppColors.olive : AppColors.textMuted,
                  ),
                  title: Text(r.title,
                      style: TextStyle(
                        color: r.isActive
                            ? AppColors.textPrimary
                            : AppColors.textMuted,
                      )),
                  subtitle: Text(
                    toMilitaryDate(r.scheduledAt) +
                        (r.repeat != ReminderRepeat.none
                            ? ' · ${r.repeat.name.toUpperCase()}'
                            : ''),
                    style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 11,
                        fontFamily: 'ShareTechMono'),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline,
                        color: AppColors.textMuted, size: 18),
                    onPressed: () => _delete(ref, r),
                  ),
                  onTap: () =>
                      context.push('/reminders/${r.id}/edit'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(Routes.newReminder),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _delete(WidgetRef ref, Reminder r) async {
    final uid = ref.read(authStateProvider).value?.uid;
    if (uid == null) return;
    await ref.read(reminderRepositoryProvider).deleteReminder(uid, r.id);
  }
}
