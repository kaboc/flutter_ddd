import 'package:flutter_ddd/common/exception.dart';

class NoteBody {
  final String value;

  NoteBody(this.value)
      : assert(value != null),
        assert(value.isNotEmpty) {
    if (value == null || value.isEmpty) {
      throw NullEmptyException('Note');
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is NoteBody && other.value == value);

  @override
  int get hashCode => value.hashCode;
}
