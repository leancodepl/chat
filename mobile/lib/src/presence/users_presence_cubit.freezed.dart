// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'users_presence_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$UsersPresenceStateTearOff {
  const _$UsersPresenceStateTearOff();

  _UsersPresenceState call(
      {Map<String, UserPresence> lastSeen = const <String, UserPresence>{},
      Map<String, UserPresenceStatus> statuses =
          const <String, UserPresenceStatus>{}}) {
    return _UsersPresenceState(
      lastSeen: lastSeen,
      statuses: statuses,
    );
  }
}

/// @nodoc
const $UsersPresenceState = _$UsersPresenceStateTearOff();

/// @nodoc
mixin _$UsersPresenceState {
  Map<String, UserPresence> get lastSeen => throw _privateConstructorUsedError;
  Map<String, UserPresenceStatus> get statuses =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UsersPresenceStateCopyWith<UsersPresenceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsersPresenceStateCopyWith<$Res> {
  factory $UsersPresenceStateCopyWith(
          UsersPresenceState value, $Res Function(UsersPresenceState) then) =
      _$UsersPresenceStateCopyWithImpl<$Res>;
  $Res call(
      {Map<String, UserPresence> lastSeen,
      Map<String, UserPresenceStatus> statuses});
}

/// @nodoc
class _$UsersPresenceStateCopyWithImpl<$Res>
    implements $UsersPresenceStateCopyWith<$Res> {
  _$UsersPresenceStateCopyWithImpl(this._value, this._then);

  final UsersPresenceState _value;
  // ignore: unused_field
  final $Res Function(UsersPresenceState) _then;

  @override
  $Res call({
    Object? lastSeen = freezed,
    Object? statuses = freezed,
  }) {
    return _then(_value.copyWith(
      lastSeen: lastSeen == freezed
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as Map<String, UserPresence>,
      statuses: statuses == freezed
          ? _value.statuses
          : statuses // ignore: cast_nullable_to_non_nullable
              as Map<String, UserPresenceStatus>,
    ));
  }
}

/// @nodoc
abstract class _$UsersPresenceStateCopyWith<$Res>
    implements $UsersPresenceStateCopyWith<$Res> {
  factory _$UsersPresenceStateCopyWith(
          _UsersPresenceState value, $Res Function(_UsersPresenceState) then) =
      __$UsersPresenceStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {Map<String, UserPresence> lastSeen,
      Map<String, UserPresenceStatus> statuses});
}

/// @nodoc
class __$UsersPresenceStateCopyWithImpl<$Res>
    extends _$UsersPresenceStateCopyWithImpl<$Res>
    implements _$UsersPresenceStateCopyWith<$Res> {
  __$UsersPresenceStateCopyWithImpl(
      _UsersPresenceState _value, $Res Function(_UsersPresenceState) _then)
      : super(_value, (v) => _then(v as _UsersPresenceState));

  @override
  _UsersPresenceState get _value => super._value as _UsersPresenceState;

  @override
  $Res call({
    Object? lastSeen = freezed,
    Object? statuses = freezed,
  }) {
    return _then(_UsersPresenceState(
      lastSeen: lastSeen == freezed
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as Map<String, UserPresence>,
      statuses: statuses == freezed
          ? _value.statuses
          : statuses // ignore: cast_nullable_to_non_nullable
              as Map<String, UserPresenceStatus>,
    ));
  }
}

/// @nodoc

class _$_UsersPresenceState extends _UsersPresenceState {
  const _$_UsersPresenceState(
      {this.lastSeen = const <String, UserPresence>{},
      this.statuses = const <String, UserPresenceStatus>{}})
      : super._();

  @JsonKey()
  @override
  final Map<String, UserPresence> lastSeen;
  @JsonKey()
  @override
  final Map<String, UserPresenceStatus> statuses;

  @override
  String toString() {
    return 'UsersPresenceState(lastSeen: $lastSeen, statuses: $statuses)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UsersPresenceState &&
            const DeepCollectionEquality().equals(other.lastSeen, lastSeen) &&
            const DeepCollectionEquality().equals(other.statuses, statuses));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(lastSeen),
      const DeepCollectionEquality().hash(statuses));

  @JsonKey(ignore: true)
  @override
  _$UsersPresenceStateCopyWith<_UsersPresenceState> get copyWith =>
      __$UsersPresenceStateCopyWithImpl<_UsersPresenceState>(this, _$identity);
}

abstract class _UsersPresenceState extends UsersPresenceState {
  const factory _UsersPresenceState(
      {Map<String, UserPresence> lastSeen,
      Map<String, UserPresenceStatus> statuses}) = _$_UsersPresenceState;
  const _UsersPresenceState._() : super._();

  @override
  Map<String, UserPresence> get lastSeen;
  @override
  Map<String, UserPresenceStatus> get statuses;
  @override
  @JsonKey(ignore: true)
  _$UsersPresenceStateCopyWith<_UsersPresenceState> get copyWith =>
      throw _privateConstructorUsedError;
}
