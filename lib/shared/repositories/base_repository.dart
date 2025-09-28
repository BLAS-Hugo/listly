abstract class BaseRepository<T, ID> {
  Future<T?> getById(ID id);
  Future<List<T>> getAll();
  Future<void> create(T item);
  Future<void> update(T item);
  Future<void> delete(ID id);
  Stream<List<T>> watch();
  Stream<T?> watchById(ID id);
}
