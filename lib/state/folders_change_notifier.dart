import 'package:sample_todo_app/domain/repository/generic/base_sql_repository.dart';
import 'package:sample_todo_app/model/folder.dart';
import 'package:sample_todo_app/state/repository_change_notifier.dart';

class FoldersChangeNotifier
    extends RepositoryChangeNotifier<Folder, BaseSqlRepository<Folder>> {
  FoldersChangeNotifier(BaseSqlRepository<Folder> repository)
      : super(repository);
}
