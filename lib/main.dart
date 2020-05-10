import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ddd/application/category_app_service.dart';
import 'package:flutter_ddd/infrastructure/category/category_factory.dart';
import 'package:flutter_ddd/infrastructure/category/category_repository.dart';
import 'package:flutter_ddd/infrastructure/db_helper.dart';
import 'package:flutter_ddd/infrastructure/note/note_repository.dart';
import 'package:flutter_ddd/presentation/notifier/category_notifier.dart';
import 'package:flutter_ddd/presentation/page/category_list.dart';

const appTitle = 'Notes';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DbHelper>(
          create: (_) => DbHelper(),
          dispose: (_, helper) async => await helper.dispose(),
        ),
        Provider<CategoryRepositoryBase>(
          create: (context) => CategoryRepository(
            dbHelper: Provider.of<DbHelper>(context, listen: false),
          ),
        ),
        Provider<NoteRepositoryBase>(
          create: (context) => NoteRepository(
            dbHelper: Provider.of<DbHelper>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<CategoryNotifier>(
          create: (context) => CategoryNotifier(
            app: CategoryAppService(
              factory: const CategoryFactory(),
              repository:
                  Provider.of<CategoryRepositoryBase>(context, listen: false),
              noteRepository:
                  Provider.of<NoteRepositoryBase>(context, listen: false),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: appTitle,
        theme: ThemeData(primarySwatch: Colors.green),
        home: const CategoryListPage(),
      ),
    );
  }
}
