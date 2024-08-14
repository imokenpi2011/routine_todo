import 'package:flutter/cupertino.dart';
import '../../../domains/entities/todo.dart';

class TodoViewModel extends ChangeNotifier {
  Todo _todo;

  TodoViewModel(this._todo);

  Todo get todo => _todo;

  void update(Todo newTodo) {
    _todo = newTodo;
    notifyListeners();
  }
}
