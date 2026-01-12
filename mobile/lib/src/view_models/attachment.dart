import 'package:freezed_annotation/freezed_annotation.dart';

part 'attachment.freezed.dart';

@freezed
abstract class Attachment with _$Attachment {
  const factory Attachment({
    required Uri uri,
    required String mimeType,
    required String fileName,
  }) = _Attachment;
}
