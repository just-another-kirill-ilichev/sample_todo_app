enum FieldType {
  integer,
  text,
}

extension FieldTypeSql on FieldType {
  String toSqlType() {
    switch (this) {
      case FieldType.integer:
        return 'INTEGER';
      case FieldType.text:
        return 'TEXT';
    }
  }
}

class Field {
  final String name;
  final FieldType type;
  final bool isPrimaryKey;
  final bool isForeignKey;
  final String? referenceTable;
  final String? referenceColumn;

  Field({
    required this.name,
    required this.type,
    this.isPrimaryKey = false,
    this.isForeignKey = false,
    this.referenceTable,
    this.referenceColumn,
  }) {
    assert(!isPrimaryKey || isPrimaryKey != isForeignKey);
    assert(isForeignKey == (referenceTable != null));
    assert(isForeignKey == (referenceColumn != null));
  }
}

class Migration {
  final int version;
  final String? script;
  final bool isBreakingChange;

  Migration({
    required this.version,
    this.script,
    this.isBreakingChange = false,
  }) {
    assert(isBreakingChange != (script != null));
  }
}

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
    var foreignKeys = [];
    var script = 'CREATE TABLE main.$tableName(';

    for (var field in fields) {
      script += '${field.name} ${field.type.toSqlType()}';

      if (field.isForeignKey) {
        foreignKeys.add(field);
      }

      if (field.isPrimaryKey) {
        script += ' PRIMARY KEY';
      }

      if (field != fields.last || foreignKeys.isNotEmpty) {
        script += ', ';
      }
    }

    for (var field in foreignKeys) {
      script +=
          'FOREIGN KEY(${field.name}) REFERENCES ${field.referenceTable}(${field.referenceColumn})';
      if (field != foreignKeys.last) {
        script += ', ';
      }
    }

    script += ');';

    return script;
  }

  List<Migration> getMigrations(int oldVersion, int newVersion) => migrations
      .where((e) => e.version > oldVersion && e.version <= newVersion)
      .toList();

  bool hasBreakingChanges(int oldVersion, int newVersion) =>
      getMigrations(oldVersion, newVersion).any((e) => e.isBreakingChange);
}
