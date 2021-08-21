import 'package:flutter/material.dart';
import 'package:sample_todo_app/domain/repository/generic/repository.dart';

enum FormMode {
  add,
  edit,
}

abstract class EntityFormState<U extends Entity<V>, V> extends ChangeNotifier {
  final FormMode mode;
  final V? id;

  EntityFormState(this.mode, this.id);

  U toModel();
}
