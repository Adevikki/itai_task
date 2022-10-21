import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itai_test/config/routes.dart';
import 'package:itai_test/view/todo_view.dart';

void main() {
  runApp(const ProviderScope(child: TodoListApp()));
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo list',
      home: const TodoView(),
        routes: routes,
    );
  }
}
