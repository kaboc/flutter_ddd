import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/app_service/dto/category_dto.dart';
import 'package:flutter_ddd/presentation/notifier/note_notifier.dart';
import 'package:flutter_ddd/presentation/widget/note/edit_button.dart';
import 'package:flutter_ddd/presentation/widget/note/remove_button.dart';

class NoteListView extends StatelessWidget {
  final CategoryDto category;

  const NoteListView({@required this.category});

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<NoteNotifier>(context);

    if (notifier.list == null)
      return const Center(child: CircularProgressIndicator());
    else if (notifier.list.isEmpty)
      return const Center(
        child: Text(
          'No note yet',
          style: TextStyle(color: Colors.grey),
        ),
      );
    else
      return ListView.builder(
        itemCount: notifier.list.length,
        itemBuilder: (context, index) => _listTile(context, notifier.list[index]),
      );
  }

  Widget _listTile(BuildContext context, NoteSummaryDto note) {
    return Card(
      child: ListTile(
        leading: const IconTheme(
          data: IconThemeData(color: Colors.lime),
          child: Icon(Icons.description),
        ),
        title: Text(note.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            NoteEditButton(
              noteId: note.id,
              category: category,
            ),
            NoteRemoveButton(noteId: note.id),
          ],
        ),
      ),
    );
  }
}
