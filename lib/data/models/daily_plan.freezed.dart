// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailyPlan {

 String get id; String get userId;@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime get date; List<String> get topFive; List<EisenhowerItem> get matrixItems; String? get commandersIntent; bool get isSubmitted;@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime get createdAt;@JsonKey(fromJson: _tsNullable, toJson: _tsTo) DateTime? get updatedAt;
/// Create a copy of DailyPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyPlanCopyWith<DailyPlan> get copyWith => _$DailyPlanCopyWithImpl<DailyPlan>(this as DailyPlan, _$identity);

  /// Serializes this DailyPlan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyPlan&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.topFive, topFive)&&const DeepCollectionEquality().equals(other.matrixItems, matrixItems)&&(identical(other.commandersIntent, commandersIntent) || other.commandersIntent == commandersIntent)&&(identical(other.isSubmitted, isSubmitted) || other.isSubmitted == isSubmitted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,date,const DeepCollectionEquality().hash(topFive),const DeepCollectionEquality().hash(matrixItems),commandersIntent,isSubmitted,createdAt,updatedAt);

@override
String toString() {
  return 'DailyPlan(id: $id, userId: $userId, date: $date, topFive: $topFive, matrixItems: $matrixItems, commandersIntent: $commandersIntent, isSubmitted: $isSubmitted, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DailyPlanCopyWith<$Res>  {
  factory $DailyPlanCopyWith(DailyPlan value, $Res Function(DailyPlan) _then) = _$DailyPlanCopyWithImpl;
@useResult
$Res call({
 String id, String userId,@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime date, List<String> topFive, List<EisenhowerItem> matrixItems, String? commandersIntent, bool isSubmitted,@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime createdAt,@JsonKey(fromJson: _tsNullable, toJson: _tsTo) DateTime? updatedAt
});




}
/// @nodoc
class _$DailyPlanCopyWithImpl<$Res>
    implements $DailyPlanCopyWith<$Res> {
  _$DailyPlanCopyWithImpl(this._self, this._then);

  final DailyPlan _self;
  final $Res Function(DailyPlan) _then;

/// Create a copy of DailyPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? date = null,Object? topFive = null,Object? matrixItems = null,Object? commandersIntent = freezed,Object? isSubmitted = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,topFive: null == topFive ? _self.topFive : topFive // ignore: cast_nullable_to_non_nullable
as List<String>,matrixItems: null == matrixItems ? _self.matrixItems : matrixItems // ignore: cast_nullable_to_non_nullable
as List<EisenhowerItem>,commandersIntent: freezed == commandersIntent ? _self.commandersIntent : commandersIntent // ignore: cast_nullable_to_non_nullable
as String?,isSubmitted: null == isSubmitted ? _self.isSubmitted : isSubmitted // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyPlan].
extension DailyPlanPatterns on DailyPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyPlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyPlan value)  $default,){
final _that = this;
switch (_that) {
case _DailyPlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyPlan value)?  $default,){
final _that = this;
switch (_that) {
case _DailyPlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime date,  List<String> topFive,  List<EisenhowerItem> matrixItems,  String? commandersIntent,  bool isSubmitted, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime createdAt, @JsonKey(fromJson: _tsNullable, toJson: _tsTo)  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyPlan() when $default != null:
return $default(_that.id,_that.userId,_that.date,_that.topFive,_that.matrixItems,_that.commandersIntent,_that.isSubmitted,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime date,  List<String> topFive,  List<EisenhowerItem> matrixItems,  String? commandersIntent,  bool isSubmitted, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime createdAt, @JsonKey(fromJson: _tsNullable, toJson: _tsTo)  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _DailyPlan():
return $default(_that.id,_that.userId,_that.date,_that.topFive,_that.matrixItems,_that.commandersIntent,_that.isSubmitted,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime date,  List<String> topFive,  List<EisenhowerItem> matrixItems,  String? commandersIntent,  bool isSubmitted, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime createdAt, @JsonKey(fromJson: _tsNullable, toJson: _tsTo)  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DailyPlan() when $default != null:
return $default(_that.id,_that.userId,_that.date,_that.topFive,_that.matrixItems,_that.commandersIntent,_that.isSubmitted,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyPlan implements DailyPlan {
  const _DailyPlan({required this.id, required this.userId, @JsonKey(fromJson: _tsRequired, toJson: _tsTo) required this.date, final  List<String> topFive = const [], final  List<EisenhowerItem> matrixItems = const [], this.commandersIntent, this.isSubmitted = false, @JsonKey(fromJson: _tsRequired, toJson: _tsTo) required this.createdAt, @JsonKey(fromJson: _tsNullable, toJson: _tsTo) this.updatedAt}): _topFive = topFive,_matrixItems = matrixItems;
  factory _DailyPlan.fromJson(Map<String, dynamic> json) => _$DailyPlanFromJson(json);

@override final  String id;
@override final  String userId;
@override@JsonKey(fromJson: _tsRequired, toJson: _tsTo) final  DateTime date;
 final  List<String> _topFive;
@override@JsonKey() List<String> get topFive {
  if (_topFive is EqualUnmodifiableListView) return _topFive;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topFive);
}

 final  List<EisenhowerItem> _matrixItems;
@override@JsonKey() List<EisenhowerItem> get matrixItems {
  if (_matrixItems is EqualUnmodifiableListView) return _matrixItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_matrixItems);
}

@override final  String? commandersIntent;
@override@JsonKey() final  bool isSubmitted;
@override@JsonKey(fromJson: _tsRequired, toJson: _tsTo) final  DateTime createdAt;
@override@JsonKey(fromJson: _tsNullable, toJson: _tsTo) final  DateTime? updatedAt;

/// Create a copy of DailyPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyPlanCopyWith<_DailyPlan> get copyWith => __$DailyPlanCopyWithImpl<_DailyPlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyPlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyPlan&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._topFive, _topFive)&&const DeepCollectionEquality().equals(other._matrixItems, _matrixItems)&&(identical(other.commandersIntent, commandersIntent) || other.commandersIntent == commandersIntent)&&(identical(other.isSubmitted, isSubmitted) || other.isSubmitted == isSubmitted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,date,const DeepCollectionEquality().hash(_topFive),const DeepCollectionEquality().hash(_matrixItems),commandersIntent,isSubmitted,createdAt,updatedAt);

@override
String toString() {
  return 'DailyPlan(id: $id, userId: $userId, date: $date, topFive: $topFive, matrixItems: $matrixItems, commandersIntent: $commandersIntent, isSubmitted: $isSubmitted, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DailyPlanCopyWith<$Res> implements $DailyPlanCopyWith<$Res> {
  factory _$DailyPlanCopyWith(_DailyPlan value, $Res Function(_DailyPlan) _then) = __$DailyPlanCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId,@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime date, List<String> topFive, List<EisenhowerItem> matrixItems, String? commandersIntent, bool isSubmitted,@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime createdAt,@JsonKey(fromJson: _tsNullable, toJson: _tsTo) DateTime? updatedAt
});




}
/// @nodoc
class __$DailyPlanCopyWithImpl<$Res>
    implements _$DailyPlanCopyWith<$Res> {
  __$DailyPlanCopyWithImpl(this._self, this._then);

  final _DailyPlan _self;
  final $Res Function(_DailyPlan) _then;

/// Create a copy of DailyPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? date = null,Object? topFive = null,Object? matrixItems = null,Object? commandersIntent = freezed,Object? isSubmitted = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_DailyPlan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,topFive: null == topFive ? _self._topFive : topFive // ignore: cast_nullable_to_non_nullable
as List<String>,matrixItems: null == matrixItems ? _self._matrixItems : matrixItems // ignore: cast_nullable_to_non_nullable
as List<EisenhowerItem>,commandersIntent: freezed == commandersIntent ? _self.commandersIntent : commandersIntent // ignore: cast_nullable_to_non_nullable
as String?,isSubmitted: null == isSubmitted ? _self.isSubmitted : isSubmitted // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
