import 'package:sample_todo_app/config/app_schema.dart';
import 'package:sample_todo_app/domain/db_connection.dart';
import 'package:sample_todo_app/domain/repository/generic/base_sql_repository.dart';
import 'package:sample_todo_app/domain/repository/generic/serializer.dart';
import 'package:sample_todo_app/model/folder.dart';
import 'package:sample_todo_app/model/todo.dart';

class DbService {
  final DbConnection _connection;
  late BaseSqlRepository<Todo> _todoRepository;
  late BaseSqlRepository<Folder> _folderRepository;

  BaseSqlRepository<Todo> get todoRepository => _todoRepository;
  BaseSqlRepository<Folder> get folderRepository => _folderRepository;

  DbService()
      : _connection = DbConnection('todos.db', [
          AppSchema.todos,
          AppSchema.folders,
        ]);

  Future<void> initialize() async {
    await _connection.initializeDb();

    _todoRepository = BaseSqlRepository<Todo>(
      AppSchema.todos.tableName,
      Serializer((item) => item.toMap(), (data) => Todo.fromMap(data)),
      _connection,
    );

    _folderRepository = BaseSqlRepository<Folder>(
      AppSchema.folders.tableName,
      Serializer((item) => item.toMap(), (data) => Folder.fromMap(data)),
      _connection,
    );
  }
}
