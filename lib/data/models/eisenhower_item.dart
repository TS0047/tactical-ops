import 'package:freezed_annotation/freezed_annotation.dart';
import 'task.dart';

part 'eisenhower_item.freezed.dart';
part 'eisenhower_item.g.dart';

@freezed
abstract class EisenhowerItem with _$EisenhowerItem {
  const factory EisenhowerItem({
    required String id,
    required String text,
    required EisenhowerQuadrant quadrant,
    String? linkedTaskId,
    @Default(false) bool isCompleted,
  }) = _EisenhowerItem;

  factory EisenhowerItem.fromJson(Map<String, dynamic> json) =>
      _$EisenhowerItemFromJson(json);
}
