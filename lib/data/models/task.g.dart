// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Task _$TaskFromJson(Map<String, dynamic> json) => _Task(
  id: json['id'] as String,
  userId: json['userId'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  category:
      $enumDecodeNullable(_$TaskCategoryEnumMap, json['category']) ??
      TaskCategory.mission,
  priority:
      $enumDecodeNullable(_$TaskPriorityEnumMap, json['priority']) ??
      TaskPriority.medium,
  status:
      $enumDecodeNullable(_$TaskStatusEnumMap, json['status']) ??
      TaskStatus.active,
  dueDate: _tsNullable(json['dueDate']),
  isCompleted: json['isCompleted'] as bool? ?? false,
  quadrant: $enumDecodeNullable(_$EisenhowerQuadrantEnumMap, json['quadrant']),
  createdAt: _tsRequired(json['createdAt']),
  updatedAt: _tsRequired(json['updatedAt']),
);

Map<String, dynamic> _$TaskToJson(_Task instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'title': instance.title,
  'description': instance.description,
  'category': _$TaskCategoryEnumMap[instance.category]!,
  'priority': _$TaskPriorityEnumMap[instance.priority]!,
  'status': _$TaskStatusEnumMap[instance.status]!,
  'dueDate': _tsTo(instance.dueDate),
  'isCompleted': instance.isCompleted,
  'quadrant': _$EisenhowerQuadrantEnumMap[instance.quadrant],
  'createdAt': _tsTo(instance.createdAt),
  'updatedAt': _tsTo(instance.updatedAt),
};

const _$TaskCategoryEnumMap = {
  TaskCategory.mission: 'mission',
  TaskCategory.admin: 'admin',
  TaskCategory.comms: 'comms',
  TaskCategory.logistics: 'logistics',
  TaskCategory.personal: 'personal',
};

const _$TaskPriorityEnumMap = {
  TaskPriority.critical: 'critical',
  TaskPriority.high: 'high',
  TaskPriority.medium: 'medium',
  TaskPriority.low: 'low',
};

const _$TaskStatusEnumMap = {
  TaskStatus.active: 'active',
  TaskStatus.complete: 'complete',
  TaskStatus.overdue: 'overdue',
};

const _$EisenhowerQuadrantEnumMap = {
  EisenhowerQuadrant.urgentImportant: 'urgentImportant',
  EisenhowerQuadrant.importantNotUrgent: 'importantNotUrgent',
  EisenhowerQuadrant.urgentNotImportant: 'urgentNotImportant',
  EisenhowerQuadrant.neither: 'neither',
};
