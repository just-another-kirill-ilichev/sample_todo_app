abstract class Entity<T> {
  T? get id;
}

abstract class IRepository<U extends Entity<V>, V> {
  Future<U?> fetchById(V id);
  Future<List<U>> fetchAll();

  Future<bool> existsById(V id);

  Future<void> save(U item);

  Future<void> removeById(V id);
  Future<void> removeAll();
}
