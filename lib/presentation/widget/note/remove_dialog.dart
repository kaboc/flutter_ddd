import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/common/exception.dart';
import 'package:flutter_ddd/presentation/notifier/note_notifier.dart';
import 'package:flutter_ddd/presentation/widget/error_dialog.dart';

class NoteRemoveDialog extends StatelessWidget {
  final BuildContext _context;
  final String noteId;

  const NoteRemoveDialog({
    @required BuildContext context,
    @required this.noteId,
  }) : _context = context;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Remove note'),
      content: const Text('Are you sure you want to remove this note?'),
      actions: <Widget>[
        FlatButton(
          child: const Text('CANCEL'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: const Text('REMOVE'),
          onPressed: () async {
            try {
              await _context.read<NoteNotifier>().removeNote(noteId);
              Navigator.of(context).pop();
            } on GenericException catch (e) {
              Navigator.of(context).pop();
              _showErrorDialog(e.message);
            } catch (_) {
              Navigator.of(context).pop();
              _showErrorDialog('Unknown error occurred.');
            }
          },
        ),
      ],
    );
  }

  void show() {
    showDialog<void>(
      context: _context,
      builder: build,
    );
  }

  void _showErrorDialog(String message) {
    ErrorDialog(
      context: _context,
      message: message,
    ).show();
  }
}
