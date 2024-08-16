import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routine_todo/presentations/pages/daily_todos_edit/daily_todos_edit_view_model.dart';

import '../../../domains/repositories/todo_repository.dart';
import '../../components/time_picker.dart';

class DailyTodosEdit extends StatelessWidget {
  final int? _id;
  final String _title;

  const DailyTodosEdit(this._id, {super.key})
      : _title = _id == null ? 'TODO作成' : 'TODO編集';

  @override
  Widget build(BuildContext context) {
    final vm = DailyTodosEditViewModel(
        _id, Provider.of<TodoRepository>(context, listen: false));
    return ChangeNotifierProvider(
      create: (context) => vm,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (vm.isNew) {
                  _save(context);
                } else {
                  _update(context);
                }
                Navigator.pop(context);
              },
              child: const Text('保存'),
            )
          ],
        ),
        body: Form(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: vm.todoName,
                  decoration: const InputDecoration(labelText: 'TODOを入力'),
                  maxLength: 30,
                  onChanged: (value) => vm.todoName = value,
                ),
              ),
              Row(
                children: [
                  // TimePicker for startedTime
                  Expanded(
                    child: TimePicker(
                      label: '開始時間',
                      initialTime: vm.startedTime ?? TimeOfDay.now(),
                      onTimeChanged: (time) => vm.startedTime = time,
                    ),
                  ),
                  // TimePicker for endedTime
                  Expanded(
                    child: TimePicker(
                      label: '終了時間',
                      initialTime: vm.endedTime ?? TimeOfDay.now(),
                      onTimeChanged: (time) => vm.endedTime = time,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save(BuildContext context) async {
    var vm = Provider.of<DailyTodosEditViewModel>(context, listen: false);

    _showIndicator(context);
    await vm.save();
    _goToDailyTodosScreen(context);
  }

  void _update(BuildContext context) async {
    var vm = Provider.of<DailyTodosEditViewModel>(context, listen: false);

    _showIndicator(context);
    await vm.update();
    _goToDailyTodosScreen(context);
  }

  void _showIndicator(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (
          BuildContext context,
          Animation animation,
          Animation secondaryAnimation,
          ) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  void _goToDailyTodosScreen(BuildContext context) {
    if (context.mounted) Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }
}
