import 'package:meta/meta.dart';
import 'package:flutter_ddd/common/exception.dart';
import 'package:flutter_ddd/domain/category/category_factory_base.dart';
import 'package:flutter_ddd/domain/category/category_repository_base.dart';
import 'package:flutter_ddd/domain/category/category_service.dart';
import 'package:flutter_ddd/domain/note/note_repository_base.dart';
import 'package:flutter_ddd/application/dto/category_dto.dart';

export 'package:flutter_ddd/application/dto/category_dto.dart';

@immutable
class CategoryAppService {
  final CategoryFactoryBase _factory;
  final CategoryRepositoryBase _repository;
  final NoteRepositoryBase _noteRepository;
  final CategoryService _service;

  CategoryAppService({
    @required CategoryFactoryBase factory,
    @required CategoryRepositoryBase repository,
    @required NoteRepositoryBase noteRepository,
  })  : _factory = factory,
        _repository = repository,
        _noteRepository = noteRepository,
        _service = CategoryService(repository: repository);

  Future<void> saveCategory({@required String name}) async {
    final category = _factory.create(name: name);

    await _repository.transaction<void>(() async {
      if (await _service.isDuplicated(category.name)) {
        throw NotUniqueException(
          code: ExceptionCode.categoryName,
          value: category.name.value,
        );
      } else {
        await _repository.save(category);
      }
    });
  }

  Future<void> updateCategory({
    @required String id,
    @required String name,
  }) async {
    final targetId = CategoryId(id);

    await _repository.transaction<void>(() async {
      final target = await _repository.find(targetId);
      if (target == null) {
        throw NotFoundException(
          code: ExceptionCode.categoryId,
          target: targetId.value,
        );
      }

      final newName = CategoryName(name);
      if (newName != target.name && await _service.isDuplicated(newName)) {
        throw NotUniqueException(
          code: ExceptionCode.categoryName,
          value: newName.value,
        );
      }
      target.changeName(newName);

      await _repository.save(target);
    });
  }

  Future<void> removeCategory(String id) async {
    final targetId = CategoryId(id);

    await _repository.transaction<void>(() async {
      final target = await _repository.find(targetId);
      if (target == null) {
        throw NotFoundException(
          code: ExceptionCode.categoryId,
          target: targetId.value,
        );
      }

      if (await _noteRepository.countByCategory(targetId) > 0) {
        throw RemovalException(code: ExceptionCode.category);
      }

      await _repository.remove(target);
    });
  }

  Future<List<CategoryDto>> getCategoryList() async {
    final categories = await _repository.findAll();
    return categories.map((x) => CategoryDto(x)).toList();
  }
}
