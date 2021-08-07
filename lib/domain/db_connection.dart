import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbConnection {
  static final Logger _logger = Logger('DbConnection');
  static const String _dbName = 'todos.db';

  static const _migrationScripts = <String>[
    "ALTER TABLE todos ADD folder TEXT; UPDATE todos SET folder = 'default'"
  ];

  late Database _database;

  Database get database => _database;

  Future<void> initializeDb() async {
    _logger.fine('Connecting to database...');

    try {
      var dbPath = join(await getDatabasesPath(), _dbName);

      _database = await openDatabase(
        dbPath,
        onCreate: (db, version) async {
          _logger.fine('Creating database schema...');
          await db.execute(
            'CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT, creationDate TEXT, notificationDateTime TEXT, folder TEXT, finished INTEGER)',
          );
          _logger.fine('Database schema created successfully');
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          _logger.fine('Applying migrations...');
          await db.execute(_getMigrationScript(oldVersion, newVersion));
          _logger.fine('Migrations applied successfully');
        },
        version: 2,
      );

      _logger.fine('Connection successful');
    } catch (e, stacktrace) {
      _logger.severe('Failed to connect to database', e, stacktrace);
    }
  }

  String _getMigrationScript(int oldVersion, int newVersion) {
    var script = '';

    for (int i = oldVersion - 1; i < newVersion - 1; i++) {
      script += _migrationScripts[i] + ';';
    }

    return script;
  }
}
