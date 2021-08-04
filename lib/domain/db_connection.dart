import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbConnection {
  static final Logger _logger = Logger('DbConnection');
  static const String _dbName = 'todos.db';

  late Database _database;

  Database get database => _database;

  Future<void> initializeDb() async {
    _logger.fine('Connecting to database...');

    try {
      var dbPath = join(await getDatabasesPath(), _dbName);

      _database = await openDatabase(
        dbPath,
        onCreate: (db, version) async => await db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT, creationDate TEXT, notificationDateTime TEXT, finished INTEGER)',
        ),
        version: 1,
      );

      _logger.fine('Connection successful');
    } catch (e, stacktrace) {
      _logger.severe('Failed to connect to database', e, stacktrace);
    }
  }
}
