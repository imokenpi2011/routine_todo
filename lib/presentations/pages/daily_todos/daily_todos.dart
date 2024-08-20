import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routine_todo/domains/repositories/app_database.dart';
import 'package:routine_todo/infrastructures/repositories_impl/todo_repository_impl.dart';
import '../daily_todos_edit/daily_todos_edit.dart';
import 'daily_todos_view_model.dart';
import '../../../domains/repositories/todo_repository.dart';

class DailyTodos extends StatelessWidget {
  const DailyTodos({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = DailyTodosViewModel(TodoRepositoryImpl(AppDatabase()));
    return ChangeNotifierProxyProvider<TodoRepository, DailyTodosViewModel>(
      create: (_) => vm,
      update: (context, repository, previous) =>
          previous ?? DailyTodosViewModel(repository),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Daily Todos'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<DailyTodosViewModel>(
                builder: (context, viewModel, child) {
                  return ListView.builder(
                    itemCount: viewModel.todos.length,
                    itemBuilder: (context, index) {
                      final todoViewModel = viewModel.todos[index];
                      return Card(
                        child: ListTile(
                          leading: Checkbox(
                            value: todoViewModel.todo.completed == 1,
                            onChanged: (bool? afterCompleted) {
                              if (afterCompleted != null) {
                                viewModel.updateTodoCompleted(
                                  todoViewModel.todo.id,
                                  afterCompleted,
                                );
                              }
                            },
                          ),
                          title: Text(todoViewModel.todo.todoName),
                        ),
                      );
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          // メモ登録画面に遷移する
          onPressed: () => _goToDailyTodosCreateScreen(context, vm),
        ),
      ),
    );
  }

  void _goToDailyTodosCreateScreen(BuildContext context, DailyTodosViewModel vm) async {
    var route = MaterialPageRoute(
      settings: const RouteSettings(name: '/ui.daily_todos_edit'),
      builder: (BuildContext context) => DailyTodosEdit(null),
    );

    await Navigator.push(context, route).then((value) async {
      if (value == true) {
        await vm.fetchTodos(); // 戻った後にTODOをリフレッシュ
      }
    });
  }
}
