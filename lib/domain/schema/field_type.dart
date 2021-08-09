enum FieldType {
  integer,
  real,
  text,
  blob,
}

extension FieldTypeToSqlConverter on FieldType {
  String toSqlType() {
    switch (this) {
      case FieldType.integer:
        return 'INTEGER';
      case FieldType.real:
        return 'REAL';
      case FieldType.text:
        return 'TEXT';
      case FieldType.blob:
        return 'BLOB';
    }
  }
}
