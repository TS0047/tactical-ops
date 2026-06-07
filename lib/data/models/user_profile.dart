import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String uid,
    required String displayName,
    required String email,
    String? photoUrl,
    @Default('OPERATOR') String callSign,
    @Default('Asia/Kolkata') String timezone,
    @Default(6) int morningReminderHour,
    @Default(0) int morningReminderMinute,
    @Default(21) int nightReminderHour,
    @Default(0) int nightReminderMinute,
    @Default(true) bool notificationsEnabled,
    @JsonKey(fromJson: _tsRequired, toJson: _tsTo) required DateTime createdAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

DateTime _tsRequired(dynamic v) => (v as Timestamp).toDate();
dynamic _tsTo(DateTime? d) => d == null ? null : Timestamp.fromDate(d);
