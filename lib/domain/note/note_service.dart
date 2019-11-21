import 'package:get_it/get_it.dart';
import 'package:flutter_ddd/domain/note/note_repository_base.dart';

class NoteService {
  final _repository = GetIt.instance<NoteRepositoryBase>();

  Future<bool> isDuplicated(NoteTitle title) async {
    final searched = await _repository.findByTitle(title);
    return searched != null;
  }
}
