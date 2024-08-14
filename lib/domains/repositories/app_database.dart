import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// todosテーブルの定義
const String latestTodosTableStructure = '''
  CREATE TABLE todos(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    repeat_todo_preset_id INTEGER NOT NULL,
    todo_name TEXT NOT NULL,
    imp_date TEXT NOT NULL,
    started_time TEXT NULL DEFAULT NULL,
    ended_time TEXT NULL DEFAULT NULL,
    completed INTEGER NOT NULL DEFAULT 0,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
  );
''';

/// repeat_todo_presetsテーブルの定義
// TODO: 定義する
const String latestRepeatTodoPresetsTableStructure = '''
  CREATE TABLE repeat_todo_presets(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
  );
''';

/// repeat_todosテーブルの定義
// TODO: 定義する
const String latestRepeatTodosTableStructure = '''
  CREATE TABLE repeat_todos(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    repeat_todo_preset_id INTEGER NOT NULL,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
  )
  FOREIGN KEY (repeat_todo_preset_id) REFERENCES repeat_todo_presets(id);
''';

/// DBの接続情報を管理するクラス
class AppDatabase {
  final String _dbFile = 'routine_todo.db';
  final Completer<Database> _databaseCompleter = Completer();

  Future<Database> get database async {
    if (!_databaseCompleter.isCompleted) {
      _databaseCompleter.complete(_initDB());
    }
    return _databaseCompleter.future;
  }

  Future<Database> _initDB() async {
    var databasePath = await getDatabasesPath();
    return openDatabase(
      join(databasePath, _dbFile),
      // 初回作成時はonCreateが呼ばれる
      onCreate: (db, version) async {
        await db.transaction((transaction) async {
          await _multiExecInTransaction(transaction, [
            // todosテーブルの作成
            latestTodosTableStructure,
            // repeat_todo_presetsテーブルの作成
            // TODO: latestRepeatTodoPresetsTableStructure,
            // repeat_todosテーブルの作成
            // TODO: latestRepeatTodosTableStructure,
          ]);
        });
      },
      // UpdateでDBの構造が変わった場合はここに処理を書く
      onUpgrade: (db, oldVersion, newVersion) async {},
    );
  }

  Future<void> _multiExecInTransaction(
      Transaction transaction, List<String> sqlStatements) async {
    for (String sql in sqlStatements) {
      await transaction.execute(sql);
    }
  }
}
