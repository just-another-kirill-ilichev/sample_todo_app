import 'package:flutter_test/flutter_test.dart';
import 'package:sample_todo_app/domain/schema/field.dart';
import 'package:sample_todo_app/domain/schema/field_type.dart';
import 'package:sample_todo_app/domain/schema/table_schema.dart';

void main() {
  group('SQL generator', () {
    test('empty table', () {
      var testSchema = TableSchema(
        tableName: 'test',
        fields: [],
        migrations: [],
      );

      expect(testSchema.getCreationScript(), 'CREATE TABLE main.test()');
    });

    test('simple table', () {
      var testSchema = TableSchema(
        tableName: 'test',
        fields: [
          Field(name: 'id', type: FieldType.integer, isPrimaryKey: true),
          Field(name: 'title', type: FieldType.text),
        ],
        migrations: [],
      );

      expect(testSchema.getCreationScript(),
          'CREATE TABLE main.test(id INTEGER PRIMARY KEY, title TEXT)');
    });
  });
}
