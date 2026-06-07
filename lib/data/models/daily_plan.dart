import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'eisenhower_item.dart';

part 'daily_plan.freezed.dart';
part 'daily_plan.g.dart';

@freezed
abstract class DailyPlan with _$DailyPlan {
  const factory DailyPlan({
    required String id,
    required String userId,
    @JsonKey(fromJson: _tsRequired, toJson: _tsTo) required DateTime date,
    @Default([]) List<String> topFive,
    @Default([]) List<EisenhowerItem> matrixItems,
    String? commandersIntent,
    @Default(false) bool isSubmitted,
    @JsonKey(fromJson: _tsRequired, toJson: _tsTo) required DateTime createdAt,
    @JsonKey(fromJson: _tsNullable, toJson: _tsTo) DateTime? updatedAt,
  }) = _DailyPlan;

  factory DailyPlan.fromJson(Map<String, dynamic> json) =>
      _$DailyPlanFromJson(json);
}

DateTime _tsRequired(dynamic v) => (v as Timestamp).toDate();
DateTime? _tsNullable(dynamic v) => v == null ? null : (v as Timestamp).toDate();
dynamic _tsTo(DateTime? d) => d == null ? null : Timestamp.fromDate(d);
