import 'package:flutter/cupertino.dart';
import '../../../domains/entities/todo.dart';
import '../../../domains/repositories/todo_repository.dart';
import 'todo_view_model.dart';

class DailyTodosViewModel extends ChangeNotifier {
  final TodoRepository _todoRepository;

  DailyTodosViewModel(this._todoRepository) {
    fetchTodos();
  }

  List<TodoViewModel> _todos = [];
  List<TodoViewModel> get todos => _todos;

  final DateTime _date = DateTime.now();

  /// todoの一覧を取得する
  void fetchTodos() async {
    final todos = await _todoRepository.loadTodosByDate(_date);
    _todos = todos.map((todo) => TodoViewModel(todo)).toList();
    notifyListeners();
  }

  void addTodo(Todo todo) {
    _todos.add(TodoViewModel(todo));
    notifyListeners();
  }

  void removeTodoById(int id) {
    _todos.removeWhere((todoVm) => todoVm.todo.id == id);
    notifyListeners();
  }

  void updateTodoById(int id, Todo updatedTodo) {
    final index = _todos.indexWhere((todoVm) => todoVm.todo.id == id);
    if (index != -1) {
      _todos[index].update(updatedTodo);
      notifyListeners();
    }
  }

  /// todoの完了状態を更新する
  void updateTodoCompleted(int id, bool completed) async {
    await _todoRepository.updateTodoCompleted(id, completed);
    fetchTodos();
  }
}
