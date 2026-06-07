import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/date_utils.dart';
import '../../../data/models/debrief.dart';
import '../../../presentation/providers/auth_providers.dart';
import '../../../presentation/providers/daily_plan_providers.dart';
import '../../../presentation/providers/debrief_providers.dart';
import '../../../presentation/providers/task_providers.dart';
import '../../../presentation/providers/quote_providers.dart';
import '../../../routing/route_names.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider).value;
    final plan = ref.watch(todayPlanProvider).value;
    final debrief = ref.watch(todayDebriefProvider).value;
    final activeTasks = ref.watch(activeTasksProvider);
    final completedTasks = ref.watch(completedTasksProvider);
    final quote = ref.watch(dailyQuoteProvider);
    final pastDebriefs = ref.watch(pastDebriefListProvider).value ?? [];

    final completedMatrix =
        plan?.matrixItems.where((i) => i.isCompleted).length ?? 0;
    final totalMatrix = plan?.matrixItems.length ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(profile?.callSign ?? AppStrings.navSitrep),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(Routes.settings),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Date
          Text(
            toMilitaryDateWithDay(DateTime.now()),
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 16),

          // Daily quote
          _QuoteCard(quote: quote),
          const SizedBox(height: 16),

          // 7-day RAG strip
          if (pastDebriefs.isNotEmpty) ...[
            _RagStrip(debriefs: pastDebriefs.take(7).toList()),
            const SizedBox(height: 16),
          ],

          // Morning briefing status
          _StatusCard(
            title: AppStrings.briefingStatus,
            status: plan?.isSubmitted == true
                ? AppStrings.briefed
                : AppStrings.notYetBriefed,
            isGood: plan?.isSubmitted == true,
            subtitle: plan?.isSubmitted == true && totalMatrix > 0
                ? '$completedMatrix / $totalMatrix OBJECTIVES COMPLETE'
                : null,
            onTap: () => context.push(Routes.briefing),
          ),
          const SizedBox(height: 8),

          // Night debrief status
          _StatusCard(
            title: 'NIGHT DEBRIEF',
            status: debrief != null
                ? AppStrings.debriefed
                : AppStrings.notYetDebriefed,
            isGood: debrief != null,
            onTap: debrief != null
                ? () => context.push('/debrief/${toDateKey(DateTime.now())}')
                : () => context.push(Routes.debrief),
          ),
          const SizedBox(height: 16),

          // Task summary
          Row(
            children: [
              Expanded(
                child: _CountCard(
                  label: 'ACTIVE',
                  count: activeTasks.length,
                  color: AppColors.olive,
                  onTap: () => context.push(Routes.tasks),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _CountCard(
                  label: 'COMPLETE',
                  count: completedTasks.length,
                  color: AppColors.ragGreen,
                  onTap: () => context.push(Routes.tasks),
                ),
              ),
            ],
          ),

          // Today's top 5
          if (plan != null && plan.topFive.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text("TODAY'S TOP 5",
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            ...plan.topFive.asMap().entries.map((e) {
              // topFive stores task IDs — resolve to title
              final task = ref
                  .watch(taskListProvider)
                  .value
                  ?.where((t) => t.id == e.value)
                  .firstOrNull;
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
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                  ],
                ),
              );
            }),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(Routes.newTask),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _QuoteCard extends StatelessWidget {
  const _QuoteCard({required this.quote});
  final dynamic quote;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '" ${quote.text} "',
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
            if (quote.author.isNotEmpty) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '— ${quote.author}',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontFamily: 'ShareTechMono',
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _RagStrip extends StatelessWidget {
  const _RagStrip({required this.debriefs});
  final List<dynamic> debriefs;

  Color _color(dynamic d) {
    if (d == null) return AppColors.textMuted;
    switch (d.moodRating as RagStatus) {
      case RagStatus.green:
        return AppColors.ragGreen;
      case RagStatus.amber:
        return AppColors.ragAmber;
      case RagStatus.red:
        return AppColors.ragRed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('7-DAY: ',
            style: Theme.of(context).textTheme.labelSmall),
        ...List.generate(7, (i) {
          final d = i < debriefs.length ? debriefs[i] : null;
          return Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: _color(d),
                shape: BoxShape.circle,
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.title,
    required this.status,
    required this.isGood,
    required this.onTap,
    this.subtitle,
  });

  final String title;
  final String status;
  final bool isGood;
  final VoidCallback onTap;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: Theme.of(context).textTheme.labelSmall),
                    const SizedBox(height: 4),
                    Text(status,
                        style: TextStyle(
                          fontFamily: 'ShareTechMono',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isGood ? AppColors.ragGreen : AppColors.amber,
                        )),
                    if (subtitle != null)
                      Text(subtitle!,
                          style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
              Icon(
                isGood ? Icons.check_circle_outline : Icons.radio_button_unchecked,
                color: isGood ? AppColors.ragGreen : AppColors.amber,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CountCard extends StatelessWidget {
  const _CountCard({
    required this.label,
    required this.count,
    required this.color,
    required this.onTap,
  });

  final String label;
  final int count;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text('$count',
                  style: TextStyle(
                    fontFamily: 'ShareTechMono',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: color,
                  )),
              const SizedBox(height: 4),
              Text(label, style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
        ),
      ),
    );
  }
}
