import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'task.freezed.dart';
part 'task.g.dart';

enum TaskCategory { mission, admin, comms, logistics, personal }

enum TaskPriority { critical, high, medium, low }

enum TaskStatus { active, complete, overdue }

enum EisenhowerQuadrant { urgentImportant, importantNotUrgent, urgentNotImportant, neither }

@freezed
abstract class Task with _$Task {
  const factory Task({
    required String id,
    required String userId,
    required String title,
    String? description,
    @Default(TaskCategory.mission) TaskCategory category,
    @Default(TaskPriority.medium) TaskPriority priority,
    @Default(TaskStatus.active) TaskStatus status,
    @JsonKey(fromJson: _tsNullable, toJson: _tsTo) DateTime? dueDate,
    @Default(false) bool isCompleted,
    EisenhowerQuadrant? quadrant,
    @JsonKey(fromJson: _tsRequired, toJson: _tsTo) required DateTime createdAt,
    @JsonKey(fromJson: _tsRequired, toJson: _tsTo) required DateTime updatedAt,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

DateTime? _tsNullable(dynamic v) => v == null ? null : (v as Timestamp).toDate();
DateTime _tsRequired(dynamic v) => (v as Timestamp).toDate();
dynamic _tsTo(DateTime? d) => d == null ? null : Timestamp.fromDate(d);
