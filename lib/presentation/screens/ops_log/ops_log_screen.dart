import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/date_utils.dart';
import '../../../data/models/daily_plan.dart';
import '../../../data/models/debrief.dart';
import '../../../presentation/providers/auth_providers.dart';
import '../../../presentation/providers/debrief_providers.dart';
import '../../../presentation/providers/infrastructure_providers.dart';

class OpsLogEntry {
  const OpsLogEntry({required this.date, this.plan, this.debrief});

  final DateTime date;
  final DailyPlan? plan;
  final Debrief? debrief;

  bool get wasBriefed => plan?.isSubmitted == true;
  bool get wasDebriefed => debrief != null;
  String? get ragStatus => debrief?.moodRating.name;
  int get objectivesCompleted =>
      plan?.matrixItems.where((i) => i.isCompleted).length ?? 0;
  int get objectivesTotal => plan?.matrixItems.length ?? 0;
}

final opsLogProvider = FutureProvider<List<OpsLogEntry>>((ref) async {
  final uid = ref.watch(authStateProvider).value?.uid;
  if (uid == null) return [];
  final futures = await Future.wait([
    ref.watch(dailyPlanRepositoryProvider).getRecentPlans(uid, 30),
    ref.watch(debriefRepositoryProvider).getRecentDebriefs(uid, 30),
  ]);
  final plans = futures[0] as List<DailyPlan>;
  final debriefs = futures[1] as List<Debrief>;

  final planMap = {for (final p in plans) toDateKey(p.date): p};
  final debriefMap = {for (final d in debriefs) toDateKey(d.date): d};

  final allKeys = {...planMap.keys, ...debriefMap.keys}.toList()..sort();
  allKeys.sort((a, b) => b.compareTo(a));

  return allKeys
      .map((k) => OpsLogEntry(
            date: dateFromKey(k),
            plan: planMap[k],
            debrief: debriefMap[k],
          ))
      .toList();
});

class OpsLogScreen extends ConsumerWidget {
  const OpsLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logAsync = ref.watch(opsLogProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.opsLog)),
      body: logAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (entries) {
          if (entries.isEmpty) {
            return const Center(
              child: Text(
                'No operations logged yet.\nComplete a briefing or debrief to see history.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.textMuted,
                    fontFamily: 'ShareTechMono',
                    fontSize: 13),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: entries.length,
            separatorBuilder: (_, __) => const SizedBox(height: 4),
            itemBuilder: (_, i) => _DayRecord(entry: entries[i]),
          );
        },
      ),
    );
  }
}

class _DayRecord extends StatefulWidget {
  const _DayRecord({required this.entry});

  final OpsLogEntry entry;

  @override
  State<_DayRecord> createState() => _DayRecordState();
}

class _DayRecordState extends State<_DayRecord> {
  bool _expanded = false;

  Color _ragColor(String? rag) {
    if (rag == null) return AppColors.textMuted;
    switch (rag) {
      case 'green':
        return AppColors.ragGreen;
      case 'amber':
        return AppColors.ragAmber;
      case 'red':
        return AppColors.ragRed;
      default:
        return AppColors.textMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.entry;
    return Card(
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: _ragColor(e.ragStatus),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          toMilitaryDateWithDay(e.date),
                          style: const TextStyle(
                            fontFamily: 'ShareTechMono',
                            fontSize: 12,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            _Badge(
                              label: e.wasBriefed ? 'BRIEFED' : 'MISSED',
                              color: e.wasBriefed
                                  ? AppColors.olive
                                  : AppColors.textMuted,
                            ),
                            const SizedBox(width: 6),
                            if (e.objectivesTotal > 0)
                              _Badge(
                                label:
                                    '${e.objectivesCompleted}/${e.objectivesTotal} OBJ',
                                color: AppColors.textMuted,
                              ),
                            const SizedBox(width: 6),
                            _Badge(
                              label: e.wasDebriefed
                                  ? 'DEBRIEFED'
                                  : 'NO DEBRIEF',
                              color: e.wasDebriefed
                                  ? AppColors.olive
                                  : AppColors.textMuted,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.textMuted,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          if (_expanded && e.debrief != null) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (e.debrief!.wins.isNotEmpty)
                    _ExpandedRow(
                        label: 'VICTORIES', items: e.debrief!.wins),
                  if (e.debrief!.blockers.isNotEmpty)
                    _ExpandedRow(
                        label: 'OBSTACLES',
                        items: e.debrief!.blockers),
                  if (e.debrief!.carryOvers.isNotEmpty)
                    _ExpandedRow(
                        label: 'CARRY-OVERS',
                        items: e.debrief!.carryOvers),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () =>
                        context.push('/debrief/${toDateKey(e.date)}'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(AppStrings.viewFullReport,
                        style: TextStyle(fontSize: 11)),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: color.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(label,
          style: TextStyle(
              color: color,
              fontFamily: 'ShareTechMono',
              fontSize: 9,
              letterSpacing: 0.5)),
    );
  }
}

class _ExpandedRow extends StatelessWidget {
  const _ExpandedRow({required this.label, required this.items});

  final String label;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 9,
                  fontFamily: 'ShareTechMono',
                  letterSpacing: 1)),
          const SizedBox(height: 4),
          ...items.map((i) => Text('• $i',
              style: const TextStyle(
                  color: AppColors.textSecondary, fontSize: 12))),
        ],
      ),
    );
  }
}
