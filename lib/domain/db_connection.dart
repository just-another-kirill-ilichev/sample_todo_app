import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbConnection {
  late Database _database;

  Database get database => _database;

  Future<void> initializeDb() async {
    var folder = await getDatabasesPath();
    var dbPath = join(folder, 'todos.db');
    print('Connecting to database...');
    _database = await openDatabase(
      dbPath,
      onCreate: (db, version) async => await db.execute(
        'CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT, creationDate TEXT, notificationDateTime TEXT, finished INTEGER)',
      ),
      version: 1,
    );
    //await _database.delete('todos');

    print('Connection successful');
  }
}
