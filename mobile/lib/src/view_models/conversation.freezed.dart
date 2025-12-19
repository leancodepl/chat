// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Conversation<TMember,TConversationData> {

 String get id; List<TMember> get members; Map<String, MemberStatus> get statuses; TConversationData? get data; Map<String, String?>? get metadata; Message<TMember>? get lastMessage; List<String>? get lockedByUserIds;
/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationCopyWith<TMember, TConversationData, Conversation<TMember, TConversationData>> get copyWith => _$ConversationCopyWithImpl<TMember, TConversationData, Conversation<TMember, TConversationData>>(this as Conversation<TMember, TConversationData>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Conversation<TMember, TConversationData>&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.members, members)&&const DeepCollectionEquality().equals(other.statuses, statuses)&&const DeepCollectionEquality().equals(other.data, data)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&const DeepCollectionEquality().equals(other.lockedByUserIds, lockedByUserIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(members),const DeepCollectionEquality().hash(statuses),const DeepCollectionEquality().hash(data),const DeepCollectionEquality().hash(metadata),lastMessage,const DeepCollectionEquality().hash(lockedByUserIds));

@override
String toString() {
  return 'Conversation<$TMember, $TConversationData>(id: $id, members: $members, statuses: $statuses, data: $data, metadata: $metadata, lastMessage: $lastMessage, lockedByUserIds: $lockedByUserIds)';
}


}

/// @nodoc
abstract mixin class $ConversationCopyWith<TMember,TConversationData,$Res>  {
  factory $ConversationCopyWith(Conversation<TMember, TConversationData> value, $Res Function(Conversation<TMember, TConversationData>) _then) = _$ConversationCopyWithImpl;
@useResult
$Res call({
 String id, List<TMember> members, Map<String, MemberStatus> statuses, TConversationData? data, Map<String, String?>? metadata, Message<TMember>? lastMessage, List<String>? lockedByUserIds
});


$MessageCopyWith<TMember, $Res>? get lastMessage;

}
/// @nodoc
class _$ConversationCopyWithImpl<TMember,TConversationData,$Res>
    implements $ConversationCopyWith<TMember, TConversationData, $Res> {
  _$ConversationCopyWithImpl(this._self, this._then);

  final Conversation<TMember, TConversationData> _self;
  final $Res Function(Conversation<TMember, TConversationData>) _then;

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? members = null,Object? statuses = null,Object? data = freezed,Object? metadata = freezed,Object? lastMessage = freezed,Object? lockedByUserIds = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<TMember>,statuses: null == statuses ? _self.statuses : statuses // ignore: cast_nullable_to_non_nullable
as Map<String, MemberStatus>,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as TConversationData?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, String?>?,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as Message<TMember>?,lockedByUserIds: freezed == lockedByUserIds ? _self.lockedByUserIds : lockedByUserIds // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}
/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageCopyWith<TMember, $Res>? get lastMessage {
    if (_self.lastMessage == null) {
    return null;
  }

  return $MessageCopyWith<TMember, $Res>(_self.lastMessage!, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}
}


/// Adds pattern-matching-related methods to [Conversation].
extension ConversationPatterns<TMember,TConversationData> on Conversation<TMember, TConversationData> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Conversation<TMember, TConversationData> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Conversation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Conversation<TMember, TConversationData> value)  $default,){
final _that = this;
switch (_that) {
case _Conversation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Conversation<TMember, TConversationData> value)?  $default,){
final _that = this;
switch (_that) {
case _Conversation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  List<TMember> members,  Map<String, MemberStatus> statuses,  TConversationData? data,  Map<String, String?>? metadata,  Message<TMember>? lastMessage,  List<String>? lockedByUserIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Conversation() when $default != null:
return $default(_that.id,_that.members,_that.statuses,_that.data,_that.metadata,_that.lastMessage,_that.lockedByUserIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  List<TMember> members,  Map<String, MemberStatus> statuses,  TConversationData? data,  Map<String, String?>? metadata,  Message<TMember>? lastMessage,  List<String>? lockedByUserIds)  $default,) {final _that = this;
switch (_that) {
case _Conversation():
return $default(_that.id,_that.members,_that.statuses,_that.data,_that.metadata,_that.lastMessage,_that.lockedByUserIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  List<TMember> members,  Map<String, MemberStatus> statuses,  TConversationData? data,  Map<String, String?>? metadata,  Message<TMember>? lastMessage,  List<String>? lockedByUserIds)?  $default,) {final _that = this;
switch (_that) {
case _Conversation() when $default != null:
return $default(_that.id,_that.members,_that.statuses,_that.data,_that.metadata,_that.lastMessage,_that.lockedByUserIds);case _:
  return null;

}
}

}

/// @nodoc


class _Conversation<TMember,TConversationData> extends Conversation<TMember, TConversationData> {
  const _Conversation({required this.id, required final  List<TMember> members, required final  Map<String, MemberStatus> statuses, required this.data, required final  Map<String, String?>? metadata, required this.lastMessage, required final  List<String>? lockedByUserIds}): _members = members,_statuses = statuses,_metadata = metadata,_lockedByUserIds = lockedByUserIds,super._();
  

@override final  String id;
 final  List<TMember> _members;
@override List<TMember> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

 final  Map<String, MemberStatus> _statuses;
@override Map<String, MemberStatus> get statuses {
  if (_statuses is EqualUnmodifiableMapView) return _statuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_statuses);
}

@override final  TConversationData? data;
 final  Map<String, String?>? _metadata;
@override Map<String, String?>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  Message<TMember>? lastMessage;
 final  List<String>? _lockedByUserIds;
@override List<String>? get lockedByUserIds {
  final value = _lockedByUserIds;
  if (value == null) return null;
  if (_lockedByUserIds is EqualUnmodifiableListView) return _lockedByUserIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationCopyWith<TMember, TConversationData, _Conversation<TMember, TConversationData>> get copyWith => __$ConversationCopyWithImpl<TMember, TConversationData, _Conversation<TMember, TConversationData>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Conversation<TMember, TConversationData>&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._members, _members)&&const DeepCollectionEquality().equals(other._statuses, _statuses)&&const DeepCollectionEquality().equals(other.data, data)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&const DeepCollectionEquality().equals(other._lockedByUserIds, _lockedByUserIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_members),const DeepCollectionEquality().hash(_statuses),const DeepCollectionEquality().hash(data),const DeepCollectionEquality().hash(_metadata),lastMessage,const DeepCollectionEquality().hash(_lockedByUserIds));

