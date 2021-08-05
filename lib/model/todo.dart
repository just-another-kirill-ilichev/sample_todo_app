class Todo {
  final int? id;
  final DateTime creationDate;
  final DateTime notificationDateTime;
  final String title;
  final String description;
  final bool finished;

  Todo({
    this.id,
    required this.creationDate,
    required this.notificationDateTime,
    required this.title,
    required this.description,
    required this.finished,
  });

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'].toInt(),
      creationDate: DateTime.parse(map['creationDate']),
      notificationDateTime: DateTime.parse(map['notificationDateTime']),
      title: map['title'],
      description: map['description'],
      finished: map['finished'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'creationDate': creationDate.toIso8601String(),
      'notificationDateTime': notificationDateTime.toIso8601String(),
      'title': title,
      'description': description,
      'finished': finished ? 1 : 0,
    };
  }

  Todo copyWith({
    int? id,
    DateTime? creationDate,
    DateTime? notificationDateTime,
    String? title,
    String? description,
    bool? finished,
  }) {
    return Todo(
      id: id ?? this.id,
      creationDate: creationDate ?? this.creationDate,
      notificationDateTime: notificationDateTime ?? this.notificationDateTime,
      title: title ?? this.title,
      description: description ?? this.description,
      finished: finished ?? this.finished,
    );
  }
}