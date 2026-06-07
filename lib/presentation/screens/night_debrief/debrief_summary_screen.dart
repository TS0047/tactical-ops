import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/date_utils.dart';
import '../../../data/models/debrief.dart';
import '../../../presentation/providers/auth_providers.dart';
import '../../../presentation/providers/infrastructure_providers.dart';

final _debriefByDateProvider =
    FutureProvider.family<Debrief?, String>((ref, dateKey) async {
  final uid = ref.watch(authStateProvider).value?.uid;
  if (uid == null) return null;
  return ref
      .watch(debriefRepositoryProvider)
      .getDebrief(uid, dateFromKey(dateKey));
});

class DebriefSummaryScreen extends ConsumerWidget {
  const DebriefSummaryScreen({super.key, required this.dateKey});

  final String dateKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debriefAsync = ref.watch(_debriefByDateProvider(dateKey));

    return Scaffold(
      appBar: AppBar(
        title: Text('DEBRIEF — ${toMilitaryDate(dateFromKey(dateKey))}'),
      ),
      body: debriefAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (debrief) {
          if (debrief == null) {
            return const Center(
              child: Text('No debrief found.',
                  style: TextStyle(color: AppColors.textMuted)),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _RagBadge(status: debrief.moodRating),
              const SizedBox(height: 20),
              if (debrief.completed.isNotEmpty)
                _Section(
                    label: 'MISSIONS COMPLETED',
                    items: debrief.completed),
              if (debrief.wins.isNotEmpty)
                _Section(label: 'VICTORIES', items: debrief.wins),
              if (debrief.blockers.isNotEmpty)
                _Section(
                    label: 'OBSTACLES ENCOUNTERED',
                    items: debrief.blockers),
              if (debrief.carryOvers.isNotEmpty)
                _Section(
                    label: 'CARRY-OVERS', items: debrief.carryOvers),
              if (debrief.freeNotes != null) ...[
                Text('AFTER ACTION NOTES',
                    style: Theme.of(context).textTheme.labelSmall),
                const SizedBox(height: 8),
                Text(debrief.freeNotes!,
                    style: Theme.of(context).textTheme.bodyLarge),
              ],
              const SizedBox(height: 20),
              Text(
                'SUBMITTED ${toMilitaryDate(debrief.submittedAt)}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _RagBadge extends StatelessWidget {
  const _RagBadge({required this.status});

  final RagStatus status;

  @override
  Widget build(BuildContext context) {
    final color = status == RagStatus.green
        ? AppColors.ragGreen
        : status == RagStatus.amber
            ? AppColors.ragAmber
            : AppColors.ragRed;
    final label = status == RagStatus.green
        ? 'GREEN'
        : status == RagStatus.amber
            ? 'AMBER'
            : 'RED';
    return Row(
      children: [
        Container(
            width: 12, height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text('STATUS: $label',
            style: TextStyle(
              color: color,
              fontFamily: 'ShareTechMono',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            )),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.label, required this.items});

  final String label;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 8),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ',
                      style: TextStyle(
                          color: AppColors.olive,
                          fontFamily: 'ShareTechMono')),
                  Expanded(
                    child: Text(item,
                        style: Theme.of(context).textTheme.bodyLarge),
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
