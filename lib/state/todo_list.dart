import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sample_todo_app/domain/db_connection.dart';
import 'package:sample_todo_app/model/todo.dart';

class TodoList extends ChangeNotifier {
  final DbConnection connection;

  List<Todo> _todos = [];

  TodoList(this.connection) {
    fetch(); // TODO move to FutureBuilder in main.dart?
  }

  UnmodifiableListView<Todo> get items => UnmodifiableListView(_todos);

  void add(Todo item) async {
    await connection.database.insert('todos', item.toMap());
    await fetch();
    notifyListeners();
  }

  Future<void> fetch() async {
    var queryResult = await connection.database.query('todos');
    _todos = queryResult.map((e) => Todo.fromMap(e)).toList();
    notifyListeners();
  }
}
