import 'package:meta/meta.dart' show immutable;
import 'package:flutter_ddd/common/exception.dart';

@immutable
class CategoryName {
  final String value;

  CategoryName(this.value)
      : assert(value != null),
        assert(value.isNotEmpty) {
    if (value == null || value.isEmpty) {
      throw NullEmptyException('Category name');
    }
    if (value.length > 20) {
      throw GenericException('Name must be 20 letters or shorter.');
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is CategoryName && other.value == value);

  @override
  int get hashCode => value.hashCode;
}
