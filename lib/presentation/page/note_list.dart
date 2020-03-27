import 'package:flutter/material.dart';
import 'package:flutter_ddd/presentation/widget/note/edit_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/app_service/note_app_service.dart';
import 'package:flutter_ddd/app_service/dto/category_dto.dart';
import 'package:flutter_ddd/infrastructure/note/note_factory.dart';
import 'package:flutter_ddd/presentation/notifier/note_notifier.dart';
import 'package:flutter_ddd/presentation/widget/note/add_button.dart';
import 'package:flutter_ddd/presentation/widget/note/note_list_view.dart';

class NoteListPage extends StatelessWidget {
  final CategoryDto category;

  const NoteListPage({@required this.category});

  @override
  Widget build(BuildContext context) {
    final service = NoteAppService(factory: const NoteFactory());

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NoteNotifier>(
          create: (_) => NoteNotifier(service: service, categoryId: category.id),
        ),
        ChangeNotifierProvider<TitleEditingController>(
          create: (_) => TitleEditingController(),
        ),
        ChangeNotifierProvider<BodyEditingController>(
          create: (_) => BodyEditingController(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(category.name)),
        body: NoteListView(category: category),
        floatingActionButton: NoteAddButton(category: category),
      ),
    );
  }
}
