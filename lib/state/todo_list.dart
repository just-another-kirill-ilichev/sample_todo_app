import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sample_todo_app/model/todo.dart';

class TodoList extends ChangeNotifier {
  final List<Todo> _todos = [];

  UnmodifiableListView<Todo> get items => UnmodifiableListView(_todos);

  void add(Todo item) {
    _todos.add(item);
    notifyListeners();
  }
}
