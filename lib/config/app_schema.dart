import 'package:sample_todo_app/domain/table_schema.dart';

class AppSchema {
  static TableSchema todos = TableSchema(
    tableName: 'todos',
    fields: [
      Field(name: 'id', type: FieldType.integer, isPrimaryKey: true),
      Field(name: 'title', type: FieldType.text),
      Field(name: 'description', type: FieldType.text),
      Field(name: 'creationDate', type: FieldType.text),
      Field(name: 'notificationDateTime', type: FieldType.text),
      Field(
        name: 'folderId',
        type: FieldType.integer,
        isForeignKey: true,
        referenceTable: 'folders',
        referenceColumn: 'id',
      ),
      Field(name: 'finished', type: FieldType.integer),
    ],
    migrations: [
      Migration(version: 2, script: "ALTER TABLE todos ADD folder TEXT"),
      Migration(version: 3, isBreakingChange: true),
    ],
  );

  static TableSchema folders = TableSchema(
    tableName: 'folders',
    fields: [
      Field(name: 'id', type: FieldType.integer, isPrimaryKey: true),
      Field(name: 'title', type: FieldType.text),
    ],
    migrations: [
      Migration(version: 3, isBreakingChange: true),
    ],
  );
}
