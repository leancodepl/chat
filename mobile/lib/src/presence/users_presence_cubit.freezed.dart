// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'users_presence_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UsersPresenceState {

 Map<String, UserPresence> get lastSeen; Map<String, UserPresenceStatus> get statuses;
/// Create a copy of UsersPresenceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsersPresenceStateCopyWith<UsersPresenceState> get copyWith => _$UsersPresenceStateCopyWithImpl<UsersPresenceState>(this as UsersPresenceState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsersPresenceState&&const DeepCollectionEquality().equals(other.lastSeen, lastSeen)&&const DeepCollectionEquality().equals(other.statuses, statuses));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(lastSeen),const DeepCollectionEquality().hash(statuses));

@override
String toString() {
  return 'UsersPresenceState(lastSeen: $lastSeen, statuses: $statuses)';
}


}

/// @nodoc
abstract mixin class $UsersPresenceStateCopyWith<$Res>  {
  factory $UsersPresenceStateCopyWith(UsersPresenceState value, $Res Function(UsersPresenceState) _then) = _$UsersPresenceStateCopyWithImpl;
@useResult
$Res call({
 Map<String, UserPresence> lastSeen, Map<String, UserPresenceStatus> statuses
});




}
/// @nodoc
class _$UsersPresenceStateCopyWithImpl<$Res>
    implements $UsersPresenceStateCopyWith<$Res> {
  _$UsersPresenceStateCopyWithImpl(this._self, this._then);

  final UsersPresenceState _self;
  final $Res Function(UsersPresenceState) _then;

/// Create a copy of UsersPresenceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lastSeen = null,Object? statuses = null,}) {
  return _then(_self.copyWith(
lastSeen: null == lastSeen ? _self.lastSeen : lastSeen // ignore: cast_nullable_to_non_nullable
as Map<String, UserPresence>,statuses: null == statuses ? _self.statuses : statuses // ignore: cast_nullable_to_non_nullable
as Map<String, UserPresenceStatus>,
  ));
}

}


/// Adds pattern-matching-related methods to [UsersPresenceState].
extension UsersPresenceStatePatterns on UsersPresenceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UsersPresenceState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UsersPresenceState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UsersPresenceState value)  $default,){
final _that = this;
switch (_that) {
case _UsersPresenceState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UsersPresenceState value)?  $default,){
final _that = this;
switch (_that) {
case _UsersPresenceState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, UserPresence> lastSeen,  Map<String, UserPresenceStatus> statuses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UsersPresenceState() when $default != null:
return $default(_that.lastSeen,_that.statuses);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, UserPresence> lastSeen,  Map<String, UserPresenceStatus> statuses)  $default,) {final _that = this;
switch (_that) {
case _UsersPresenceState():
return $default(_that.lastSeen,_that.statuses);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, UserPresence> lastSeen,  Map<String, UserPresenceStatus> statuses)?  $default,) {final _that = this;
switch (_that) {
case _UsersPresenceState() when $default != null:
return $default(_that.lastSeen,_that.statuses);case _:
  return null;

}
}

}

/// @nodoc


class _UsersPresenceState extends UsersPresenceState {
  const _UsersPresenceState({final  Map<String, UserPresence> lastSeen = const <String, UserPresence>{}, final  Map<String, UserPresenceStatus> statuses = const <String, UserPresenceStatus>{}}): _lastSeen = lastSeen,_statuses = statuses,super._();
  

 final  Map<String, UserPresence> _lastSeen;
@override@JsonKey() Map<String, UserPresence> get lastSeen {
  if (_lastSeen is EqualUnmodifiableMapView) return _lastSeen;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_lastSeen);
}

 final  Map<String, UserPresenceStatus> _statuses;
@override@JsonKey() Map<String, UserPresenceStatus> get statuses {
  if (_statuses is EqualUnmodifiableMapView) return _statuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_statuses);
}


/// Create a copy of UsersPresenceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UsersPresenceStateCopyWith<_UsersPresenceState> get copyWith => __$UsersPresenceStateCopyWithImpl<_UsersPresenceState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UsersPresenceState&&const DeepCollectionEquality().equals(other._lastSeen, _lastSeen)&&const DeepCollectionEquality().equals(other._statuses, _statuses));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_lastSeen),const DeepCollectionEquality().hash(_statuses));

@override
String toString() {
  return 'UsersPresenceState(lastSeen: $lastSeen, statuses: $statuses)';
}


}

/// @nodoc
abstract mixin class _$UsersPresenceStateCopyWith<$Res> implements $UsersPresenceStateCopyWith<$Res> {
  factory _$UsersPresenceStateCopyWith(_UsersPresenceState value, $Res Function(_UsersPresenceState) _then) = __$UsersPresenceStateCopyWithImpl;
@override @useResult
$Res call({
 Map<String, UserPresence> lastSeen, Map<String, UserPresenceStatus> statuses
});




}
/// @nodoc
class __$UsersPresenceStateCopyWithImpl<$Res>
    implements _$UsersPresenceStateCopyWith<$Res> {
  __$UsersPresenceStateCopyWithImpl(this._self, this._then);

  final _UsersPresenceState _self;
  final $Res Function(_UsersPresenceState) _then;

/// Create a copy of UsersPresenceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lastSeen = null,Object? statuses = null,}) {
  return _then(_UsersPresenceState(
lastSeen: null == lastSeen ? _self._lastSeen : lastSeen // ignore: cast_nullable_to_non_nullable
as Map<String, UserPresence>,statuses: null == statuses ? _self._statuses : statuses // ignore: cast_nullable_to_non_nullable
as Map<String, UserPresenceStatus>,
  ));
}


}

// dart format on
