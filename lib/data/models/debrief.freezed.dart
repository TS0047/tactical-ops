// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debrief.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Debrief {

 String get id; String get userId;@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime get date; List<String> get completed; List<String> get wins; List<String> get blockers; List<String> get carryOvers; RagStatus get moodRating; String? get freeNotes;@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime get submittedAt;
/// Create a copy of Debrief
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebriefCopyWith<Debrief> get copyWith => _$DebriefCopyWithImpl<Debrief>(this as Debrief, _$identity);

  /// Serializes this Debrief to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Debrief&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.completed, completed)&&const DeepCollectionEquality().equals(other.wins, wins)&&const DeepCollectionEquality().equals(other.blockers, blockers)&&const DeepCollectionEquality().equals(other.carryOvers, carryOvers)&&(identical(other.moodRating, moodRating) || other.moodRating == moodRating)&&(identical(other.freeNotes, freeNotes) || other.freeNotes == freeNotes)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,date,const DeepCollectionEquality().hash(completed),const DeepCollectionEquality().hash(wins),const DeepCollectionEquality().hash(blockers),const DeepCollectionEquality().hash(carryOvers),moodRating,freeNotes,submittedAt);

@override
String toString() {
  return 'Debrief(id: $id, userId: $userId, date: $date, completed: $completed, wins: $wins, blockers: $blockers, carryOvers: $carryOvers, moodRating: $moodRating, freeNotes: $freeNotes, submittedAt: $submittedAt)';
}


}

/// @nodoc
abstract mixin class $DebriefCopyWith<$Res>  {
  factory $DebriefCopyWith(Debrief value, $Res Function(Debrief) _then) = _$DebriefCopyWithImpl;
@useResult
$Res call({
 String id, String userId,@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime date, List<String> completed, List<String> wins, List<String> blockers, List<String> carryOvers, RagStatus moodRating, String? freeNotes,@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime submittedAt
});




}
/// @nodoc
class _$DebriefCopyWithImpl<$Res>
    implements $DebriefCopyWith<$Res> {
  _$DebriefCopyWithImpl(this._self, this._then);

  final Debrief _self;
  final $Res Function(Debrief) _then;

/// Create a copy of Debrief
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? date = null,Object? completed = null,Object? wins = null,Object? blockers = null,Object? carryOvers = null,Object? moodRating = null,Object? freeNotes = freezed,Object? submittedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as List<String>,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as List<String>,blockers: null == blockers ? _self.blockers : blockers // ignore: cast_nullable_to_non_nullable
as List<String>,carryOvers: null == carryOvers ? _self.carryOvers : carryOvers // ignore: cast_nullable_to_non_nullable
as List<String>,moodRating: null == moodRating ? _self.moodRating : moodRating // ignore: cast_nullable_to_non_nullable
as RagStatus,freeNotes: freezed == freeNotes ? _self.freeNotes : freeNotes // ignore: cast_nullable_to_non_nullable
as String?,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Debrief].
extension DebriefPatterns on Debrief {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Debrief value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Debrief() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Debrief value)  $default,){
final _that = this;
switch (_that) {
case _Debrief():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Debrief value)?  $default,){
final _that = this;
switch (_that) {
case _Debrief() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime date,  List<String> completed,  List<String> wins,  List<String> blockers,  List<String> carryOvers,  RagStatus moodRating,  String? freeNotes, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime submittedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Debrief() when $default != null:
return $default(_that.id,_that.userId,_that.date,_that.completed,_that.wins,_that.blockers,_that.carryOvers,_that.moodRating,_that.freeNotes,_that.submittedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime date,  List<String> completed,  List<String> wins,  List<String> blockers,  List<String> carryOvers,  RagStatus moodRating,  String? freeNotes, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime submittedAt)  $default,) {final _that = this;
switch (_that) {
case _Debrief():
return $default(_that.id,_that.userId,_that.date,_that.completed,_that.wins,_that.blockers,_that.carryOvers,_that.moodRating,_that.freeNotes,_that.submittedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime date,  List<String> completed,  List<String> wins,  List<String> blockers,  List<String> carryOvers,  RagStatus moodRating,  String? freeNotes, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime submittedAt)?  $default,) {final _that = this;
switch (_that) {
case _Debrief() when $default != null:
return $default(_that.id,_that.userId,_that.date,_that.completed,_that.wins,_that.blockers,_that.carryOvers,_that.moodRating,_that.freeNotes,_that.submittedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Debrief implements Debrief {
  const _Debrief({required this.id, required this.userId, @JsonKey(fromJson: _tsRequired, toJson: _tsTo) required this.date, final  List<String> completed = const [], final  List<String> wins = const [], final  List<String> blockers = const [], final  List<String> carryOvers = const [], this.moodRating = RagStatus.green, this.freeNotes, @JsonKey(fromJson: _tsRequired, toJson: _tsTo) required this.submittedAt}): _completed = completed,_wins = wins,_blockers = blockers,_carryOvers = carryOvers;
  factory _Debrief.fromJson(Map<String, dynamic> json) => _$DebriefFromJson(json);

@override final  String id;
@override final  String userId;
@override@JsonKey(fromJson: _tsRequired, toJson: _tsTo) final  DateTime date;
 final  List<String> _completed;
@override@JsonKey() List<String> get completed {
  if (_completed is EqualUnmodifiableListView) return _completed;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_completed);
}

 final  List<String> _wins;
@override@JsonKey() List<String> get wins {
  if (_wins is EqualUnmodifiableListView) return _wins;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_wins);
}

 final  List<String> _blockers;
@override@JsonKey() List<String> get blockers {
  if (_blockers is EqualUnmodifiableListView) return _blockers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blockers);
}

 final  List<String> _carryOvers;
@override@JsonKey() List<String> get carryOvers {
  if (_carryOvers is EqualUnmodifiableListView) return _carryOvers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_carryOvers);
}

@override@JsonKey() final  RagStatus moodRating;
@override final  String? freeNotes;
@override@JsonKey(fromJson: _tsRequired, toJson: _tsTo) final  DateTime submittedAt;

/// Create a copy of Debrief
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebriefCopyWith<_Debrief> get copyWith => __$DebriefCopyWithImpl<_Debrief>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DebriefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Debrief&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._completed, _completed)&&const DeepCollectionEquality().equals(other._wins, _wins)&&const DeepCollectionEquality().equals(other._blockers, _blockers)&&const DeepCollectionEquality().equals(other._carryOvers, _carryOvers)&&(identical(other.moodRating, moodRating) || other.moodRating == moodRating)&&(identical(other.freeNotes, freeNotes) || other.freeNotes == freeNotes)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,date,const DeepCollectionEquality().hash(_completed),const DeepCollectionEquality().hash(_wins),const DeepCollectionEquality().hash(_blockers),const DeepCollectionEquality().hash(_carryOvers),moodRating,freeNotes,submittedAt);

