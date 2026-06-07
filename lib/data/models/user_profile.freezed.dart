// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfile {

 String get uid; String get displayName; String get email; String? get photoUrl; String get callSign; String get timezone; int get morningReminderHour; int get morningReminderMinute; int get nightReminderHour; int get nightReminderMinute; bool get notificationsEnabled;@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime get createdAt;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.email, email) || other.email == email)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.callSign, callSign) || other.callSign == callSign)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.morningReminderHour, morningReminderHour) || other.morningReminderHour == morningReminderHour)&&(identical(other.morningReminderMinute, morningReminderMinute) || other.morningReminderMinute == morningReminderMinute)&&(identical(other.nightReminderHour, nightReminderHour) || other.nightReminderHour == nightReminderHour)&&(identical(other.nightReminderMinute, nightReminderMinute) || other.nightReminderMinute == nightReminderMinute)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,displayName,email,photoUrl,callSign,timezone,morningReminderHour,morningReminderMinute,nightReminderHour,nightReminderMinute,notificationsEnabled,createdAt);

@override
String toString() {
  return 'UserProfile(uid: $uid, displayName: $displayName, email: $email, photoUrl: $photoUrl, callSign: $callSign, timezone: $timezone, morningReminderHour: $morningReminderHour, morningReminderMinute: $morningReminderMinute, nightReminderHour: $nightReminderHour, nightReminderMinute: $nightReminderMinute, notificationsEnabled: $notificationsEnabled, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 String uid, String displayName, String email, String? photoUrl, String callSign, String timezone, int morningReminderHour, int morningReminderMinute, int nightReminderHour, int nightReminderMinute, bool notificationsEnabled,@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime createdAt
});




}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? displayName = null,Object? email = null,Object? photoUrl = freezed,Object? callSign = null,Object? timezone = null,Object? morningReminderHour = null,Object? morningReminderMinute = null,Object? nightReminderHour = null,Object? nightReminderMinute = null,Object? notificationsEnabled = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,callSign: null == callSign ? _self.callSign : callSign // ignore: cast_nullable_to_non_nullable
as String,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,morningReminderHour: null == morningReminderHour ? _self.morningReminderHour : morningReminderHour // ignore: cast_nullable_to_non_nullable
as int,morningReminderMinute: null == morningReminderMinute ? _self.morningReminderMinute : morningReminderMinute // ignore: cast_nullable_to_non_nullable
as int,nightReminderHour: null == nightReminderHour ? _self.nightReminderHour : nightReminderHour // ignore: cast_nullable_to_non_nullable
as int,nightReminderMinute: null == nightReminderMinute ? _self.nightReminderMinute : nightReminderMinute // ignore: cast_nullable_to_non_nullable
as int,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String displayName,  String email,  String? photoUrl,  String callSign,  String timezone,  int morningReminderHour,  int morningReminderMinute,  int nightReminderHour,  int nightReminderMinute,  bool notificationsEnabled, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.uid,_that.displayName,_that.email,_that.photoUrl,_that.callSign,_that.timezone,_that.morningReminderHour,_that.morningReminderMinute,_that.nightReminderHour,_that.nightReminderMinute,_that.notificationsEnabled,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String displayName,  String email,  String? photoUrl,  String callSign,  String timezone,  int morningReminderHour,  int morningReminderMinute,  int nightReminderHour,  int nightReminderMinute,  bool notificationsEnabled, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.uid,_that.displayName,_that.email,_that.photoUrl,_that.callSign,_that.timezone,_that.morningReminderHour,_that.morningReminderMinute,_that.nightReminderHour,_that.nightReminderMinute,_that.notificationsEnabled,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String displayName,  String email,  String? photoUrl,  String callSign,  String timezone,  int morningReminderHour,  int morningReminderMinute,  int nightReminderHour,  int nightReminderMinute,  bool notificationsEnabled, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.uid,_that.displayName,_that.email,_that.photoUrl,_that.callSign,_that.timezone,_that.morningReminderHour,_that.morningReminderMinute,_that.nightReminderHour,_that.nightReminderMinute,_that.notificationsEnabled,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfile implements UserProfile {
  const _UserProfile({required this.uid, required this.displayName, required this.email, this.photoUrl, this.callSign = 'OPERATOR', this.timezone = 'Asia/Kolkata', this.morningReminderHour = 6, this.morningReminderMinute = 0, this.nightReminderHour = 21, this.nightReminderMinute = 0, this.notificationsEnabled = true, @JsonKey(fromJson: _tsRequired, toJson: _tsTo) required this.createdAt});
  factory _UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

@override final  String uid;
@override final  String displayName;
@override final  String email;
@override final  String? photoUrl;
@override@JsonKey() final  String callSign;
@override@JsonKey() final  String timezone;
@override@JsonKey() final  int morningReminderHour;
@override@JsonKey() final  int morningReminderMinute;
@override@JsonKey() final  int nightReminderHour;
@override@JsonKey() final  int nightReminderMinute;
@override@JsonKey() final  bool notificationsEnabled;
@override@JsonKey(fromJson: _tsRequired, toJson: _tsTo) final  DateTime createdAt;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.email, email) || other.email == email)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.callSign, callSign) || other.callSign == callSign)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.morningReminderHour, morningReminderHour) || other.morningReminderHour == morningReminderHour)&&(identical(other.morningReminderMinute, morningReminderMinute) || other.morningReminderMinute == morningReminderMinute)&&(identical(other.nightReminderHour, nightReminderHour) || other.nightReminderHour == nightReminderHour)&&(identical(other.nightReminderMinute, nightReminderMinute) || other.nightReminderMinute == nightReminderMinute)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,displayName,email,photoUrl,callSign,timezone,morningReminderHour,morningReminderMinute,nightReminderHour,nightReminderMinute,notificationsEnabled,createdAt);

@override
String toString() {
  return 'UserProfile(uid: $uid, displayName: $displayName, email: $email, photoUrl: $photoUrl, callSign: $callSign, timezone: $timezone, morningReminderHour: $morningReminderHour, morningReminderMinute: $morningReminderMinute, nightReminderHour: $nightReminderHour, nightReminderMinute: $nightReminderMinute, notificationsEnabled: $notificationsEnabled, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 String uid, String displayName, String email, String? photoUrl, String callSign, String timezone, int morningReminderHour, int morningReminderMinute, int nightReminderHour, int nightReminderMinute, bool notificationsEnabled,@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime createdAt
});




}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? displayName = null,Object? email = null,Object? photoUrl = freezed,Object? callSign = null,Object? timezone = null,Object? morningReminderHour = null,Object? morningReminderMinute = null,Object? nightReminderHour = null,Object? nightReminderMinute = null,Object? notificationsEnabled = null,Object? createdAt = null,}) {
  return _then(_UserProfile(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,callSign: null == callSign ? _self.callSign : callSign // ignore: cast_nullable_to_non_nullable
as String,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,morningReminderHour: null == morningReminderHour ? _self.morningReminderHour : morningReminderHour // ignore: cast_nullable_to_non_nullable
as int,morningReminderMinute: null == morningReminderMinute ? _self.morningReminderMinute : morningReminderMinute // ignore: cast_nullable_to_non_nullable
as int,nightReminderHour: null == nightReminderHour ? _self.nightReminderHour : nightReminderHour // ignore: cast_nullable_to_non_nullable
as int,nightReminderMinute: null == nightReminderMinute ? _self.nightReminderMinute : nightReminderMinute // ignore: cast_nullable_to_non_nullable
as int,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
