import 'package:meta/meta.dart' show required;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/presentation/model/note_model.dart';
import 'package:flutter_ddd/presentation/widget/error_dialog.dart';

class NoteRemoveButton extends StatelessWidget {
  final String noteId;

  const NoteRemoveButton({@required this.noteId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () => _dialog(context),
    );
  }

  Future<void> _dialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Remove note'),
          content: const Text('Are you sure you want to remove this note?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () => Navigator.pop(dialogContext),
            ),
            FlatButton(
              child: const Text('REMOVE'),
              onPressed: () async {
                try {
                  final model = Provider.of<NoteModel>(context, listen: false);
                  await model.removeNote(noteId);
                  Navigator.pop(dialogContext);
                } catch (e) {
                  Navigator.pop(dialogContext);
                  ErrorDialog.show(
                    context: context,
                    message: e.toString(),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
