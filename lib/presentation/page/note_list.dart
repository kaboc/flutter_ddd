import 'package:flutter/material.dart';
import 'package:flutter_ddd/presentation/widget/note/edit_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/application/note_app_service.dart';
import 'package:flutter_ddd/application/dto/category_dto.dart';
import 'package:flutter_ddd/infrastructure/note/note_factory.dart';
import 'package:flutter_ddd/presentation/model/note_model.dart';
import 'package:flutter_ddd/presentation/widget/note/note_list_view.dart';
import 'package:flutter_ddd/presentation/widget/note/save_button.dart';

class NoteListPage extends StatelessWidget {
  final CategoryDto category;

  const NoteListPage({@required this.category});

  @override
  Widget build(BuildContext context) {
    final app = NoteAppService(factory: const NoteFactory());

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NoteModel>(
          builder: (_) => NoteModel(app: app, categoryId: category.id),
        ),
        ChangeNotifierProvider<TitleEditingController>(
          builder: (_) => TitleEditingController(),
        ),
        ChangeNotifierProvider<BodyEditingController>(
          builder: (_) => BodyEditingController(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(category.name)),
        body: NoteListView(category: category),
        floatingActionButton: NoteSaveButton(category: category),
      ),
    );
  }
}
