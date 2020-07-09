import 'package:meta/meta.dart';
import 'package:collection/collection.dart';
import 'package:flutter_ddd/application/dto/category_dto.dart';

@immutable
class CategoryState {
  final List<CategoryDto> _list;

  const CategoryState({List<CategoryDto> list}) : _list = list;

  List<CategoryDto> get list => _list == null ? null : List.unmodifiable(_list);

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is CategoryState &&
          const ListEquality<CategoryDto>().equals(other._list, _list));

  @override
  int get hashCode => runtimeType.hashCode ^ _list.hashCode;

  CategoryState copyWith({List<CategoryDto> list}) {
    return CategoryState(
      list: list ?? _list,
    );
  }
}
