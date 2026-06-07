import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'debrief.freezed.dart';
part 'debrief.g.dart';

enum RagStatus { green, amber, red }

@freezed
abstract class Debrief with _$Debrief {
  const factory Debrief({
    required String id,
    required String userId,
    @JsonKey(fromJson: _tsRequired, toJson: _tsTo) required DateTime date,
    @Default([]) List<String> completed,
    @Default([]) List<String> wins,
    @Default([]) List<String> blockers,
    @Default([]) List<String> carryOvers,
    @Default(RagStatus.green) RagStatus moodRating,
    String? freeNotes,
    @JsonKey(fromJson: _tsRequired, toJson: _tsTo) required DateTime submittedAt,
  }) = _Debrief;

  factory Debrief.fromJson(Map<String, dynamic> json) =>
      _$DebriefFromJson(json);
}

DateTime _tsRequired(dynamic v) => (v as Timestamp).toDate();
dynamic _tsTo(DateTime? d) => d == null ? null : Timestamp.fromDate(d);
