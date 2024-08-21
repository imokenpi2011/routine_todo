import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// todosテーブルの定義
const String latestTodosTableStructure = '''
  CREATE TABLE todos(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    repeat_todo_preset_id INTEGER NULL DEFAULT NULL,
    todo_name TEXT NOT NULL,
    imp_date TEXT NOT NULL,
    started_time TEXT NULL DEFAULT NULL,
    ended_time TEXT NULL DEFAULT NULL,
    completed INTEGER NOT NULL DEFAULT 0,
    created_at TEXT NOT NULL,
    updated_at TEXT NULL DEFAULT NULL
  );
''';

// 本日日付の文字列をyyyy-MM-dd形式で取得する
final now = DateTime.now();
final String today = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
// TODO: テストデータなので消す
String insertTodosTestData = '''
  INSERT INTO todos(
    repeat_todo_preset_id,
    todo_name,
    imp_date,
    started_time,
    ended_time,
    completed,
    created_at,
    updated_at
  ) VALUES
    (null, '時間あり', '$today', '10:00', '11:00', 0, '2021-09-01 00:00:00', '2021-09-01 00:00:00'),
    (null, '日付変わり目', '$today', '03:00', '04:00', 0, '2021-09-01 00:00:00', '2021-09-01 00:00:00'),
    (null, '時間null', '$today', null, null, 0, '2021-09-01 00:00:00', '2021-09-01 00:00:00'),
    (null, '完了済みTODO', '$today', null, null, 1, '2021-09-01 00:00:00', '2021-09-01 00:00:00'),
    (1, '本日日付でない', '2024-08-01', '12:00', '15:00', 0, '2021-09-01 00:00:00', '2021-09-01 00:00:00'),
    (1, '繰り返し', '$today', '01:00', '03:00', 0, '2021-09-01 00:00:00', '2021-09-01 00:00:00'),
    (1, '繰り返し2', '$today', '09:00', '10:00', 0, '2021-09-01 00:00:00', '2021-09-01 00:00:00')
  ''';

/// repeat_todo_presetsテーブルの定義
// TODO: 定義する
const String latestRepeatTodoPresetsTableStructure = '''
  CREATE TABLE repeat_todo_presets(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    created_at TEXT NOT NULL,
    updated_at NULL DEFAULT NULL
  );
''';

/// repeat_todosテーブルの定義
// TODO: 定義する
const String latestRepeatTodosTableStructure = '''
  CREATE TABLE repeat_todos(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    repeat_todo_preset_id INTEGER NOT NULL,
    created_at TEXT NOT NULL,
    updated_at TEXT NULL DEFAULT NULL
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
      version: 1,
      // 初回作成時はonCreateが呼ばれる
      onCreate: (db, version) async {
        await db.transaction((transaction) async {
          await _multiExecInTransaction(transaction, [
            // todosテーブルの作成
            latestTodosTableStructure,
            insertTodosTestData, // TODO: CRUDできるようになったら消す
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
