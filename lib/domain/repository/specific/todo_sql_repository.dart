import 'package:sample_todo_app/domain/db_connection.dart';
import 'package:sample_todo_app/domain/repository/generic/base_sql_repository.dart';
import 'package:sample_todo_app/domain/repository/generic/serializer.dart';
import 'package:sample_todo_app/model/todo.dart';

class TodoSqlRepository extends BaseSqlRepository<Todo> {
  TodoSqlRepository(
    String table,
    Serializer<Todo> serializer,
    DbConnection connection,
  ) : super(table, serializer, connection);

  Future<List<Todo>> fetchByFolderIdAndDate({
    int? folderId,
    DateTime? date,
    String? orderBy,
  }) async {
    var where = '';
    var whereArgs = [];

    if (folderId == null && date == null) {
      return await fetchAllOrderBy(orderBy);
    }

    if (folderId != null) {
      where += 'folderId = ?';
      whereArgs.add(folderId);
    }

    if (date != null) {
      if (where.isNotEmpty) where += ' AND ';
      where += 'notificationDateTime LIKE ?';

      var dateStr = date.toIso8601String();
      var dateEnd = dateStr.indexOf('T');
      dateStr = dateStr.substring(0, dateEnd).trim() + '%';

      whereArgs.add(dateStr);
    }

    var itemsData = await connection.database
        .query(table, where: where, whereArgs: whereArgs, orderBy: orderBy);

    return serializer.deserializeMany(itemsData);
  }
}
