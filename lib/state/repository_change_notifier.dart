import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sample_todo_app/domain/repository/generic/base_sql_repository.dart';
import 'package:sample_todo_app/domain/repository/generic/repository.dart';

class RepositoryChangeNotifier<TItem extends Entity<int>,
    TRepo extends BaseSqlRepository<TItem>> extends ChangeNotifier {
  @protected
  final TRepo repository;

  @protected
  List<TItem> internal = [];

  UnmodifiableListView<TItem> get items => UnmodifiableListView(internal);

  RepositoryChangeNotifier(this.repository) {
    update();
  }

  Future<void> removeAll() async {
    await repository.removeAll();
    update();
  }

  Future<void> removeById(int id) async {
    await repository.removeById(id);
    update();
  }

  Future<void> remove(TItem item) async => await removeById(item.id!);

  Future<void> save(TItem item) async {
    await repository.save(item);
    update();
  }

  Future<void> update() async {
    internal = await repository.fetchAll();
    notifyListeners();
  }
}
