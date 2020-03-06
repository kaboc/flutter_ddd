import 'package:meta/meta.dart';
import 'package:flutter_ddd/common/exception.dart';

@immutable
class NoteTitle {
  final String value;

  NoteTitle(this.value) {
    if (value == null || value.isEmpty) {
      throw NullEmptyException(code: ExceptionCode.noteTitle);
    }
    if (value.length > 50) {
      throw LengthException(code: ExceptionCode.noteTitle, max: 50);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is NoteTitle && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
