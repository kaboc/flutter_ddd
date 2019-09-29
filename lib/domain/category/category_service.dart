import 'package:meta/meta.dart' show required;
import 'package:flutter_ddd/domain/category/category_repository_base.dart';

class CategoryService {
  final CategoryRepositoryBase repository;

  CategoryService({@required this.repository}) : assert(repository != null);

  Future<bool> isDuplicated(CategoryName name) async {
    final searched = await repository.findByName(name);
    return searched != null;
  }
}
