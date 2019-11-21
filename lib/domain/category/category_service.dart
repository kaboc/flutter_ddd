import 'package:get_it/get_it.dart';
import 'package:flutter_ddd/domain/category/category_repository_base.dart';

class CategoryService {
  final _repository = GetIt.instance<CategoryRepositoryBase>();

  Future<bool> isDuplicated(CategoryName name) async {
    final searched = await _repository.findByName(name);
    return searched != null;
  }
}
