import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routine_todo/domains/repositories/app_database.dart';
import 'package:routine_todo/domains/repositories/todo_repository.dart';
import 'package:routine_todo/infrastructures/repositories_impl/todo_repository_impl.dart';
import 'package:routine_todo/presentations/pages/daily_todos/daily_todos.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Routine App',
      theme: ThemeData(),
      home: MultiProvider(
        providers: [
          Provider<TodoRepository>(
            create: (_) => TodoRepositoryImpl(AppDatabase()),
          ),
        ],
        child: const DailyTodos(),
      ),
    );
  }
}
