import 'package:flutter/foundation.dart';
import 'package:flutter_ddd/application/category_app_service.dart';

export 'package:flutter_ddd/application/dto/category_dto.dart';

class CategoryNotifier with ChangeNotifier {
  final CategoryAppService _app;

  CategoryNotifier({@required CategoryAppService app}) : _app = app {
    _updateList();
  }

  List<CategoryDto> _list;

  List<CategoryDto> get list => _list == null ? null : List.unmodifiable(_list);

  Future<void> saveCategory({
    @required String name,
  }) async {
    await _app.saveCategory(name: name);
    _updateList();
  }

  Future<void> updateCategory({
    @required String id,
    @required String name,
  }) async {
    await _app.updateCategory(id: id, name: name);
    _updateList();
  }

  Future<void> removeCategory(String id) async {
    await _app.removeCategory(id);
    _updateList();
  }

  void _updateList() {
    _app.getCategoryList().then((list) {
      _list = list;
      notifyListeners();
    });
  }
}
