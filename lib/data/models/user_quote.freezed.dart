// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_quote.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserQuote {

 String get id; String get text; String? get author; bool get isFavourite; bool get isCustom;@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime get createdAt;
/// Create a copy of UserQuote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserQuoteCopyWith<UserQuote> get copyWith => _$UserQuoteCopyWithImpl<UserQuote>(this as UserQuote, _$identity);

  /// Serializes this UserQuote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserQuote&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.author, author) || other.author == author)&&(identical(other.isFavourite, isFavourite) || other.isFavourite == isFavourite)&&(identical(other.isCustom, isCustom) || other.isCustom == isCustom)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,author,isFavourite,isCustom,createdAt);

@override
String toString() {
  return 'UserQuote(id: $id, text: $text, author: $author, isFavourite: $isFavourite, isCustom: $isCustom, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $UserQuoteCopyWith<$Res>  {
  factory $UserQuoteCopyWith(UserQuote value, $Res Function(UserQuote) _then) = _$UserQuoteCopyWithImpl;
@useResult
$Res call({
 String id, String text, String? author, bool isFavourite, bool isCustom,@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime createdAt
});




}
/// @nodoc
class _$UserQuoteCopyWithImpl<$Res>
    implements $UserQuoteCopyWith<$Res> {
  _$UserQuoteCopyWithImpl(this._self, this._then);

  final UserQuote _self;
  final $Res Function(UserQuote) _then;

/// Create a copy of UserQuote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? author = freezed,Object? isFavourite = null,Object? isCustom = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,isFavourite: null == isFavourite ? _self.isFavourite : isFavourite // ignore: cast_nullable_to_non_nullable
as bool,isCustom: null == isCustom ? _self.isCustom : isCustom // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [UserQuote].
extension UserQuotePatterns on UserQuote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserQuote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserQuote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserQuote value)  $default,){
final _that = this;
switch (_that) {
case _UserQuote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserQuote value)?  $default,){
final _that = this;
switch (_that) {
case _UserQuote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text,  String? author,  bool isFavourite,  bool isCustom, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserQuote() when $default != null:
return $default(_that.id,_that.text,_that.author,_that.isFavourite,_that.isCustom,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text,  String? author,  bool isFavourite,  bool isCustom, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _UserQuote():
return $default(_that.id,_that.text,_that.author,_that.isFavourite,_that.isCustom,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text,  String? author,  bool isFavourite,  bool isCustom, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _UserQuote() when $default != null:
return $default(_that.id,_that.text,_that.author,_that.isFavourite,_that.isCustom,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserQuote implements UserQuote {
  const _UserQuote({required this.id, required this.text, this.author, this.isFavourite = false, this.isCustom = true, @JsonKey(fromJson: _tsRequired, toJson: _tsTo) required this.createdAt});
  factory _UserQuote.fromJson(Map<String, dynamic> json) => _$UserQuoteFromJson(json);

@override final  String id;
@override final  String text;
@override final  String? author;
@override@JsonKey() final  bool isFavourite;
@override@JsonKey() final  bool isCustom;
@override@JsonKey(fromJson: _tsRequired, toJson: _tsTo) final  DateTime createdAt;

/// Create a copy of UserQuote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserQuoteCopyWith<_UserQuote> get copyWith => __$UserQuoteCopyWithImpl<_UserQuote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserQuoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserQuote&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.author, author) || other.author == author)&&(identical(other.isFavourite, isFavourite) || other.isFavourite == isFavourite)&&(identical(other.isCustom, isCustom) || other.isCustom == isCustom)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,author,isFavourite,isCustom,createdAt);

@override
String toString() {
  return 'UserQuote(id: $id, text: $text, author: $author, isFavourite: $isFavourite, isCustom: $isCustom, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$UserQuoteCopyWith<$Res> implements $UserQuoteCopyWith<$Res> {
  factory _$UserQuoteCopyWith(_UserQuote value, $Res Function(_UserQuote) _then) = __$UserQuoteCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, String? author, bool isFavourite, bool isCustom,@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime createdAt
});




}
/// @nodoc
class __$UserQuoteCopyWithImpl<$Res>
    implements _$UserQuoteCopyWith<$Res> {
  __$UserQuoteCopyWithImpl(this._self, this._then);

  final _UserQuote _self;
  final $Res Function(_UserQuote) _then;

/// Create a copy of UserQuote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? author = freezed,Object? isFavourite = null,Object? isCustom = null,Object? createdAt = null,}) {
  return _then(_UserQuote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,isFavourite: null == isFavourite ? _self.isFavourite : isFavourite // ignore: cast_nullable_to_non_nullable
as bool,isCustom: null == isCustom ? _self.isCustom : isCustom // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
