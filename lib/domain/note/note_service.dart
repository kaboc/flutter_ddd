import 'package:meta/meta.dart' show required;
import 'package:flutter_ddd/domain/note/note_repository_base.dart';

class NoteService {
  final NoteRepositoryBase repository;

  NoteService({@required this.repository}) : assert(repository != null);

  Future<bool> isDuplicated(NoteTitle title) async {
    final searched = await repository.findByTitle(title);
    return searched != null;
  }
}
