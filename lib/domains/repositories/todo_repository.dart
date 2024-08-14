import 'package:routine_todo/domains/entities/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> loadTodosByDate(DateTime date);

  void updateTodoCompleted(int id, bool completed);
}