import 'package:sample_todo_app/domain/repository/generic/repository.dart';

class Folder implements Entity<int> {
  final int? id;
  final String title;

  Folder({
    this.id,
    required this.title,
  });

  factory Folder.fromMap(Map<String, dynamic> map) {
    return Folder(
      id: map['id'].toInt(),
      title: map['title'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
    };
  }
}
