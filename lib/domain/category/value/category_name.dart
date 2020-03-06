import 'package:meta/meta.dart';
import 'package:flutter_ddd/common/exception.dart';

@immutable
class CategoryName {
  final String value;

  CategoryName(this.value) {
    if (value == null || value.isEmpty) {
      throw NullEmptyException(code: ExceptionCode.categoryName);
    }
    if (value.length > 20) {
      throw LengthException(code: ExceptionCode.categoryName, max: 20);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is CategoryName && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
