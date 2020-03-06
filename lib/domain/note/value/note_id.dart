import 'package:meta/meta.dart';
import 'package:flutter_ddd/common/exception.dart';

@immutable
class NoteId {
  final String value;

  NoteId(this.value) {
    if (value == null || value.isEmpty) {
      throw NullEmptyException(code: ExceptionCode.noteId);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is NoteId && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
