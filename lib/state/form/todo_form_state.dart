import 'package:sample_todo_app/model/todo.dart';
import 'package:sample_todo_app/state/form/entity_form_state.dart';

class TodoFormState extends EntityFormState<Todo, int> {
  String? title;
  String? description;
  DateTime? creationTime;
  DateTime? notificationDateTime;
  int? folderId;
  bool? finished;

  TodoFormState({
    required FormMode mode,
    int? id,
    this.title,
    this.description,
    this.notificationDateTime,
    this.creationTime,
    this.folderId,
    this.finished,
  }) : super(mode, id);

  factory TodoFormState.fromModel(Todo todo) {
    return TodoFormState(
      id: todo.id,
      mode: FormMode.edit,
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
      mode: FormMode.add,
      notificationDateTime: notificationDateTime,
    );
  }

  @override
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
