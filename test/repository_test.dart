import 'package:flutter_test/flutter_test.dart';
import 'package:sample_todo_app/domain/repository/generic/base_mock_repository.dart';
import 'package:sample_todo_app/model/todo.dart';

void main() {
  group('Repository test', () {
    test('add one', () async {
      var repository = BaseMockRepository<Todo>();
      repository.save(Todo(
        creationDate: DateTime.now(),
        notificationDateTime: DateTime.now(),
        title: '',
        description: '',
        finished: false,
      ));
      expect((await repository.fetchAll()).length, 1);
    });
  });
}
