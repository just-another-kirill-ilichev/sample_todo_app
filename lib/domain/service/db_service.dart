import 'package:logging/logging.dart';
import 'package:sample_todo_app/config/app_schema.dart';
import 'package:sample_todo_app/domain/db_connection.dart';
import 'package:sample_todo_app/domain/repository/generic/base_sql_repository.dart';
import 'package:sample_todo_app/domain/repository/generic/serializer.dart';
import 'package:sample_todo_app/domain/repository/specific/todo_sql_repository.dart';
import 'package:sample_todo_app/domain/service/service.dart';
import 'package:sample_todo_app/model/folder.dart';
import 'package:sample_todo_app/model/todo.dart';

class DbService implements Service {
  static final Logger _logger = Logger('DbService');

  final DbConnection _connection;
  late TodoSqlRepository _todoRepository;
  late BaseSqlRepository<Folder> _folderRepository;

  TodoSqlRepository get todoRepository => _todoRepository;
  BaseSqlRepository<Folder> get folderRepository => _folderRepository;

  DbService()
      : _connection = DbConnection('todos.db', [
          AppSchema.todos,
          AppSchema.folders,
        ]);

  Future<void> initialize() async {
    _logger.fine('Initializing database');

    await _connection.initializeDb();

    _todoRepository = TodoSqlRepository(
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
