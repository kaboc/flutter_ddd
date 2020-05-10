import 'package:meta/meta.dart';
import 'package:flutter_ddd/domain/note/note_repository_base.dart';

class NoteService {
  final NoteRepositoryBase _repository;

  const NoteService({@required NoteRepositoryBase repository})
      : _repository = repository;

  Future<bool> isDuplicated(NoteTitle title) async {
    final searched = await _repository.findByTitle(title);
    return searched != null;
  }
}
