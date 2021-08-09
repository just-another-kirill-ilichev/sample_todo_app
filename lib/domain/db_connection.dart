import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'package:sample_todo_app/domain/schema/table_schema.dart';
import 'package:sqflite/sqflite.dart';

class DbConnection {
  static final Logger _logger = Logger('DbConnection');
  static const String _dbName = 'todos.db';

  late Database _database;
  final List<TableSchema> tables;

  Database get database => _database;

  DbConnection(this.tables);

  Future<void> initializeDb() async {
    _logger.fine('Connecting to database...');

    try {
      var dbPath = join(await getDatabasesPath(), _dbName);

      _database = await openDatabase(
        dbPath,
        onConfigure: (db) async {
          await db.execute('PRAGMA foreign_keys = ON;');
        },
        onCreate: (db, version) async => await _createDb(db),
        onUpgrade: (db, oldVersion, newVersion) async =>
            await _migrateDb(db, oldVersion, newVersion),
        version: 4,
      );

      _logger.fine('Connection successful');
    } catch (e, stacktrace) {
      _logger.severe('Failed to connect to database', e, stacktrace);
    }
  }

  Future<void> _createDb(Database db) async {
    _logger.fine('Creating database schema...');
    for (var table in tables) {
      _logger.fine('Creating table ${table.tableName}...');
      await db.execute(table.getCreationScript());
    }
    _logger.fine('Database schema created successfully');
  }

  Future<void> _migrateDb(Database db, int oldVersion, int newVersion) async {
    _logger.fine('Applying migrations...');
    for (var table in tables) {
      _logger.fine('Migrating table ${table.tableName}...');
      if (table.hasBreakingChanges(oldVersion, newVersion)) {
        _logger.warning(
            'Cannot apply migration to table ${table.tableName}. Recreating...');
        db.execute('DROP TABLE IF EXISTS ${table.tableName};');
        db.execute(table.getCreationScript());
      } else {
        var migrations = table.getMigrations(oldVersion, newVersion);
        for (var migration in migrations) {
          db.execute(migration.script!);
        }
      }
    }
    _logger.fine('Migrations applied successfully');
  }
}
