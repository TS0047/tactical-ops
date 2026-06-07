import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'reminder.freezed.dart';
part 'reminder.g.dart';

enum ReminderRepeat { none, daily, weekly }

@freezed
abstract class Reminder with _$Reminder {
  const factory Reminder({
    required String id,
    required String userId,
    required String title,
    String? body,
    @JsonKey(fromJson: _tsRequired, toJson: _tsTo) required DateTime scheduledAt,
    @Default(ReminderRepeat.none) ReminderRepeat repeat,
    @Default(true) bool isActive,
    @Default(0) int localNotificationId,
    String? linkedTaskId,
    @JsonKey(fromJson: _tsRequired, toJson: _tsTo) required DateTime createdAt,
  }) = _Reminder;

  factory Reminder.fromJson(Map<String, dynamic> json) =>
      _$ReminderFromJson(json);
}

DateTime _tsRequired(dynamic v) => (v as Timestamp).toDate();
dynamic _tsTo(DateTime? d) => d == null ? null : Timestamp.fromDate(d);
