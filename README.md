# routine_todo

ルーティンTODOアプリ

## ディレクトリ構成
参考：https://blog.kinto-technologies.com/posts/2023-12-10-flutter-architecture/

```
lib/
├── presentations
│   ├── pages         // 各ページ用ファイルを定義
│   │   └── dailt_todos
│   │       ├── dailt_todos.dart
│   │       ├── dailt_todos_view_model.dart
│   │       └── components // ページ内のコンポーネント
│   ├── components    // 共通のコンポーネント
│   ├── style.dart    // 共通のスタイル定義
│   └── app.dart
├── domains
│   ├── entities      // ドメインモデル
│   └── repositories  // リポジトリのinterface
├── infrastructures
│   └── repositories_impl  // リポジトリの実装
└── main.dart
```

## ブランチ戦略

- master: リリース済みの最新コード
- milestoneXX: マイルストーンごとのリリース用ブランチ
  - リリース時にmasterにマージ
- issue/X: issueごとの作業用ブランチ。リリース対象のmilestoneブランチから作成する
  - マージ時にissueをクローズ
