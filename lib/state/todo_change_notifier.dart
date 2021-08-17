import 'package:sample_todo_app/domain/repository/specific/todo_sql_repository.dart';
import 'package:sample_todo_app/model/meta_folder.dart';
import 'package:sample_todo_app/model/todo.dart';
import 'package:sample_todo_app/state/repository_change_notifier.dart';

class TodoChangeNotifier
    extends RepositoryChangeNotifier<Todo, TodoSqlRepository> {
  TodoChangeNotifier(TodoSqlRepository repository) : super(repository);

  MetaFolder _folder = MetaFolder(type: MetaFolderType.all);

  MetaFolder get currentFolder => _folder;

  set currentFolder(MetaFolder folder) {
    _folder = folder;
    update();
  }

  @override
  Future<void> update() async {
    internal = await repository.fetchByMetaFolder(_folder);
    notifyListeners();
  }
}
