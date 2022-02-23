// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'conversation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ConversationTearOff {
  const _$ConversationTearOff();

  _Conversation<TMember, TConversationData> call<TMember, TConversationData>(
      {required String id,
      required List<TMember> members,
      required Map<String, MemberStatus> statuses,
      required TConversationData? data,
      required Map<String, String?>? metadata,
      required Message<TMember>? lastMessage,
      required List<String>? lockedByUserIds}) {
    return _Conversation<TMember, TConversationData>(
      id: id,
      members: members,
      statuses: statuses,
      data: data,
      metadata: metadata,
      lastMessage: lastMessage,
      lockedByUserIds: lockedByUserIds,
    );
  }
}

/// @nodoc
const $Conversation = _$ConversationTearOff();

/// @nodoc
mixin _$Conversation<TMember, TConversationData> {
  String get id => throw _privateConstructorUsedError;
  List<TMember> get members => throw _privateConstructorUsedError;
  Map<String, MemberStatus> get statuses => throw _privateConstructorUsedError;
  TConversationData? get data => throw _privateConstructorUsedError;
  Map<String, String?>? get metadata => throw _privateConstructorUsedError;
  Message<TMember>? get lastMessage => throw _privateConstructorUsedError;
  List<String>? get lockedByUserIds => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ConversationCopyWith<TMember, TConversationData,
          Conversation<TMember, TConversationData>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationCopyWith<TMember, TConversationData, $Res> {
  factory $ConversationCopyWith(Conversation<TMember, TConversationData> value,
          $Res Function(Conversation<TMember, TConversationData>) then) =
      _$ConversationCopyWithImpl<TMember, TConversationData, $Res>;
  $Res call(
      {String id,
      List<TMember> members,
      Map<String, MemberStatus> statuses,
      TConversationData? data,
      Map<String, String?>? metadata,
      Message<TMember>? lastMessage,
      List<String>? lockedByUserIds});

  $MessageCopyWith<TMember, $Res>? get lastMessage;
}

/// @nodoc
class _$ConversationCopyWithImpl<TMember, TConversationData, $Res>
    implements $ConversationCopyWith<TMember, TConversationData, $Res> {
  _$ConversationCopyWithImpl(this._value, this._then);

  final Conversation<TMember, TConversationData> _value;
  // ignore: unused_field
  final $Res Function(Conversation<TMember, TConversationData>) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? members = freezed,
    Object? statuses = freezed,
    Object? data = freezed,
    Object? metadata = freezed,
    Object? lastMessage = freezed,
    Object? lockedByUserIds = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      members: members == freezed
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<TMember>,
      statuses: statuses == freezed
          ? _value.statuses
          : statuses // ignore: cast_nullable_to_non_nullable
              as Map<String, MemberStatus>,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as TConversationData?,
      metadata: metadata == freezed
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>?,
      lastMessage: lastMessage == freezed
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as Message<TMember>?,
      lockedByUserIds: lockedByUserIds == freezed
          ? _value.lockedByUserIds
          : lockedByUserIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }

  @override
  $MessageCopyWith<TMember, $Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $MessageCopyWith<TMember, $Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value));
    });
  }
}

/// @nodoc
abstract class _$ConversationCopyWith<TMember, TConversationData, $Res>
    implements $ConversationCopyWith<TMember, TConversationData, $Res> {
  factory _$ConversationCopyWith(
          _Conversation<TMember, TConversationData> value,
          $Res Function(_Conversation<TMember, TConversationData>) then) =
      __$ConversationCopyWithImpl<TMember, TConversationData, $Res>;
  @override
  $Res call(
      {String id,
      List<TMember> members,
      Map<String, MemberStatus> statuses,
      TConversationData? data,
      Map<String, String?>? metadata,
      Message<TMember>? lastMessage,
      List<String>? lockedByUserIds});

  @override
  $MessageCopyWith<TMember, $Res>? get lastMessage;
}

