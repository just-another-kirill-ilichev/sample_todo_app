import 'package:sample_todo_app/domain/db_connection.dart';
import 'package:sample_todo_app/domain/repository/generic/base_sql_repository.dart';
import 'package:sample_todo_app/domain/repository/generic/serializer.dart';
import 'package:sample_todo_app/model/meta_folder.dart';
import 'package:sample_todo_app/model/todo.dart';

class TodoSqlRepository extends BaseSqlRepository<Todo> {
  TodoSqlRepository(
    String table,
    Serializer<Todo> serializer,
    DbConnection connection,
  ) : super(table, serializer, connection);

  Future<List<Todo>> fetchByMetaFolder(
    MetaFolder metaFolder, {
    String? orderBy,
  }) async {
    switch (metaFolder.type) {
      case MetaFolderType.folder:
        return await fetchByFolderId(metaFolder.folder!.id!);
      case MetaFolderType.all:
        return await fetchAllOrderBy(orderBy);
      case MetaFolderType.today:
        return await fetchByDate(DateTime.now());
    }
  }

  Future<List<Todo>> fetchByDate(DateTime date, {String? orderBy}) async {
    var dateStr = date.toIso8601String();
    var dateEnd = dateStr.indexOf('T');
    dateStr = dateStr.substring(0, dateEnd).trim() + '%';

    var itemsData = await connection.database.query(
      table,
      where: 'notificationDateTime LIKE ?',
      whereArgs: [dateStr],
      orderBy: orderBy,
    );

    return serializer.deserializeMany(itemsData);
  }

  Future<List<Todo>> fetchByFolderId(int folderId, {String? orderBy}) async {
    var itemsData = await connection.database.query(table,
        where: 'folderId = ?', whereArgs: [folderId], orderBy: orderBy);

    return serializer.deserializeMany(itemsData);
  }
}
