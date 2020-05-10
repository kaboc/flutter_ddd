import 'package:meta/meta.dart';
import 'package:flutter_ddd/domain/category/category_repository_base.dart';

class CategoryService {
  final CategoryRepositoryBase _repository;

  const CategoryService({@required CategoryRepositoryBase repository})
      : _repository = repository;

  Future<bool> isDuplicated(CategoryName name) async {
    final searched = await _repository.findByName(name);
    return searched != null;
  }
}
