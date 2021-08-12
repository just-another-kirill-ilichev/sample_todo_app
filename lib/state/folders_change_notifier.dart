import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sample_todo_app/domain/db_service.dart';
import 'package:sample_todo_app/model/folder.dart';

class FoldersChangeNotifier extends ChangeNotifier {
  final DbService _service;

  List<Folder> _items = [];

  UnmodifiableListView<Folder> get items => UnmodifiableListView(_items);

  FoldersChangeNotifier(this._service) {
    fetchAll();
  }

  Future<void> fetchAll() async {
    _items = await _service.folderRepository.fetchAll();
    notifyListeners();
  }
}
