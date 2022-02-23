import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_status.freezed.dart';

@freezed
class MemberStatus with _$MemberStatus {
  const factory MemberStatus({
    required String? lastSeenMessageId,
    required DateTime? lastSeenMessageDate,
  }) = _MemberStatus;
}
