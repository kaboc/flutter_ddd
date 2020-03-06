import 'package:meta/meta.dart';
import 'package:flutter_ddd/common/exception.dart';

@immutable
class CategoryId {
  final String value;

  CategoryId(this.value) {
    if (value == null || value.isEmpty) {
      throw NullEmptyException(code: ExceptionCode.categoryId);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is CategoryId && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
