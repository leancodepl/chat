// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'member_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MemberStatusTearOff {
  const _$MemberStatusTearOff();

  _MemberStatus call(
      {required String? lastSeenMessageId,
      required DateTime? lastSeenMessageDate}) {
    return _MemberStatus(
      lastSeenMessageId: lastSeenMessageId,
      lastSeenMessageDate: lastSeenMessageDate,
    );
  }
}

/// @nodoc
const $MemberStatus = _$MemberStatusTearOff();

/// @nodoc
mixin _$MemberStatus {
  String? get lastSeenMessageId => throw _privateConstructorUsedError;
  DateTime? get lastSeenMessageDate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MemberStatusCopyWith<MemberStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemberStatusCopyWith<$Res> {
  factory $MemberStatusCopyWith(
          MemberStatus value, $Res Function(MemberStatus) then) =
      _$MemberStatusCopyWithImpl<$Res>;
  $Res call({String? lastSeenMessageId, DateTime? lastSeenMessageDate});
}

/// @nodoc
class _$MemberStatusCopyWithImpl<$Res> implements $MemberStatusCopyWith<$Res> {
  _$MemberStatusCopyWithImpl(this._value, this._then);

  final MemberStatus _value;
  // ignore: unused_field
  final $Res Function(MemberStatus) _then;

  @override
  $Res call({
    Object? lastSeenMessageId = freezed,
    Object? lastSeenMessageDate = freezed,
  }) {
    return _then(_value.copyWith(
      lastSeenMessageId: lastSeenMessageId == freezed
          ? _value.lastSeenMessageId
          : lastSeenMessageId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSeenMessageDate: lastSeenMessageDate == freezed
          ? _value.lastSeenMessageDate
          : lastSeenMessageDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$MemberStatusCopyWith<$Res>
    implements $MemberStatusCopyWith<$Res> {
  factory _$MemberStatusCopyWith(
          _MemberStatus value, $Res Function(_MemberStatus) then) =
      __$MemberStatusCopyWithImpl<$Res>;
  @override
  $Res call({String? lastSeenMessageId, DateTime? lastSeenMessageDate});
}

/// @nodoc
class __$MemberStatusCopyWithImpl<$Res> extends _$MemberStatusCopyWithImpl<$Res>
    implements _$MemberStatusCopyWith<$Res> {
  __$MemberStatusCopyWithImpl(
      _MemberStatus _value, $Res Function(_MemberStatus) _then)
      : super(_value, (v) => _then(v as _MemberStatus));

  @override
  _MemberStatus get _value => super._value as _MemberStatus;

  @override
  $Res call({
    Object? lastSeenMessageId = freezed,
    Object? lastSeenMessageDate = freezed,
  }) {
    return _then(_MemberStatus(
      lastSeenMessageId: lastSeenMessageId == freezed
          ? _value.lastSeenMessageId
          : lastSeenMessageId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSeenMessageDate: lastSeenMessageDate == freezed
          ? _value.lastSeenMessageDate
          : lastSeenMessageDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$_MemberStatus implements _MemberStatus {
  const _$_MemberStatus(
      {required this.lastSeenMessageId, required this.lastSeenMessageDate});

  @override
  final String? lastSeenMessageId;
  @override
  final DateTime? lastSeenMessageDate;

  @override
  String toString() {
    return 'MemberStatus(lastSeenMessageId: $lastSeenMessageId, lastSeenMessageDate: $lastSeenMessageDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MemberStatus &&
            const DeepCollectionEquality()
                .equals(other.lastSeenMessageId, lastSeenMessageId) &&
            const DeepCollectionEquality()
                .equals(other.lastSeenMessageDate, lastSeenMessageDate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(lastSeenMessageId),
      const DeepCollectionEquality().hash(lastSeenMessageDate));

  @JsonKey(ignore: true)
  @override
  _$MemberStatusCopyWith<_MemberStatus> get copyWith =>
      __$MemberStatusCopyWithImpl<_MemberStatus>(this, _$identity);
}

abstract class _MemberStatus implements MemberStatus {
  const factory _MemberStatus(
      {required String? lastSeenMessageId,
      required DateTime? lastSeenMessageDate}) = _$_MemberStatus;

  @override
  String? get lastSeenMessageId;
  @override
  DateTime? get lastSeenMessageDate;
  @override
  @JsonKey(ignore: true)
  _$MemberStatusCopyWith<_MemberStatus> get copyWith =>
      throw _privateConstructorUsedError;
}
