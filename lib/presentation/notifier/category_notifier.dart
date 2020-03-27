import 'package:flutter/foundation.dart';
import 'package:flutter_ddd/app_service/category_app_service.dart';

export 'package:flutter_ddd/app_service/dto/category_dto.dart';

class CategoryNotifier with ChangeNotifier {
  final CategoryAppService _service;

  CategoryNotifier({@required CategoryAppService service}) : _service = service {
    _updateList();
  }

  List<CategoryDto> _list;

  List<CategoryDto> get list => _list == null ? null : List.unmodifiable(_list);

  Future<void> saveCategory({
    @required String name,
  }) async {
    await _service.saveCategory(name: name);
    _updateList();
  }

  Future<void> updateCategory({
    @required String id,
    @required String name,
  }) async {
    await _service.updateCategory(id: id, name: name);
    _updateList();
  }

  Future<void> removeCategory(String id) async {
    await _service.removeCategory(id);
    _updateList();
  }

  void _updateList() {
    _service.getCategoryList().then((list) {
      _list = list;
      notifyListeners();
    });
  }
}
