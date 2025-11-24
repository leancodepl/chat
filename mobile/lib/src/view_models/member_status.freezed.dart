// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MemberStatus {

 String? get lastSeenMessageId; DateTime? get lastSeenMessageDate;
/// Create a copy of MemberStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberStatusCopyWith<MemberStatus> get copyWith => _$MemberStatusCopyWithImpl<MemberStatus>(this as MemberStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberStatus&&(identical(other.lastSeenMessageId, lastSeenMessageId) || other.lastSeenMessageId == lastSeenMessageId)&&(identical(other.lastSeenMessageDate, lastSeenMessageDate) || other.lastSeenMessageDate == lastSeenMessageDate));
}


@override
int get hashCode => Object.hash(runtimeType,lastSeenMessageId,lastSeenMessageDate);

@override
String toString() {
  return 'MemberStatus(lastSeenMessageId: $lastSeenMessageId, lastSeenMessageDate: $lastSeenMessageDate)';
}


}

/// @nodoc
abstract mixin class $MemberStatusCopyWith<$Res>  {
  factory $MemberStatusCopyWith(MemberStatus value, $Res Function(MemberStatus) _then) = _$MemberStatusCopyWithImpl;
@useResult
$Res call({
 String? lastSeenMessageId, DateTime? lastSeenMessageDate
});




}
/// @nodoc
class _$MemberStatusCopyWithImpl<$Res>
    implements $MemberStatusCopyWith<$Res> {
  _$MemberStatusCopyWithImpl(this._self, this._then);

  final MemberStatus _self;
  final $Res Function(MemberStatus) _then;

/// Create a copy of MemberStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lastSeenMessageId = freezed,Object? lastSeenMessageDate = freezed,}) {
  return _then(_self.copyWith(
lastSeenMessageId: freezed == lastSeenMessageId ? _self.lastSeenMessageId : lastSeenMessageId // ignore: cast_nullable_to_non_nullable
as String?,lastSeenMessageDate: freezed == lastSeenMessageDate ? _self.lastSeenMessageDate : lastSeenMessageDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberStatus].
extension MemberStatusPatterns on MemberStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberStatus value)  $default,){
final _that = this;
switch (_that) {
case _MemberStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberStatus value)?  $default,){
final _that = this;
switch (_that) {
case _MemberStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? lastSeenMessageId,  DateTime? lastSeenMessageDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberStatus() when $default != null:
return $default(_that.lastSeenMessageId,_that.lastSeenMessageDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? lastSeenMessageId,  DateTime? lastSeenMessageDate)  $default,) {final _that = this;
switch (_that) {
case _MemberStatus():
return $default(_that.lastSeenMessageId,_that.lastSeenMessageDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? lastSeenMessageId,  DateTime? lastSeenMessageDate)?  $default,) {final _that = this;
switch (_that) {
case _MemberStatus() when $default != null:
return $default(_that.lastSeenMessageId,_that.lastSeenMessageDate);case _:
  return null;

}
}

}

/// @nodoc


class _MemberStatus implements MemberStatus {
  const _MemberStatus({required this.lastSeenMessageId, required this.lastSeenMessageDate});
  

@override final  String? lastSeenMessageId;
@override final  DateTime? lastSeenMessageDate;

/// Create a copy of MemberStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberStatusCopyWith<_MemberStatus> get copyWith => __$MemberStatusCopyWithImpl<_MemberStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberStatus&&(identical(other.lastSeenMessageId, lastSeenMessageId) || other.lastSeenMessageId == lastSeenMessageId)&&(identical(other.lastSeenMessageDate, lastSeenMessageDate) || other.lastSeenMessageDate == lastSeenMessageDate));
}


@override
int get hashCode => Object.hash(runtimeType,lastSeenMessageId,lastSeenMessageDate);

@override
String toString() {
  return 'MemberStatus(lastSeenMessageId: $lastSeenMessageId, lastSeenMessageDate: $lastSeenMessageDate)';
}


}

/// @nodoc
abstract mixin class _$MemberStatusCopyWith<$Res> implements $MemberStatusCopyWith<$Res> {
  factory _$MemberStatusCopyWith(_MemberStatus value, $Res Function(_MemberStatus) _then) = __$MemberStatusCopyWithImpl;
@override @useResult
$Res call({
 String? lastSeenMessageId, DateTime? lastSeenMessageDate
});




}
/// @nodoc
class __$MemberStatusCopyWithImpl<$Res>
    implements _$MemberStatusCopyWith<$Res> {
  __$MemberStatusCopyWithImpl(this._self, this._then);

  final _MemberStatus _self;
  final $Res Function(_MemberStatus) _then;

/// Create a copy of MemberStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lastSeenMessageId = freezed,Object? lastSeenMessageDate = freezed,}) {
  return _then(_MemberStatus(
lastSeenMessageId: freezed == lastSeenMessageId ? _self.lastSeenMessageId : lastSeenMessageId // ignore: cast_nullable_to_non_nullable
as String?,lastSeenMessageDate: freezed == lastSeenMessageDate ? _self.lastSeenMessageDate : lastSeenMessageDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
