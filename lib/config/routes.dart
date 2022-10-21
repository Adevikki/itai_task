import 'package:flutter/material.dart';
import 'package:itai_test/view/todo_view.dart';

final Map<String, WidgetBuilder> routes = {
  TodoView.routeName: (context) => const TodoView(),
};
