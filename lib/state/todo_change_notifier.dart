import 'package:sample_todo_app/domain/repository/specific/todo_sql_repository.dart';
import 'package:sample_todo_app/model/todo.dart';
import 'package:sample_todo_app/state/repository_change_notifier.dart';

class TodoFilter {
  final int? folderId;
  final DateTime? date;

  TodoFilter({this.folderId, this.date});
}

class TodoChangeNotifier
    extends RepositoryChangeNotifier<Todo, TodoSqlRepository> {
  TodoChangeNotifier(TodoSqlRepository repository) : super(repository);

  TodoFilter _filter = TodoFilter();

  void setFilter(TodoFilter filter) {
    _filter = filter;
    update();
  }

  @override
  Future<void> update() async {
    internal = await repository.fetchByFolderIdAndDate(
      folderId: _filter.folderId,
      date: _filter.date,
      orderBy: 'finished',
    );
    notifyListeners();
  }
}
