import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/presentation/model/note_model.dart';
import 'package:flutter_ddd/presentation/widget/note/edit_dialog.dart';

class NoteUpdateButton extends StatelessWidget {
  final CategoryDto category;
  final String noteId;

  const NoteUpdateButton({
    @required this.category,
    @required this.noteId,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () async {
        final model = Provider.of<NoteModel>(context, listen: false);
        final note = await model.getNote(noteId);

        NoteEditDialog(
          context: context,
          heading: 'Edit note',
          buttonLabel: 'SAVE',
          category: category,
          onSave: ({title, body, categoryId}) async {
            await model.updateNote(
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
