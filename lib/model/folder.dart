import 'package:sample_todo_app/domain/repository/generic/repository.dart';

class Folder implements Entity<int> {
  final int? id;
  final String title;
  final String description;
  final int color;

  Folder({
    this.id,
    required this.title,
    required this.description,
    required this.color,
  });

  factory Folder.fromMap(Map<String, dynamic> map) {
    return Folder(
      id: map['id'].toInt(),
      title: map['title'],
      description: map['description'],
      color: map['color'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'color': color,
    };
  }
}