/// @nodoc
class __$ConversationCopyWithImpl<TMember, TConversationData, $Res>
    extends _$ConversationCopyWithImpl<TMember, TConversationData, $Res>
    implements _$ConversationCopyWith<TMember, TConversationData, $Res> {
  __$ConversationCopyWithImpl(_Conversation<TMember, TConversationData> _value,
      $Res Function(_Conversation<TMember, TConversationData>) _then)
      : super(_value,
            (v) => _then(v as _Conversation<TMember, TConversationData>));

  @override
  _Conversation<TMember, TConversationData> get _value =>
      super._value as _Conversation<TMember, TConversationData>;

  @override
  $Res call({
    Object? id = freezed,
    Object? members = freezed,
    Object? statuses = freezed,
    Object? data = freezed,
    Object? metadata = freezed,
    Object? lastMessage = freezed,
    Object? lockedByUserIds = freezed,
  }) {
    return _then(_Conversation<TMember, TConversationData>(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      members: members == freezed
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<TMember>,
      statuses: statuses == freezed
          ? _value.statuses
          : statuses // ignore: cast_nullable_to_non_nullable
              as Map<String, MemberStatus>,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as TConversationData?,
      metadata: metadata == freezed
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>?,
      lastMessage: lastMessage == freezed
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as Message<TMember>?,
      lockedByUserIds: lockedByUserIds == freezed
          ? _value.lockedByUserIds
          : lockedByUserIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc

class _$_Conversation<TMember, TConversationData>
    extends _Conversation<TMember, TConversationData> {
  const _$_Conversation(
      {required this.id,
      required this.members,
      required this.statuses,
      required this.data,
      required this.metadata,
      required this.lastMessage,
      required this.lockedByUserIds})
      : super._();

  @override
  final String id;
  @override
  final List<TMember> members;
  @override
  final Map<String, MemberStatus> statuses;
  @override
  final TConversationData? data;
  @override
  final Map<String, String?>? metadata;
  @override
  final Message<TMember>? lastMessage;
  @override
  final List<String>? lockedByUserIds;

  @override
  String toString() {
    return 'Conversation<$TMember, $TConversationData>(id: $id, members: $members, statuses: $statuses, data: $data, metadata: $metadata, lastMessage: $lastMessage, lockedByUserIds: $lockedByUserIds)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Conversation<TMember, TConversationData> &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.members, members) &&
            const DeepCollectionEquality().equals(other.statuses, statuses) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            const DeepCollectionEquality().equals(other.metadata, metadata) &&
            const DeepCollectionEquality()
                .equals(other.lastMessage, lastMessage) &&
            const DeepCollectionEquality()
                .equals(other.lockedByUserIds, lockedByUserIds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(members),
      const DeepCollectionEquality().hash(statuses),
      const DeepCollectionEquality().hash(data),
      const DeepCollectionEquality().hash(metadata),
      const DeepCollectionEquality().hash(lastMessage),
      const DeepCollectionEquality().hash(lockedByUserIds));

  @JsonKey(ignore: true)
  @override
  _$ConversationCopyWith<TMember, TConversationData,
          _Conversation<TMember, TConversationData>>
      get copyWith => __$ConversationCopyWithImpl<TMember, TConversationData,
          _Conversation<TMember, TConversationData>>(this, _$identity);
}

abstract class _Conversation<TMember, TConversationData>
    extends Conversation<TMember, TConversationData> {
  const factory _Conversation(
          {required String id,
          required List<TMember> members,
          required Map<String, MemberStatus> statuses,
          required TConversationData? data,
          required Map<String, String?>? metadata,
          required Message<TMember>? lastMessage,
          required List<String>? lockedByUserIds}) =
      _$_Conversation<TMember, TConversationData>;
  const _Conversation._() : super._();

  @override
  String get id;
  @override
  List<TMember> get members;
  @override
  Map<String, MemberStatus> get statuses;
  @override
  TConversationData? get data;
  @override
  Map<String, String?>? get metadata;
  @override
  Message<TMember>? get lastMessage;
  @override
  List<String>? get lockedByUserIds;
  @override
  @JsonKey(ignore: true)
  _$ConversationCopyWith<TMember, TConversationData,
          _Conversation<TMember, TConversationData>>
      get copyWith => throw _privateConstructorUsedError;
}
