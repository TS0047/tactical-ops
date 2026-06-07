import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_quote.dart';
import '../../core/constants/built_in_quotes.dart';
import '../../core/utils/date_utils.dart';
import 'auth_providers.dart';
import 'infrastructure_providers.dart';

final userQuoteListProvider = StreamProvider<List<UserQuote>>((ref) {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return Stream.value([]);
  return ref.watch(quoteRepositoryProvider).watchQuotes(user.uid);
});

final dailyQuoteProvider = Provider<BuiltInQuote>((ref) {
  final userQuotes = ref.watch(userQuoteListProvider).value ?? [];
  final today = todayNormalized();
  final index = dayOfYear(today);

  if (userQuotes.isNotEmpty) {
    return BuiltInQuote(
      userQuotes[index % userQuotes.length].text,
      userQuotes[index % userQuotes.length].author ?? '',
    );
  }
  return builtInQuotes[index % builtInQuotes.length];
});
