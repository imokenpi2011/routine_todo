import 'package:flutter/material.dart';
import 'package:routine_todo/domains/entities/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> loadTodosByDate(DateTime date);

  Future<Todo?> loadTodoById(int id);

  Future<void> updateTodoCompleted(int id, bool completed);

  Future<void> create(String todoName, DateTime impDate, TimeOfDay? startedTime,
      TimeOfDay? endedTime, DateTime createdAt);

  Future<void> update(int id, String todoName, TimeOfDay? startedTime,
      TimeOfDay? endedTime, DateTime updatedAt);
}
