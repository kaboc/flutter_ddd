import 'package:meta/meta.dart' show required;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/presentation/model/note_model.dart';
import 'package:flutter_ddd/presentation/widget/note/edit_dialog.dart';

class NoteRegisterButton extends StatelessWidget {
  final CategoryDto category;

  const NoteRegisterButton({@required this.category});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () => EditDialog(
        context: context,
        heading: 'New note',
        buttonLabel: 'REGISTER',
        category: category,
        onSave: ({title, body, categoryId}) async {
          final model = Provider.of<NoteModel>(context, listen: false);
          await model.registerNote(
            title: title,
            body: body,
            categoryId: category.id,
          );
        },
      ),
    );
  }
}
