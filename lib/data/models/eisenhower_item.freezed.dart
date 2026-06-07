// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eisenhower_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EisenhowerItem {

 String get id; String get text; EisenhowerQuadrant get quadrant; String? get linkedTaskId; bool get isCompleted;
/// Create a copy of EisenhowerItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EisenhowerItemCopyWith<EisenhowerItem> get copyWith => _$EisenhowerItemCopyWithImpl<EisenhowerItem>(this as EisenhowerItem, _$identity);

  /// Serializes this EisenhowerItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EisenhowerItem&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.quadrant, quadrant) || other.quadrant == quadrant)&&(identical(other.linkedTaskId, linkedTaskId) || other.linkedTaskId == linkedTaskId)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,quadrant,linkedTaskId,isCompleted);

@override
String toString() {
  return 'EisenhowerItem(id: $id, text: $text, quadrant: $quadrant, linkedTaskId: $linkedTaskId, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class $EisenhowerItemCopyWith<$Res>  {
  factory $EisenhowerItemCopyWith(EisenhowerItem value, $Res Function(EisenhowerItem) _then) = _$EisenhowerItemCopyWithImpl;
@useResult
$Res call({
 String id, String text, EisenhowerQuadrant quadrant, String? linkedTaskId, bool isCompleted
});




}
/// @nodoc
class _$EisenhowerItemCopyWithImpl<$Res>
    implements $EisenhowerItemCopyWith<$Res> {
  _$EisenhowerItemCopyWithImpl(this._self, this._then);

  final EisenhowerItem _self;
  final $Res Function(EisenhowerItem) _then;

/// Create a copy of EisenhowerItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? quadrant = null,Object? linkedTaskId = freezed,Object? isCompleted = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,quadrant: null == quadrant ? _self.quadrant : quadrant // ignore: cast_nullable_to_non_nullable
as EisenhowerQuadrant,linkedTaskId: freezed == linkedTaskId ? _self.linkedTaskId : linkedTaskId // ignore: cast_nullable_to_non_nullable
as String?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EisenhowerItem].
extension EisenhowerItemPatterns on EisenhowerItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EisenhowerItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EisenhowerItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EisenhowerItem value)  $default,){
final _that = this;
switch (_that) {
case _EisenhowerItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EisenhowerItem value)?  $default,){
final _that = this;
switch (_that) {
case _EisenhowerItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text,  EisenhowerQuadrant quadrant,  String? linkedTaskId,  bool isCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EisenhowerItem() when $default != null:
return $default(_that.id,_that.text,_that.quadrant,_that.linkedTaskId,_that.isCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text,  EisenhowerQuadrant quadrant,  String? linkedTaskId,  bool isCompleted)  $default,) {final _that = this;
switch (_that) {
case _EisenhowerItem():
return $default(_that.id,_that.text,_that.quadrant,_that.linkedTaskId,_that.isCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text,  EisenhowerQuadrant quadrant,  String? linkedTaskId,  bool isCompleted)?  $default,) {final _that = this;
switch (_that) {
case _EisenhowerItem() when $default != null:
return $default(_that.id,_that.text,_that.quadrant,_that.linkedTaskId,_that.isCompleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EisenhowerItem implements EisenhowerItem {
  const _EisenhowerItem({required this.id, required this.text, required this.quadrant, this.linkedTaskId, this.isCompleted = false});
  factory _EisenhowerItem.fromJson(Map<String, dynamic> json) => _$EisenhowerItemFromJson(json);

@override final  String id;
@override final  String text;
@override final  EisenhowerQuadrant quadrant;
@override final  String? linkedTaskId;
@override@JsonKey() final  bool isCompleted;

/// Create a copy of EisenhowerItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EisenhowerItemCopyWith<_EisenhowerItem> get copyWith => __$EisenhowerItemCopyWithImpl<_EisenhowerItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EisenhowerItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EisenhowerItem&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.quadrant, quadrant) || other.quadrant == quadrant)&&(identical(other.linkedTaskId, linkedTaskId) || other.linkedTaskId == linkedTaskId)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,quadrant,linkedTaskId,isCompleted);

@override
String toString() {
  return 'EisenhowerItem(id: $id, text: $text, quadrant: $quadrant, linkedTaskId: $linkedTaskId, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class _$EisenhowerItemCopyWith<$Res> implements $EisenhowerItemCopyWith<$Res> {
  factory _$EisenhowerItemCopyWith(_EisenhowerItem value, $Res Function(_EisenhowerItem) _then) = __$EisenhowerItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, EisenhowerQuadrant quadrant, String? linkedTaskId, bool isCompleted
});




}
/// @nodoc
class __$EisenhowerItemCopyWithImpl<$Res>
    implements _$EisenhowerItemCopyWith<$Res> {
  __$EisenhowerItemCopyWithImpl(this._self, this._then);

  final _EisenhowerItem _self;
  final $Res Function(_EisenhowerItem) _then;

/// Create a copy of EisenhowerItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? quadrant = null,Object? linkedTaskId = freezed,Object? isCompleted = null,}) {
  return _then(_EisenhowerItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,quadrant: null == quadrant ? _self.quadrant : quadrant // ignore: cast_nullable_to_non_nullable
as EisenhowerQuadrant,linkedTaskId: freezed == linkedTaskId ? _self.linkedTaskId : linkedTaskId // ignore: cast_nullable_to_non_nullable
as String?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
