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
    return MultiProvider(
      providers: [
        Provider<TodoRepository>(
          create: (_) => TodoRepositoryImpl(AppDatabase()),
        ),
        ChangeNotifierProvider<DailyTodosViewModel>(
          create: (context) => DailyTodosViewModel(
            Provider.of<TodoRepository>(context, listen: false),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Routine App',
        theme: ThemeData(),
        home: const DailyTodos(),
        routes: {
          '/ui.daily_todos_edit': (context) => const DailyTodosEdit(null),
        },
      ),
    );
  }
}
