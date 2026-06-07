import 'package:intl/intl.dart';

String toDateKey(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

String toMilitaryDate(DateTime date) =>
    DateFormat('dd MMM yyyy').format(date).toUpperCase();

String toMilitaryDateWithDay(DateTime date) =>
    DateFormat('dd MMM yyyy — EEE').format(date).toUpperCase();

DateTime todayNormalized() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}

int dayOfYear(DateTime date) {
  final startOfYear = DateTime(date.year, 1, 1);
  return date.difference(startOfYear).inDays;
}

bool isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

DateTime dateFromKey(String key) => DateTime.parse(key);
