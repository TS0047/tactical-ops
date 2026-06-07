// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Reminder {

 String get id; String get userId; String get title; String? get body;@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime get scheduledAt; ReminderRepeat get repeat; bool get isActive; int get localNotificationId; String? get linkedTaskId;@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime get createdAt;
/// Create a copy of Reminder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReminderCopyWith<Reminder> get copyWith => _$ReminderCopyWithImpl<Reminder>(this as Reminder, _$identity);

  /// Serializes this Reminder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reminder&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.repeat, repeat) || other.repeat == repeat)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.localNotificationId, localNotificationId) || other.localNotificationId == localNotificationId)&&(identical(other.linkedTaskId, linkedTaskId) || other.linkedTaskId == linkedTaskId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,title,body,scheduledAt,repeat,isActive,localNotificationId,linkedTaskId,createdAt);

@override
String toString() {
  return 'Reminder(id: $id, userId: $userId, title: $title, body: $body, scheduledAt: $scheduledAt, repeat: $repeat, isActive: $isActive, localNotificationId: $localNotificationId, linkedTaskId: $linkedTaskId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ReminderCopyWith<$Res>  {
  factory $ReminderCopyWith(Reminder value, $Res Function(Reminder) _then) = _$ReminderCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String title, String? body,@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime scheduledAt, ReminderRepeat repeat, bool isActive, int localNotificationId, String? linkedTaskId,@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime createdAt
});




}
/// @nodoc
class _$ReminderCopyWithImpl<$Res>
    implements $ReminderCopyWith<$Res> {
  _$ReminderCopyWithImpl(this._self, this._then);

  final Reminder _self;
  final $Res Function(Reminder) _then;

/// Create a copy of Reminder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? title = null,Object? body = freezed,Object? scheduledAt = null,Object? repeat = null,Object? isActive = null,Object? localNotificationId = null,Object? linkedTaskId = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,scheduledAt: null == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as ReminderRepeat,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,localNotificationId: null == localNotificationId ? _self.localNotificationId : localNotificationId // ignore: cast_nullable_to_non_nullable
as int,linkedTaskId: freezed == linkedTaskId ? _self.linkedTaskId : linkedTaskId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Reminder].
extension ReminderPatterns on Reminder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Reminder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Reminder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Reminder value)  $default,){
final _that = this;
switch (_that) {
case _Reminder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Reminder value)?  $default,){
final _that = this;
switch (_that) {
case _Reminder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String title,  String? body, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime scheduledAt,  ReminderRepeat repeat,  bool isActive,  int localNotificationId,  String? linkedTaskId, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Reminder() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.body,_that.scheduledAt,_that.repeat,_that.isActive,_that.localNotificationId,_that.linkedTaskId,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String title,  String? body, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime scheduledAt,  ReminderRepeat repeat,  bool isActive,  int localNotificationId,  String? linkedTaskId, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Reminder():
return $default(_that.id,_that.userId,_that.title,_that.body,_that.scheduledAt,_that.repeat,_that.isActive,_that.localNotificationId,_that.linkedTaskId,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String title,  String? body, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime scheduledAt,  ReminderRepeat repeat,  bool isActive,  int localNotificationId,  String? linkedTaskId, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Reminder() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.body,_that.scheduledAt,_that.repeat,_that.isActive,_that.localNotificationId,_that.linkedTaskId,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Reminder implements Reminder {
  const _Reminder({required this.id, required this.userId, required this.title, this.body, @JsonKey(fromJson: _tsRequired, toJson: _tsTo) required this.scheduledAt, this.repeat = ReminderRepeat.none, this.isActive = true, this.localNotificationId = 0, this.linkedTaskId, @JsonKey(fromJson: _tsRequired, toJson: _tsTo) required this.createdAt});
  factory _Reminder.fromJson(Map<String, dynamic> json) => _$ReminderFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String title;
@override final  String? body;
@override@JsonKey(fromJson: _tsRequired, toJson: _tsTo) final  DateTime scheduledAt;
@override@JsonKey() final  ReminderRepeat repeat;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  int localNotificationId;
@override final  String? linkedTaskId;
@override@JsonKey(fromJson: _tsRequired, toJson: _tsTo) final  DateTime createdAt;

/// Create a copy of Reminder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReminderCopyWith<_Reminder> get copyWith => __$ReminderCopyWithImpl<_Reminder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReminderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reminder&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.repeat, repeat) || other.repeat == repeat)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.localNotificationId, localNotificationId) || other.localNotificationId == localNotificationId)&&(identical(other.linkedTaskId, linkedTaskId) || other.linkedTaskId == linkedTaskId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,title,body,scheduledAt,repeat,isActive,localNotificationId,linkedTaskId,createdAt);

@override
String toString() {
  return 'Reminder(id: $id, userId: $userId, title: $title, body: $body, scheduledAt: $scheduledAt, repeat: $repeat, isActive: $isActive, localNotificationId: $localNotificationId, linkedTaskId: $linkedTaskId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ReminderCopyWith<$Res> implements $ReminderCopyWith<$Res> {
  factory _$ReminderCopyWith(_Reminder value, $Res Function(_Reminder) _then) = __$ReminderCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String title, String? body,@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime scheduledAt, ReminderRepeat repeat, bool isActive, int localNotificationId, String? linkedTaskId,@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime createdAt
});




}
/// @nodoc
class __$ReminderCopyWithImpl<$Res>
    implements _$ReminderCopyWith<$Res> {
  __$ReminderCopyWithImpl(this._self, this._then);

  final _Reminder _self;
  final $Res Function(_Reminder) _then;

/// Create a copy of Reminder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? title = null,Object? body = freezed,Object? scheduledAt = null,Object? repeat = null,Object? isActive = null,Object? localNotificationId = null,Object? linkedTaskId = freezed,Object? createdAt = null,}) {
  return _then(_Reminder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,scheduledAt: null == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as ReminderRepeat,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,localNotificationId: null == localNotificationId ? _self.localNotificationId : localNotificationId // ignore: cast_nullable_to_non_nullable
as int,linkedTaskId: freezed == linkedTaskId ? _self.linkedTaskId : linkedTaskId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
