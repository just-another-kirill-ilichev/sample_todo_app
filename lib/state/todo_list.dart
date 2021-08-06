import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sample_todo_app/domain/db_connection.dart';
import 'package:sample_todo_app/model/todo.dart';

class TodoList extends ChangeNotifier {
  final DbConnection connection;

  List<Todo> _todos = [];

  TodoList(this.connection) {
    fetchAll(); // TODO move to FutureBuilder in main.dart?
  }

  UnmodifiableListView<Todo> get items => UnmodifiableListView(_todos);

  Future<void> remove(Todo item) async {
    await connection.database
        .delete('todos', where: 'id = ?', whereArgs: [item.id]);
    await fetchAll();
    notifyListeners();
  }

  Future<void> removeAll() async {
    await connection.database.delete('todos');
    await fetchAll();
    notifyListeners();
  }

  Future<void> add(Todo item) async {
    await connection.database.insert('todos', item.toMap());
    await fetchAll();
    notifyListeners();
  }

  Future<void> save(Todo item) async {
    await connection.database
        .update('todos', item.toMap(), where: 'id = ?', whereArgs: [item.id]);

    await fetchAll();
    notifyListeners();
  }

  Future<void> fetchAll() async {
    var queryResult =
        await connection.database.query('todos', orderBy: 'finished');
    _todos = queryResult.map((e) => Todo.fromMap(e)).toList();
    notifyListeners();
  }
}
