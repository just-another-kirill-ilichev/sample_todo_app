import 'package:sample_todo_app/domain/schema/field_type.dart';

class Field {
  final String name;
  final FieldType type;
  final bool isPrimaryKey;
  final bool isUnique;
  final bool isNotNull;
  final dynamic defaultValue;
  final bool isForeignKey;
  final String? referenceTable;
  final String? referenceColumn;

  Field({
    required this.name,
    required this.type,
    this.isPrimaryKey = false,
    this.isUnique = false,
    this.isNotNull = false,
    this.defaultValue,
    this.isForeignKey = false,
    this.referenceTable,
    this.referenceColumn,
  }) {
    assert(!(isUnique && isPrimaryKey));
    assert(!(isPrimaryKey && isForeignKey));
    assert(isForeignKey == (referenceTable != null));
    assert(isForeignKey == (referenceColumn != null));
  }

  String createSqlDefinition() {
    var src = '$name ${type.toSqlType()}';

    src += _addConstraintIf(isPrimaryKey, 'PRIMARY KEY');
    src += _addConstraintIf(isNotNull, 'NOT NULL');
    src += _addConstraintIf(defaultValue != null, 'DEFAULT $defaultValue');
    src += _addConstraintIf(isUnique, 'UNIQUE');

    return src;
  }

  String createForeignKeyDefinition() => isForeignKey
      ? 'FOREIGN KEY($name) REFERENCES $referenceTable($referenceColumn)'
      : '';

  String _addConstraintIf(bool flag, String constaint) =>
      flag ? ' $constaint' : '';
}
