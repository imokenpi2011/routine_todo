import 'package:flutter/material.dart';

class Todo {
  int id;
  int? repeatTodoPresetId;
  String todoName;
  DateTime impDate;
  TimeOfDay? startedTime;
  TimeOfDay? endedTime;
  int completed;
  DateTime createdAt;
  DateTime updatedAt;

  Todo({
    required this.id,
    required this.repeatTodoPresetId,
    required this.todoName,
    required this.impDate,
    required this.startedTime,
    required this.endedTime,
    required this.completed,
    required this.createdAt,
    required this.updatedAt,
  });

  Todo copyWith({
    int? id,
    int? repeatTodoPresetId,
    String? todoName,
    DateTime? impDate,
    TimeOfDay? startedTime,
    TimeOfDay? endedTime,
    int? completed,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Todo(
      id: id ?? this.id,
      repeatTodoPresetId: repeatTodoPresetId ?? this.repeatTodoPresetId,
      todoName: todoName ?? this.todoName,
      impDate: impDate ?? this.impDate,
      startedTime: startedTime ?? this.startedTime,
      endedTime: endedTime ?? this.endedTime,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}