@override
String toString() {
  return 'Debrief(id: $id, userId: $userId, date: $date, completed: $completed, wins: $wins, blockers: $blockers, carryOvers: $carryOvers, moodRating: $moodRating, freeNotes: $freeNotes, submittedAt: $submittedAt)';
}


}

/// @nodoc
abstract mixin class _$DebriefCopyWith<$Res> implements $DebriefCopyWith<$Res> {
  factory _$DebriefCopyWith(_Debrief value, $Res Function(_Debrief) _then) = __$DebriefCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId,@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime date, List<String> completed, List<String> wins, List<String> blockers, List<String> carryOvers, RagStatus moodRating, String? freeNotes,@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime submittedAt
});




}
/// @nodoc
class __$DebriefCopyWithImpl<$Res>
    implements _$DebriefCopyWith<$Res> {
  __$DebriefCopyWithImpl(this._self, this._then);

  final _Debrief _self;
  final $Res Function(_Debrief) _then;

/// Create a copy of Debrief
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? date = null,Object? completed = null,Object? wins = null,Object? blockers = null,Object? carryOvers = null,Object? moodRating = null,Object? freeNotes = freezed,Object? submittedAt = null,}) {
  return _then(_Debrief(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,completed: null == completed ? _self._completed : completed // ignore: cast_nullable_to_non_nullable
as List<String>,wins: null == wins ? _self._wins : wins // ignore: cast_nullable_to_non_nullable
as List<String>,blockers: null == blockers ? _self._blockers : blockers // ignore: cast_nullable_to_non_nullable
as List<String>,carryOvers: null == carryOvers ? _self._carryOvers : carryOvers // ignore: cast_nullable_to_non_nullable
as List<String>,moodRating: null == moodRating ? _self.moodRating : moodRating // ignore: cast_nullable_to_non_nullable
as RagStatus,freeNotes: freezed == freeNotes ? _self.freeNotes : freeNotes // ignore: cast_nullable_to_non_nullable
as String?,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
