import 'package:sample_todo_app/domain/db_connection.dart';
import 'package:sample_todo_app/domain/repository/generic/repository.dart';
import 'package:sample_todo_app/domain/repository/generic/serializer.dart';

class BaseSqlRepository<T extends Entity<int>> implements IRepository<T, int> {
  final String table;
  final Serializer<T> serializer;
  final DbConnection connection;

  BaseSqlRepository(this.table, this.serializer, this.connection);

  @override
  Future<bool> existsById(int id) async => (await fetchById(id)) != null;

  @override
  Future<List<T>> fetchAll() async {
    var queryResult = await connection.database.query(table);
    return serializer.deserializeMany(queryResult);
  }

  Future<List<T>> fetchAllOrderBy(String? column) async {
    var queryResult = await connection.database.query(table, orderBy: column);
    return serializer.deserializeMany(queryResult);
  }

  @override
  Future<T?> fetchById(int id) async {
    var queryResult = await connection.database
        .query(table, where: 'id = ?', whereArgs: [id]);

    if (queryResult.isEmpty) {
      return null;
    } else {
      return serializer.deserializeSingle(queryResult.first);
    }
  }

  @override
  Future<void> removeAll() async {
    await connection.database.delete(table);
  }

  @override
  Future<void> removeById(int id) async {
    await connection.database.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> save(T item) async {
    var data = serializer.serializeSingle(item);

    if (item.id != null && await existsById(item.id!)) {
      await connection.database
          .update(table, data, where: 'id = ?', whereArgs: [item.id]);
    } else {
      await connection.database.insert(table, data);
    }
  }
}
