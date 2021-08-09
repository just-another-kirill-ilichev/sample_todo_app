import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sample_todo_app/domain/db_service.dart';
import 'package:sample_todo_app/model/todo.dart';

class TodoList extends ChangeNotifier {
  final DbService service;

  List<Todo> _todos = [];

  TodoList(this.service) {
    fetchAll();
  }

  UnmodifiableListView<Todo> get items => UnmodifiableListView(_todos);

  Future<void> remove(Todo item) async {
    await service.todoRepository.removeById(item.id!);
    await fetchAll();
  }

  Future<void> removeAll() async {
    await service.todoRepository.removeAll();
    await fetchAll();
  }

  Future<void> save(Todo item) async {
    await service.todoRepository.save(item);
    await fetchAll();
  }

  Future<void> fetchAll() async {
    _todos = await service.todoRepository.fetchAllOrderBy('finished');
    notifyListeners();
  }
}
