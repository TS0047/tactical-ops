// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debrief.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Debrief _$DebriefFromJson(Map<String, dynamic> json) => _Debrief(
  id: json['id'] as String,
  userId: json['userId'] as String,
  date: _tsRequired(json['date']),
  completed:
      (json['completed'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  wins:
      (json['wins'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  blockers:
      (json['blockers'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  carryOvers:
      (json['carryOvers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  moodRating:
      $enumDecodeNullable(_$RagStatusEnumMap, json['moodRating']) ??
      RagStatus.green,
  freeNotes: json['freeNotes'] as String?,
  submittedAt: _tsRequired(json['submittedAt']),
);

Map<String, dynamic> _$DebriefToJson(_Debrief instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'date': _tsTo(instance.date),
  'completed': instance.completed,
  'wins': instance.wins,
  'blockers': instance.blockers,
  'carryOvers': instance.carryOvers,
  'moodRating': _$RagStatusEnumMap[instance.moodRating]!,
  'freeNotes': instance.freeNotes,
  'submittedAt': _tsTo(instance.submittedAt),
};

const _$RagStatusEnumMap = {
  RagStatus.green: 'green',
  RagStatus.amber: 'amber',
  RagStatus.red: 'red',
};
