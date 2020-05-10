import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/presentation/notifier/note_notifier.dart';
import 'package:flutter_ddd/presentation/widget/note/edit_dialog.dart';

class NoteEditButton extends StatelessWidget {
  final CategoryDto category;
  final String noteId;

  const NoteEditButton({
    @required this.category,
    @required this.noteId,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () async {
        final notifier = context.read<NoteNotifier>();
        final note = await notifier.getNote(noteId);

        NoteEditDialog(
          context: context,
          heading: 'Edit note',
          buttonLabel: 'SAVE',
          category: category,
          onSave: ({title, body, categoryId}) async {
            await notifier.updateNote(
              id: noteId,
              title: title,
              body: body,
              categoryId: categoryId,
            );
          },
          initialTitle: note.title,
          initialBody: note.body,
        ).show();
      },
    );
  }
}
