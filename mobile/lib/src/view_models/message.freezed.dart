// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Message<TChatMember> {

 String get id; String get content; DateTime get dateSent; TChatMember get sender; MessageUserType get userType;
/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageCopyWith<TChatMember, Message<TChatMember>> get copyWith => _$MessageCopyWithImpl<TChatMember, Message<TChatMember>>(this as Message<TChatMember>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Message<TChatMember>&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.dateSent, dateSent) || other.dateSent == dateSent)&&const DeepCollectionEquality().equals(other.sender, sender)&&(identical(other.userType, userType) || other.userType == userType));
}


@override
int get hashCode => Object.hash(runtimeType,id,content,dateSent,const DeepCollectionEquality().hash(sender),userType);

@override
String toString() {
  return 'Message<$TChatMember>(id: $id, content: $content, dateSent: $dateSent, sender: $sender, userType: $userType)';
}


}

/// @nodoc
abstract mixin class $MessageCopyWith<TChatMember,$Res>  {
  factory $MessageCopyWith(Message<TChatMember> value, $Res Function(Message<TChatMember>) _then) = _$MessageCopyWithImpl;
@useResult
$Res call({
 String id, String content, DateTime dateSent, TChatMember sender, MessageUserType userType
});




}
/// @nodoc
class _$MessageCopyWithImpl<TChatMember,$Res>
    implements $MessageCopyWith<TChatMember, $Res> {
  _$MessageCopyWithImpl(this._self, this._then);

  final Message<TChatMember> _self;
  final $Res Function(Message<TChatMember>) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? content = null,Object? dateSent = null,Object? sender = freezed,Object? userType = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,dateSent: null == dateSent ? _self.dateSent : dateSent // ignore: cast_nullable_to_non_nullable
as DateTime,sender: freezed == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as TChatMember,userType: null == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as MessageUserType,
  ));
}

}


/// Adds pattern-matching-related methods to [Message].
extension MessagePatterns<TChatMember> on Message<TChatMember> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Message<TChatMember> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Message() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Message<TChatMember> value)  $default,){
final _that = this;
switch (_that) {
case _Message():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Message<TChatMember> value)?  $default,){
final _that = this;
switch (_that) {
case _Message() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String content,  DateTime dateSent,  TChatMember sender,  MessageUserType userType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Message() when $default != null:
return $default(_that.id,_that.content,_that.dateSent,_that.sender,_that.userType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String content,  DateTime dateSent,  TChatMember sender,  MessageUserType userType)  $default,) {final _that = this;
switch (_that) {
case _Message():
return $default(_that.id,_that.content,_that.dateSent,_that.sender,_that.userType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String content,  DateTime dateSent,  TChatMember sender,  MessageUserType userType)?  $default,) {final _that = this;
switch (_that) {
case _Message() when $default != null:
return $default(_that.id,_that.content,_that.dateSent,_that.sender,_that.userType);case _:
  return null;

}
}

}

/// @nodoc


class _Message<TChatMember> implements Message<TChatMember> {
  const _Message({required this.id, required this.content, required this.dateSent, required this.sender, required this.userType});
  

@override final  String id;
@override final  String content;
@override final  DateTime dateSent;
@override final  TChatMember sender;
@override final  MessageUserType userType;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageCopyWith<TChatMember, _Message<TChatMember>> get copyWith => __$MessageCopyWithImpl<TChatMember, _Message<TChatMember>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Message<TChatMember>&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.dateSent, dateSent) || other.dateSent == dateSent)&&const DeepCollectionEquality().equals(other.sender, sender)&&(identical(other.userType, userType) || other.userType == userType));
}


@override
int get hashCode => Object.hash(runtimeType,id,content,dateSent,const DeepCollectionEquality().hash(sender),userType);

@override
String toString() {
  return 'Message<$TChatMember>(id: $id, content: $content, dateSent: $dateSent, sender: $sender, userType: $userType)';
}


}

/// @nodoc
abstract mixin class _$MessageCopyWith<TChatMember,$Res> implements $MessageCopyWith<TChatMember, $Res> {
  factory _$MessageCopyWith(_Message<TChatMember> value, $Res Function(_Message<TChatMember>) _then) = __$MessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String content, DateTime dateSent, TChatMember sender, MessageUserType userType
});




}
/// @nodoc
class __$MessageCopyWithImpl<TChatMember,$Res>
    implements _$MessageCopyWith<TChatMember, $Res> {
  __$MessageCopyWithImpl(this._self, this._then);

  final _Message<TChatMember> _self;
  final $Res Function(_Message<TChatMember>) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? content = null,Object? dateSent = null,Object? sender = freezed,Object? userType = null,}) {
  return _then(_Message<TChatMember>(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,dateSent: null == dateSent ? _self.dateSent : dateSent // ignore: cast_nullable_to_non_nullable
as DateTime,sender: freezed == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as TChatMember,userType: null == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as MessageUserType,
  ));
}


}

// dart format on
