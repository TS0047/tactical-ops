// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eisenhower_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EisenhowerItem _$EisenhowerItemFromJson(Map<String, dynamic> json) =>
    _EisenhowerItem(
      id: json['id'] as String,
      text: json['text'] as String,
      quadrant: $enumDecode(_$EisenhowerQuadrantEnumMap, json['quadrant']),
      linkedTaskId: json['linkedTaskId'] as String?,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$EisenhowerItemToJson(_EisenhowerItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'quadrant': _$EisenhowerQuadrantEnumMap[instance.quadrant]!,
      'linkedTaskId': instance.linkedTaskId,
      'isCompleted': instance.isCompleted,
    };

const _$EisenhowerQuadrantEnumMap = {
  EisenhowerQuadrant.urgentImportant: 'urgentImportant',
  EisenhowerQuadrant.importantNotUrgent: 'importantNotUrgent',
  EisenhowerQuadrant.urgentNotImportant: 'urgentNotImportant',
  EisenhowerQuadrant.neither: 'neither',
};
