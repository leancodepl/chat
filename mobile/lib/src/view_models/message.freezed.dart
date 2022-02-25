// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MessageTearOff {
  const _$MessageTearOff();

  _Message<TChatMember> call<TChatMember>(
      {required String id,
      required String content,
      required DateTime dateSent,
      required TChatMember sender,
      required MessageUserType userType}) {
    return _Message<TChatMember>(
      id: id,
      content: content,
      dateSent: dateSent,
      sender: sender,
      userType: userType,
    );
  }
}

/// @nodoc
const $Message = _$MessageTearOff();

/// @nodoc
mixin _$Message<TChatMember> {
  String get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get dateSent => throw _privateConstructorUsedError;
  TChatMember get sender => throw _privateConstructorUsedError;
  MessageUserType get userType => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MessageCopyWith<TChatMember, Message<TChatMember>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<TChatMember, $Res> {
  factory $MessageCopyWith(Message<TChatMember> value,
          $Res Function(Message<TChatMember>) then) =
      _$MessageCopyWithImpl<TChatMember, $Res>;
  $Res call(
      {String id,
      String content,
      DateTime dateSent,
      TChatMember sender,
      MessageUserType userType});
}

/// @nodoc
class _$MessageCopyWithImpl<TChatMember, $Res>
    implements $MessageCopyWith<TChatMember, $Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  final Message<TChatMember> _value;
  // ignore: unused_field
  final $Res Function(Message<TChatMember>) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? content = freezed,
    Object? dateSent = freezed,
    Object? sender = freezed,
    Object? userType = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      dateSent: dateSent == freezed
          ? _value.dateSent
          : dateSent // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sender: sender == freezed
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as TChatMember,
      userType: userType == freezed
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as MessageUserType,
    ));
  }
}

/// @nodoc
abstract class _$MessageCopyWith<TChatMember, $Res>
    implements $MessageCopyWith<TChatMember, $Res> {
  factory _$MessageCopyWith(_Message<TChatMember> value,
          $Res Function(_Message<TChatMember>) then) =
      __$MessageCopyWithImpl<TChatMember, $Res>;
  @override
  $Res call(
      {String id,
      String content,
      DateTime dateSent,
      TChatMember sender,
      MessageUserType userType});
}

/// @nodoc
class __$MessageCopyWithImpl<TChatMember, $Res>
    extends _$MessageCopyWithImpl<TChatMember, $Res>
    implements _$MessageCopyWith<TChatMember, $Res> {
  __$MessageCopyWithImpl(
      _Message<TChatMember> _value, $Res Function(_Message<TChatMember>) _then)
      : super(_value, (v) => _then(v as _Message<TChatMember>));

  @override
  _Message<TChatMember> get _value => super._value as _Message<TChatMember>;

  @override
  $Res call({
    Object? id = freezed,
    Object? content = freezed,
    Object? dateSent = freezed,
    Object? sender = freezed,
    Object? userType = freezed,
  }) {
    return _then(_Message<TChatMember>(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      dateSent: dateSent == freezed
          ? _value.dateSent
          : dateSent // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sender: sender == freezed
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as TChatMember,
      userType: userType == freezed
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as MessageUserType,
    ));
  }
}

/// @nodoc

class _$_Message<TChatMember> implements _Message<TChatMember> {
  const _$_Message(
      {required this.id,
      required this.content,
      required this.dateSent,
      required this.sender,
      required this.userType});

  @override
  final String id;
  @override
  final String content;
  @override
  final DateTime dateSent;
  @override
  final TChatMember sender;
  @override
  final MessageUserType userType;

  @override
  String toString() {
    return 'Message<$TChatMember>(id: $id, content: $content, dateSent: $dateSent, sender: $sender, userType: $userType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Message<TChatMember> &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.content, content) &&
            const DeepCollectionEquality().equals(other.dateSent, dateSent) &&
            const DeepCollectionEquality().equals(other.sender, sender) &&
            const DeepCollectionEquality().equals(other.userType, userType));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(content),
      const DeepCollectionEquality().hash(dateSent),
      const DeepCollectionEquality().hash(sender),
      const DeepCollectionEquality().hash(userType));

  @JsonKey(ignore: true)
  @override
  _$MessageCopyWith<TChatMember, _Message<TChatMember>> get copyWith =>
      __$MessageCopyWithImpl<TChatMember, _Message<TChatMember>>(
          this, _$identity);
}

abstract class _Message<TChatMember> implements Message<TChatMember> {
  const factory _Message(
      {required String id,
      required String content,
      required DateTime dateSent,
      required TChatMember sender,
      required MessageUserType userType}) = _$_Message<TChatMember>;

  @override
  String get id;
  @override
  String get content;
  @override
  DateTime get dateSent;
  @override
  TChatMember get sender;
  @override
  MessageUserType get userType;
  @override
  @JsonKey(ignore: true)
  _$MessageCopyWith<TChatMember, _Message<TChatMember>> get copyWith =>
      throw _privateConstructorUsedError;
}
