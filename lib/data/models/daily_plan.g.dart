// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailyPlan _$DailyPlanFromJson(Map<String, dynamic> json) => _DailyPlan(
  id: json['id'] as String,
  userId: json['userId'] as String,
  date: _tsRequired(json['date']),
  topFive:
      (json['topFive'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  matrixItems:
      (json['matrixItems'] as List<dynamic>?)
          ?.map((e) => EisenhowerItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  commandersIntent: json['commandersIntent'] as String?,
  isSubmitted: json['isSubmitted'] as bool? ?? false,
  createdAt: _tsRequired(json['createdAt']),
  updatedAt: _tsNullable(json['updatedAt']),
);

Map<String, dynamic> _$DailyPlanToJson(_DailyPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'date': _tsTo(instance.date),
      'topFive': instance.topFive,
      'matrixItems': instance.matrixItems,
      'commandersIntent': instance.commandersIntent,
      'isSubmitted': instance.isSubmitted,
      'createdAt': _tsTo(instance.createdAt),
      'updatedAt': _tsTo(instance.updatedAt),
    };
