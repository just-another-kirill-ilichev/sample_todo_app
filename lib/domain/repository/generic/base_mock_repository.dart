import 'package:sample_todo_app/domain/repository/generic/repository.dart';

class BaseMockRepository<T extends Entity<int>> implements IRepository<T, int> {
  final Map<int, T> _data = {};
  int _increment = 0;

  BaseMockRepository();

  @override
  Future<bool> existsById(int id) async => _data.containsKey(id);

  @override
  Future<List<T>> fetchAll() async => _data.values.toList();

  @override
  Future<T?> fetchById(int id) async => _data[id];

  @override
  Future<void> removeAll() async => _data.clear();

  @override
  Future<void> removeById(int id) async => _data.remove(id);

  @override
  Future<void> save(T item) async {
    if (item.id != null && await existsById(item.id!)) {
      _data[item.id!] = item;
    } else {
      // TODO set id
      _data[_increment++] = item;
    }
  }
}
