import 'package:meta/meta.dart';
import 'package:flutter_ddd/common/exception.dart';

@immutable
class NoteBody {
  final String value;

  NoteBody(this.value) {
    if (value == null || value.isEmpty) {
      throw NullEmptyException(code: ExceptionCode.note);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is NoteBody && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
