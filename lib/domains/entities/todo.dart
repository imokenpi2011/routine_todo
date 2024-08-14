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
}