@override
String toString() {
  return 'Conversation<$TMember, $TConversationData>(id: $id, members: $members, statuses: $statuses, data: $data, metadata: $metadata, lastMessage: $lastMessage, lockedByUserIds: $lockedByUserIds)';
}


}

/// @nodoc
abstract mixin class _$ConversationCopyWith<TMember,TConversationData,$Res> implements $ConversationCopyWith<TMember, TConversationData, $Res> {
  factory _$ConversationCopyWith(_Conversation<TMember, TConversationData> value, $Res Function(_Conversation<TMember, TConversationData>) _then) = __$ConversationCopyWithImpl;
@override @useResult
$Res call({
 String id, List<TMember> members, Map<String, MemberStatus> statuses, TConversationData? data, Map<String, String?>? metadata, Message<TMember>? lastMessage, List<String>? lockedByUserIds
});


@override $MessageCopyWith<TMember, $Res>? get lastMessage;

}
/// @nodoc
class __$ConversationCopyWithImpl<TMember,TConversationData,$Res>
    implements _$ConversationCopyWith<TMember, TConversationData, $Res> {
  __$ConversationCopyWithImpl(this._self, this._then);

  final _Conversation<TMember, TConversationData> _self;
  final $Res Function(_Conversation<TMember, TConversationData>) _then;

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? members = null,Object? statuses = null,Object? data = freezed,Object? metadata = freezed,Object? lastMessage = freezed,Object? lockedByUserIds = freezed,}) {
  return _then(_Conversation<TMember, TConversationData>(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<TMember>,statuses: null == statuses ? _self._statuses : statuses // ignore: cast_nullable_to_non_nullable
as Map<String, MemberStatus>,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as TConversationData?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, String?>?,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as Message<TMember>?,lockedByUserIds: freezed == lockedByUserIds ? _self._lockedByUserIds : lockedByUserIds // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageCopyWith<TMember, $Res>? get lastMessage {
    if (_self.lastMessage == null) {
    return null;
  }

  return $MessageCopyWith<TMember, $Res>(_self.lastMessage!, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}
}

// dart format on
