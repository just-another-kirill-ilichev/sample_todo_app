import 'package:sample_todo_app/model/todo.dart';

enum TodoFormMode {
  add,
  edit,
}

class TodoFormState {
  final TodoFormMode mode;
  int? id;
  String? title;
  String? description;
  DateTime? creationTime;
  DateTime? notificationDateTime;
  int? folderId;
  bool? finished;

  TodoFormState({
    required this.mode,
    this.id,
    this.title,
    this.description,
    this.notificationDateTime,
    this.creationTime,
    this.folderId,
    this.finished,
  });

  factory TodoFormState.fromModel(Todo todo) {
    return TodoFormState(
      id: todo.id,
      mode: TodoFormMode.edit,
      title: todo.title,
      folderId: todo.folderId,
      description: todo.description,
      notificationDateTime: todo.notificationDateTime,
      finished: todo.finished,
    );
  }

  factory TodoFormState.create() {
    var now = DateTime.now();
    var notificationDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
    ).add(Duration(days: 1));

    return TodoFormState(
      mode: TodoFormMode.add,
      notificationDateTime: notificationDateTime,
    );
  }

  Todo toModel() {
    return Todo(
      id: id,
      creationDate: creationTime ?? DateTime.now(),
      notificationDateTime: notificationDateTime!,
      title: title!,
      folderId: folderId,
      description: description!,
      finished: finished ?? false,
    );
  }
}
