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
    return ChangeNotifierProvider(
      create: (context) => DailyTodosEditViewModel(
          _id, TodoRepositoryImpl(AppDatabase())),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
          actions: [
            Consumer<DailyTodosEditViewModel>(
              builder: (context, vm, child) {
                return ElevatedButton(
                  onPressed: () async {
                    if (vm.isNew) {
                      await _save(context, vm);
                    } else {
                      await _update(context, vm);
                    }
                    Navigator.pop(context, true); // trueを返してデータ再読み込みをトリガー
                  },
                  child: const Text('保存'),
                );
              },
            ),
          ],
        ),
        body: Consumer<DailyTodosEditViewModel>(
          builder: (context, vm, child) {
            return Form(
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
                      // TODO: 使いにくいのでもっと良いやり方を模索する
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
            );
          },
        ),
      ),
    );
  }

  Future _save(BuildContext context, DailyTodosEditViewModel vm) async {
    _showIndicator(context);
    await vm.save();
    _goToDailyTodosScreen(context);
  }

  Future _update(BuildContext context, DailyTodosEditViewModel vm) async {
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
    // daily_todosの画面に戻る
    if (Navigator.canPop(context)) {
      Navigator.pop(context, true);
    }
  }
}
