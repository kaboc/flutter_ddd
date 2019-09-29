import 'package:flutter_ddd/common/exception.dart';

class CategoryId {
  final String value;

  CategoryId(this.value)
      : assert(value != null),
        assert(value.isNotEmpty) {
    if (value == null || value.isEmpty) {
      throw NullEmptyException('Category ID');
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is CategoryId && other.value == value);

  @override
  int get hashCode => value.hashCode;
}
