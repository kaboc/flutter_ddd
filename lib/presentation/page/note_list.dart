import 'package:flutter/material.dart';
import 'package:flutter_ddd/presentation/widget/note/edit_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/application/note_app_service.dart';
import 'package:flutter_ddd/application/dto/category_dto.dart';
import 'package:flutter_ddd/infrastracture/note/note_factory.dart';
import 'package:flutter_ddd/infrastracture/note/note_repository.dart';
import 'package:flutter_ddd/presentation/model/note_model.dart';
import 'package:flutter_ddd/presentation/widget/note/register_button.dart';
import 'package:flutter_ddd/presentation/widget/note/note_list_view.dart';

class NoteListPage extends StatelessWidget {
  const NoteListPage();

  @override
  Widget build(BuildContext context) {
    final dbHelper = Provider.of<DbHelper>(context);
    final category = Provider.of<CategoryDto>(context);

    final app = NoteAppService(
      factory: NoteFactory(),
      repository: NoteRepository(dbHelper),
    );

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
        body: const NoteListView(),
        floatingActionButton: NoteRegisterButton(category: category),
      ),
    );
  }
}
