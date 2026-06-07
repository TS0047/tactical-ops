// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  uid: json['uid'] as String,
  displayName: json['displayName'] as String,
  email: json['email'] as String,
  photoUrl: json['photoUrl'] as String?,
  callSign: json['callSign'] as String? ?? 'OPERATOR',
  timezone: json['timezone'] as String? ?? 'Asia/Kolkata',
  morningReminderHour: (json['morningReminderHour'] as num?)?.toInt() ?? 6,
  morningReminderMinute: (json['morningReminderMinute'] as num?)?.toInt() ?? 0,
  nightReminderHour: (json['nightReminderHour'] as num?)?.toInt() ?? 21,
  nightReminderMinute: (json['nightReminderMinute'] as num?)?.toInt() ?? 0,
  notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
  createdAt: _tsRequired(json['createdAt']),
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'displayName': instance.displayName,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'callSign': instance.callSign,
      'timezone': instance.timezone,
      'morningReminderHour': instance.morningReminderHour,
      'morningReminderMinute': instance.morningReminderMinute,
      'nightReminderHour': instance.nightReminderHour,
      'nightReminderMinute': instance.nightReminderMinute,
      'notificationsEnabled': instance.notificationsEnabled,
      'createdAt': _tsTo(instance.createdAt),
    };
