import 'package:meta/meta.dart' show required;
import 'package:get_it/get_it.dart';
import 'package:flutter_ddd/common/exception.dart';
import 'package:flutter_ddd/domain/category/category_factory_base.dart';
import 'package:flutter_ddd/domain/category/category_repository_base.dart';
import 'package:flutter_ddd/domain/category/category_service.dart';
import 'package:flutter_ddd/domain/note/note_repository_base.dart';
import 'package:flutter_ddd/application/dto/category_dto.dart';

export 'package:flutter_ddd/application/dto/category_dto.dart';

class CategoryAppService {
  final CategoryFactoryBase _factory;
  final _service = CategoryService();
  final _repository = GetIt.instance<CategoryRepositoryBase>();
  final _noteRepository = GetIt.instance<NoteRepositoryBase>();

  CategoryAppService({@required CategoryFactoryBase factory})
      : _factory = factory;

  Future<void> registerCategory({@required String name}) async {
    final category = _factory.create(name: name);

    if (await _service.isDuplicated(category.name)) {
      throw NotUniqueException('Category name: ${category.name.value}');
    } else {
      await _repository.save(category);
    }
  }

  Future<void> updateCategory({
    @required String id,
    @required String name,
  }) async {
    final targetId = CategoryId(id);
    final target = await _repository.find(targetId);

    if (target == null) {
      throw NotFoundException('ID: $targetId');
    }

    final newName = CategoryName(name);
    if (newName != target.name && await _service.isDuplicated(newName)) {
      throw NotUniqueException('Category name: ${newName.value}');
    }
    target.changeName(newName);

    await _repository.save(target);
  }

  Future<void> removeCategory(String id) async {
    final targetId = CategoryId(id);
    final target = await _repository.find(targetId);

    if (target == null) {
      throw NotFoundException('ID: $targetId');
    }

    if (await _noteRepository.countByCategory(targetId) > 0) {
      throw GenericException(
          'Cannot be removed;\nthis category contains notes.');
    }

    await _repository.remove(target);
  }

  Future<List<CategoryDto>> getCategoryList() async {
    final categories = await _repository.findAll();
    return categories.map((x) => CategoryDto(x)).toList();
  }
}
