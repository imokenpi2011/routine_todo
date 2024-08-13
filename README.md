# routine_todo

ルーティンTODOアプリ

## ディレクトリ構成
参考：https://blog.kinto-technologies.com/posts/2023-12-10-flutter-architecture/

```
lib/
├── presentations
│   ├── pages
│   │   └── home_page
│   │       ├── home_page.dart
│   │       ├── home_page_vm.dart
│   │       ├── home_page_state.dart
│   │       └── components
│   ├── components
│   ├── style.dart    // 共通のスタイル定義
│   └── app.dart
├── domains
│   ├── entities
│   └── repositories  // リポジトリのinterface
├── infrastructures
│   └── repositories
└── main.dart
```
