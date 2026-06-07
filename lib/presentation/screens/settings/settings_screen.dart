import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../data/models/user_quote.dart';
import '../../../presentation/providers/auth_providers.dart';
import '../../../presentation/providers/infrastructure_providers.dart';
import '../../../presentation/providers/quote_providers.dart';
import '../../../routing/route_names.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider).value;
    final quotes = ref.watch(userQuoteListProvider).value ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.settings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (profile != null) ...[
            _sectionHeader(context, 'OPERATOR'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(profile.callSign,
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 4),
                    Text(profile.email,
                        style: const TextStyle(
                            color: AppColors.textSecondary, fontSize: 13)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          _sectionHeader(context, AppStrings.myQuotes),
          ...quotes.map(
            (q) => Card(
              child: ListTile(
                title: Text(q.text,
                    style: const TextStyle(fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                subtitle: q.author != null
                    ? Text('— ${q.author}',
                        style: const TextStyle(
                            color: AppColors.textMuted, fontSize: 11))
                    : null,
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline,
                      color: AppColors.textMuted, size: 18),
                  onPressed: () => _deleteQuote(ref, q),
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.add, color: AppColors.olive),
              title: const Text(AppStrings.addQuote,
                  style: TextStyle(
                      color: AppColors.olive,
                      fontFamily: 'ShareTechMono',
                      fontSize: 13)),
              onTap: () => _addQuote(context, ref),
            ),
          ),
          const SizedBox(height: 24),
          _sectionHeader(context, 'ACCOUNT'),
          Card(
            child: ListTile(
              leading: const Icon(Icons.logout, color: AppColors.redLight),
              title: const Text(AppStrings.signOut,
                  style: TextStyle(
                      color: AppColors.redLight,
                      fontFamily: 'ShareTechMono',
                      fontSize: 13)),
              onTap: () async {
                await ref.read(authRepositoryProvider).signOut();
                if (context.mounted) context.go(Routes.login);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String label) => Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 4),
        child: Text(label, style: Theme.of(context).textTheme.labelSmall),
      );

  Future<void> _deleteQuote(WidgetRef ref, UserQuote q) async {
    final uid = ref.read(authStateProvider).value?.uid;
    if (uid == null) return;
    await ref.read(quoteRepositoryProvider).deleteQuote(uid, q.id);
  }

  void _addQuote(BuildContext context, WidgetRef ref) {
    final textCtrl = TextEditingController();
    final authorCtrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('ADD QUOTE',
                style: TextStyle(
                    fontFamily: 'ShareTechMono',
                    fontSize: 14,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5)),
            const SizedBox(height: 16),
            TextField(
              controller: textCtrl,
              decoration:
                  const InputDecoration(labelText: 'QUOTE TEXT'),
              maxLines: 3,
              autofocus: true,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: authorCtrl,
              decoration: const InputDecoration(
                  labelText: 'AUTHOR (OPTIONAL)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (textCtrl.text.trim().isEmpty) return;
                final uid =
                    ref.read(authStateProvider).value?.uid;
                if (uid == null) return;
                final quote = UserQuote(
                  id: const Uuid().v4(),
                  text: textCtrl.text.trim(),
                  author: authorCtrl.text.trim().isEmpty
                      ? null
                      : authorCtrl.text.trim(),
                  createdAt: DateTime.now(),
                );
                await ref
                    .read(quoteRepositoryProvider)
                    .saveQuote(uid, quote);
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: const Text(AppStrings.save),
            ),
          ],
        ),
      ),
    );
  }
}
