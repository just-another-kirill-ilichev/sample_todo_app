class Todo {
  final DateTime creationDate;
  final DateTime notificationDateTime;
  final String title;
  final String description;
  final bool finished;

  Todo(this.creationDate, this.notificationDateTime, this.title,
      this.description, this.finished);

  factory Todo.create(
      DateTime notificationDateTime, String title, String description) {
    return Todo(
      DateTime.now(),
      notificationDateTime,
      title,
      description,
      false,
    );
  }
}
