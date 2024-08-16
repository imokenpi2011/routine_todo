import 'package:flutter/material.dart';

import '../../domains/entities/todo.dart';
import '../../domains/repositories/app_database.dart';
import '../../domains/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final String _tableName = 'todos';
  final AppDatabase _appDatabase;

  TodoRepositoryImpl(this._appDatabase);

  @override
  Future<List<Todo>> loadTodosByDate(DateTime date) async {
    final db = await _appDatabase.database;
    var maps = await db.query(
      _tableName,
      where: 'imp_date = date(?)',
      whereArgs: [date.toIso8601String()],
    );

    if (maps.isEmpty) return [];

    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<Todo?> loadTodoById(int id) async {
    final db = await _appDatabase.database;
    var maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;

    return fromMap(maps.first);
  }

  Todo fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      repeatTodoPresetId: map['repeat_todo_preset_id'],
      todoName: map['todo_name'],
      impDate: DateTime.parse(map['imp_date']),
      startedTime: map['started_time'] != null
          ? _parseTimeOfDay(map['started_time'])
          : null,
      endedTime: map['ended_time'] != null
          ? _parseTimeOfDay(map['ended_time'])
          : null,
      completed: map['completed'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  TimeOfDay _parseTimeOfDay(String time) {
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  @override
  Future<void> updateTodoCompleted(int id, bool completed) async {
    final db = await _appDatabase.database;
    await db.update(
      _tableName,
      {'completed': completed ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Map<String, dynamic> toMap(Todo todo) {
    return {
      'id': todo.id,
      'repeat_todo_preset_id': todo.repeatTodoPresetId,
      'todo_name': todo.todoName,
      'imp_date': todo.impDate.toIso8601String(),
      'started_time': todo.startedTime != null ? _timeOfDayToDateTime(todo.startedTime!).toIso8601String() : null,
      'ended_time': todo.endedTime != null ? _timeOfDayToDateTime(todo.endedTime!).toIso8601String() : null,
      'completed': todo.completed,
      'created_at': todo.createdAt.toIso8601String(),
      'updated_at': todo.updatedAt?.toIso8601String(),
    };
  }

  DateTime _timeOfDayToDateTime(TimeOfDay time) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }
}
