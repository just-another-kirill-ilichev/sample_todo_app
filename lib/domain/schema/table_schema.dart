import 'package:sample_todo_app/domain/schema/field.dart';
import 'package:sample_todo_app/domain/schema/migration.dart';

class TableSchema {
  final String tableName;
  final List<Field> fields;
  final List<Migration> migrations;

  TableSchema({
    required this.tableName,
    required this.fields,
    required this.migrations,
  });

  String getCreationScript() {
    var script = 'CREATE TABLE main.$tableName(' +
        fields.map((e) => e.createSqlDefinition()).join(', ') +
        fields
            .map((e) => e.createForeignKeyDefinition())
            .where((e) => e.isNotEmpty)
            .join(', ') +
        ')';

    return script;
  }

  List<Migration> getMigrations(int oldVersion, int newVersion) => migrations
      .where((e) => e.version > oldVersion && e.version <= newVersion)
      .toList();

  bool hasBreakingChanges(int oldVersion, int newVersion) =>
      getMigrations(oldVersion, newVersion).any((e) => e.isBreakingChange);
}
