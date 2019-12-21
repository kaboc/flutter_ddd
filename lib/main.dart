import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/infrastructure/category/category_repository.dart';
import 'package:flutter_ddd/infrastructure/db_helper.dart';
import 'package:flutter_ddd/infrastructure/note/note_repository.dart';
import 'package:flutter_ddd/presentation/page/category_list.dart';

const appTitle = 'Notes';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Provider<DbHelper>(
        create: (_) {
          final helper = DbHelper();

          final getIt = GetIt.instance;
          getIt.registerSingleton<CategoryRepositoryBase>(
            CategoryRepository(dbHelper: helper),
          );
          getIt.registerSingleton<NoteRepositoryBase>(
            NoteRepository(dbHelper: helper),
          );

          return helper;
        },
        dispose: (_, helper) async => await helper.dispose(),
        child: const CategoryListPage(),
      ),
    );
  }
}
