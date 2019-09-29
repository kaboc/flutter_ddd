import 'package:meta/meta.dart' show required;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/presentation/widget/error_dialog.dart';

typedef SaveCallback = Future<void> Function({@required String name});

class EditDialog {
  final BuildContext context;
  final String heading;
  final String buttonLabel;
  final SaveCallback onSave;
  final String initialName;
  final TextEditingController _nameController;

  EditDialog({
    @required this.context,
    @required this.heading,
    @required this.buttonLabel,
    @required this.onSave,
    this.initialName,
  }) : _nameController =
            Provider.of<TextEditingController>(context, listen: false)
              ..text = initialName ?? '' {
    _showDialog();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(heading),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter category name',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () => Navigator.pop(dialogContext),
            ),
            FlatButton(
              child: Text(buttonLabel),
              onPressed: () async {
                try {
                  await onSave(name: _nameController.text);
                  Navigator.pop(dialogContext);
                } catch (e) {
                  Navigator.pop(dialogContext);
                  ErrorDialog.show(
                    context: context,
                    message: e.toString(),
                    onOk: _showDialog,
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
