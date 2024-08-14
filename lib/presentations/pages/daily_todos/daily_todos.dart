import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domains/repositories/todo_repository.dart';
import 'daily_todos_view_model.dart';

class DailyTodos extends StatelessWidget {
  const DailyTodos({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DailyTodosViewModel(Provider.of<TodoRepository>(context, listen: false)),      child: Scaffold(
        appBar: AppBar(
          title: const Text('Daily Todos'),
        ),
        body: Consumer<DailyTodosViewModel>(
          builder: (context, viewModel, child) {
            return ListView.builder(
              itemCount: viewModel.todos.length,
              itemBuilder: (context, index) {
                final todoViewModel = viewModel.todos[index];
                return Card(
                  child: ListTile(
                    leading: Checkbox(
                      value: todoViewModel.todo.completed == 1,
                      onChanged: (bool? value) {
                        if (value != null) {
                          viewModel.updateTodoCompleted(
                            todoViewModel.todo.id,
                            value,
                          );
                        }
                      },
                    ),
                    title: Text(todoViewModel.todo.todoName),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}