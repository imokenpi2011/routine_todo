import 'package:flutter/material.dart';
import 'package:routine_todo/domains/entities/todo.dart';
import 'package:routine_todo/domains/repositories/todo_repository.dart';

class DailyTodosEditViewModel extends ChangeNotifier {
  final TodoRepository _todoRepository;

  DailyTodosEditViewModel(id, this._todoRepository) {
    // idがnull = 新規作成の場合
    if (id == null) {
      initTodo();
      _isNew = true;
      return;
    }

    // idが存在 = 編集の場合はtodo情報を取得
    fetchTodo(id);
  }

  late int? _id;

  int? get id => _id;

  late String _todoName;

  String get todoName => _todoName;

  set todoName(String value) {
    _todoName = value;
    notifyListeners();
  }

  late TimeOfDay? _startedTime;

  TimeOfDay? get startedTime => _startedTime;

  set startedTime(TimeOfDay? value) {
    _startedTime = value;
    notifyListeners();
  }

  late TimeOfDay? _endedTime;

  TimeOfDay? get endedTime => _endedTime;

  set endedTime(TimeOfDay? value) {
    _endedTime = value;
    notifyListeners();
  }

  late bool _isNew = false; // 新規作成かどうか

  bool get isNew => _isNew;

  void initTodo() {
    _id = null;
    _todoName = '';
    _startedTime = null;
    _endedTime = null;
    notifyListeners();
  }

  void fetchTodo(int id) async {
    final todo = await _todoRepository.loadTodoById(id);
    // TODO: nullの場合はエラーを返却するようにする
    if (todo == null) {
      initTodo();
      return;
    }

    _id = todo.id;
    _todoName = todo.todoName;
    _startedTime = todo.startedTime;
    _endedTime = todo.endedTime;
    notifyListeners();
  }

  Future save() async => await _todoRepository.create(
        _todoName,
        DateTime.now(),
        _startedTime,
        _endedTime,
        DateTime.now(),
      );

  Future update() async => await _todoRepository.update(
        _id!,
        _todoName,
        _startedTime,
        _endedTime,
        DateTime.now(),
      );
}
