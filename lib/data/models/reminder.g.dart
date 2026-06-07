// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Reminder _$ReminderFromJson(Map<String, dynamic> json) => _Reminder(
  id: json['id'] as String,
  userId: json['userId'] as String,
  title: json['title'] as String,
  body: json['body'] as String?,
  scheduledAt: _tsRequired(json['scheduledAt']),
  repeat:
      $enumDecodeNullable(_$ReminderRepeatEnumMap, json['repeat']) ??
      ReminderRepeat.none,
  isActive: json['isActive'] as bool? ?? true,
  localNotificationId: (json['localNotificationId'] as num?)?.toInt() ?? 0,
  linkedTaskId: json['linkedTaskId'] as String?,
  createdAt: _tsRequired(json['createdAt']),
);

Map<String, dynamic> _$ReminderToJson(_Reminder instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'title': instance.title,
  'body': instance.body,
  'scheduledAt': _tsTo(instance.scheduledAt),
  'repeat': _$ReminderRepeatEnumMap[instance.repeat]!,
  'isActive': instance.isActive,
  'localNotificationId': instance.localNotificationId,
  'linkedTaskId': instance.linkedTaskId,
  'createdAt': _tsTo(instance.createdAt),
};

const _$ReminderRepeatEnumMap = {
  ReminderRepeat.none: 'none',
  ReminderRepeat.daily: 'daily',
  ReminderRepeat.weekly: 'weekly',
};
