// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Task {

 String get id; String get userId; String get title; String? get description; TaskCategory get category; TaskPriority get priority; TaskStatus get status;@JsonKey(fromJson: _tsNullable, toJson: _tsTo) DateTime? get dueDate; bool get isCompleted; EisenhowerQuadrant? get quadrant;@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime get createdAt;@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime get updatedAt;
/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskCopyWith<Task> get copyWith => _$TaskCopyWithImpl<Task>(this as Task, _$identity);

  /// Serializes this Task to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Task&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.quadrant, quadrant) || other.quadrant == quadrant)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,title,description,category,priority,status,dueDate,isCompleted,quadrant,createdAt,updatedAt);

@override
String toString() {
  return 'Task(id: $id, userId: $userId, title: $title, description: $description, category: $category, priority: $priority, status: $status, dueDate: $dueDate, isCompleted: $isCompleted, quadrant: $quadrant, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TaskCopyWith<$Res>  {
  factory $TaskCopyWith(Task value, $Res Function(Task) _then) = _$TaskCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String title, String? description, TaskCategory category, TaskPriority priority, TaskStatus status,@JsonKey(fromJson: _tsNullable, toJson: _tsTo) DateTime? dueDate, bool isCompleted, EisenhowerQuadrant? quadrant,@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime createdAt,@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime updatedAt
});




}
/// @nodoc
class _$TaskCopyWithImpl<$Res>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._self, this._then);

  final Task _self;
  final $Res Function(Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? title = null,Object? description = freezed,Object? category = null,Object? priority = null,Object? status = null,Object? dueDate = freezed,Object? isCompleted = null,Object? quadrant = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TaskCategory,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,quadrant: freezed == quadrant ? _self.quadrant : quadrant // ignore: cast_nullable_to_non_nullable
as EisenhowerQuadrant?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Task].
extension TaskPatterns on Task {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Task value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Task() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Task value)  $default,){
final _that = this;
switch (_that) {
case _Task():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Task value)?  $default,){
final _that = this;
switch (_that) {
case _Task() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String title,  String? description,  TaskCategory category,  TaskPriority priority,  TaskStatus status, @JsonKey(fromJson: _tsNullable, toJson: _tsTo)  DateTime? dueDate,  bool isCompleted,  EisenhowerQuadrant? quadrant, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime createdAt, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.description,_that.category,_that.priority,_that.status,_that.dueDate,_that.isCompleted,_that.quadrant,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String title,  String? description,  TaskCategory category,  TaskPriority priority,  TaskStatus status, @JsonKey(fromJson: _tsNullable, toJson: _tsTo)  DateTime? dueDate,  bool isCompleted,  EisenhowerQuadrant? quadrant, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime createdAt, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Task():
return $default(_that.id,_that.userId,_that.title,_that.description,_that.category,_that.priority,_that.status,_that.dueDate,_that.isCompleted,_that.quadrant,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String title,  String? description,  TaskCategory category,  TaskPriority priority,  TaskStatus status, @JsonKey(fromJson: _tsNullable, toJson: _tsTo)  DateTime? dueDate,  bool isCompleted,  EisenhowerQuadrant? quadrant, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime createdAt, @JsonKey(fromJson: _tsRequired, toJson: _tsTo)  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.description,_that.category,_that.priority,_that.status,_that.dueDate,_that.isCompleted,_that.quadrant,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Task implements Task {
  const _Task({required this.id, required this.userId, required this.title, this.description, this.category = TaskCategory.mission, this.priority = TaskPriority.medium, this.status = TaskStatus.active, @JsonKey(fromJson: _tsNullable, toJson: _tsTo) this.dueDate, this.isCompleted = false, this.quadrant, @JsonKey(fromJson: _tsRequired, toJson: _tsTo) required this.createdAt, @JsonKey(fromJson: _tsRequired, toJson: _tsTo) required this.updatedAt});
  factory _Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String title;
@override final  String? description;
@override@JsonKey() final  TaskCategory category;
@override@JsonKey() final  TaskPriority priority;
@override@JsonKey() final  TaskStatus status;
@override@JsonKey(fromJson: _tsNullable, toJson: _tsTo) final  DateTime? dueDate;
@override@JsonKey() final  bool isCompleted;
@override final  EisenhowerQuadrant? quadrant;
@override@JsonKey(fromJson: _tsRequired, toJson: _tsTo) final  DateTime createdAt;
@override@JsonKey(fromJson: _tsRequired, toJson: _tsTo) final  DateTime updatedAt;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskCopyWith<_Task> get copyWith => __$TaskCopyWithImpl<_Task>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Task&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.quadrant, quadrant) || other.quadrant == quadrant)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,title,description,category,priority,status,dueDate,isCompleted,quadrant,createdAt,updatedAt);

@override
String toString() {
  return 'Task(id: $id, userId: $userId, title: $title, description: $description, category: $category, priority: $priority, status: $status, dueDate: $dueDate, isCompleted: $isCompleted, quadrant: $quadrant, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$TaskCopyWith(_Task value, $Res Function(_Task) _then) = __$TaskCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String title, String? description, TaskCategory category, TaskPriority priority, TaskStatus status,@JsonKey(fromJson: _tsNullable, toJson: _tsTo) DateTime? dueDate, bool isCompleted, EisenhowerQuadrant? quadrant,@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime createdAt,@JsonKey(fromJson: _tsRequired, toJson: _tsTo) DateTime updatedAt
});




}
/// @nodoc
class __$TaskCopyWithImpl<$Res>
    implements _$TaskCopyWith<$Res> {
  __$TaskCopyWithImpl(this._self, this._then);

  final _Task _self;
  final $Res Function(_Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? title = null,Object? description = freezed,Object? category = null,Object? priority = null,Object? status = null,Object? dueDate = freezed,Object? isCompleted = null,Object? quadrant = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Task(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TaskCategory,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,quadrant: freezed == quadrant ? _self.quadrant : quadrant // ignore: cast_nullable_to_non_nullable
as EisenhowerQuadrant?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
