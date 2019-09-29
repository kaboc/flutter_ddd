import 'package:meta/meta.dart' show required;
import 'package:flutter/material.dart';
import 'package:flutter_ddd/application/category_app_service.dart';

export 'package:flutter_ddd/application/dto/category_dto.dart';

class CategoryModel with ChangeNotifier {
  final CategoryAppService app;

  CategoryModel({@required this.app}) {
    _updateList();
  }

  List<CategoryDto> _list;

  List<CategoryDto> get list => _list == null ? null : List.unmodifiable(_list);

  Future<void> registerCategory({
    @required String name,
  }) async {
    await app.registerCategory(name: name);
    _updateList();
  }

  Future<void> updateCategory({
    @required String id,
    @required String name,
  }) async {
    await app.updateCategory(id: id, name: name);
    _updateList();
  }

  Future<void> removeCategory(String id) async {
    await app.removeCategory(id);
    _updateList();
  }

  Future<CategoryDto> getCategory(String id) async => await app.getCategory(id);

  void _updateList() {
    app.getCategoryList().then((list) {
      _list = list;
      notifyListeners();
    });
  }
}
