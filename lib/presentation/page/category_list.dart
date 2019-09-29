import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/application/category_app_service.dart';
import 'package:flutter_ddd/infrastracture/category/category_factory.dart';
import 'package:flutter_ddd/infrastracture/category/category_repository.dart';
import 'package:flutter_ddd/infrastracture/note/note_repository.dart';
import 'package:flutter_ddd/presentation/model/category_model.dart';
import 'package:flutter_ddd/presentation/widget/category/category_list_view.dart';
import 'package:flutter_ddd/presentation/widget/category/register_button.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage();

  @override
  Widget build(BuildContext context) {
    final dbHelper = Provider.of<DbHelper>(context);
    final app = CategoryAppService(
      factory: CategoryFactory(),
      repository: CategoryRepository(dbHelper),
      noteRepository: NoteRepository(dbHelper),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryModel>(
          builder: (_) => CategoryModel(app: app),
        ),
        ChangeNotifierProvider<TextEditingController>(
          builder: (_) => TextEditingController(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Categories')),
        body: const CategoryListView(),
        floatingActionButton: CategoryRegisterButton(),
      ),
    );
  }
}
