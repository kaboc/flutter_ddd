import 'package:meta/meta.dart' show required;
import 'package:flutter_ddd/common/exception.dart';
import 'package:flutter_ddd/domain/note/note_factory_base.dart';
import 'package:flutter_ddd/domain/note/note_service.dart';
import 'package:flutter_ddd/application/dto/note_dto.dart';
import 'package:flutter_ddd/application/dto/note_summary_dto.dart';
import 'package:flutter_ddd/domain/note/note_repository_base.dart';

export 'package:flutter_ddd/application/dto/note_dto.dart';
export 'package:flutter_ddd/application/dto/note_summary_dto.dart';

class NoteAppService {
  final NoteFactoryBase _factory;
  final NoteRepositoryBase _repository;
  final NoteService _service;

  NoteAppService({
    @required NoteFactoryBase factory,
    @required NoteRepositoryBase repository,
  })  : _factory = factory,
        _repository = repository,
        _service = NoteService(repository: repository);

  Future<void> registerNote({
    @required String title,
    @required String body,
    @required String categoryId,
  }) async {
    final note = _factory.create(
      title: NoteTitle(title),
      body: NoteBody(body),
      categoryId: CategoryId(categoryId),
    );

    if (await _service.isDuplicated(note.title)) {
      throw NotUniqueException('Note title: ${note.title.value}');
    } else {
      await _repository.save(note);
    }
  }

  Future<void> updateNote({
    @required String id,
    @required String title,
    @required String body,
    @required String categoryId,
  }) async {
    final targetId = NoteId(id);
    final target = await _repository.find(targetId);

    if (target == null) {
      throw NotFoundException('ID: $targetId');
    }

    final newTitle = NoteTitle(title);
    if (newTitle != target.title && await _service.isDuplicated(newTitle)) {
      throw NotUniqueException('Note title: ${newTitle.value}');
    }
    target.changeTitle(newTitle);

    final newBody = NoteBody(body);
    target.changeBody(newBody);

    final newCategoryId = CategoryId(categoryId);
    target.changeCategory(newCategoryId);

    await _repository.save(target);
  }

  Future<void> removeNote(String id) async {
    final targetId = NoteId(id);
    final target = await _repository.find(targetId);

    if (target == null) {
      throw NotFoundException('ID: $targetId');
    }

    await _repository.remove(target);
  }

  Future<NoteDto> getNote(String id) async {
    final targetId = NoteId(id);
    final target = await _repository.find(targetId);

    return target == null ? null : NoteDto(target);
  }

  Future<List<NoteSummaryDto>> getNoteList(String categoryId) async {
    final targetId = CategoryId(categoryId);
    final notes = await _repository.findByCategory(targetId);
    return notes.map((x) => NoteSummaryDto(x)).toList();
  }
}
