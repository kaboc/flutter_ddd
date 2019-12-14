import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/application/category_app_service.dart';
import 'package:flutter_ddd/infrastructure/category/category_factory.dart';
import 'package:flutter_ddd/presentation/model/category_model.dart';
import 'package:flutter_ddd/presentation/widget/category/category_list_view.dart';
import 'package:flutter_ddd/presentation/widget/category/save_button.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage();

  @override
  Widget build(BuildContext context) {
    final app = CategoryAppService(factory: const CategoryFactory());

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryModel>(
          create: (_) => CategoryModel(app: app),
        ),
        ChangeNotifierProvider<TextEditingController>(
          create: (_) => TextEditingController(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Categories')),
        body: const CategoryListView(),
        floatingActionButton: CategorySaveButton(),
      ),
    );
  }
}
