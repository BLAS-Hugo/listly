import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listly/shared/providers/database/database_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

final sembastServiceProvider = Provider(
  (ref) => SembastService(database: ref.watch(databaseProvider)),
);

class SembastService {
  final Database database;

  const SembastService({required this.database});

  Future<void> create(
    String storeName,
    String key,
    Map<String, dynamic> data,
  ) async {
    final store = stringMapStoreFactory.store(storeName);
    await store.record(key).put(database, data);
  }

  Future<Map<String, dynamic>?> read(String storeName, String key) async {
    final store = stringMapStoreFactory.store(storeName);
    return await store.record(key).get(database);
  }

  Future<List<Map<String, dynamic>>> readAll(String storeName) async {
    final store = stringMapStoreFactory.store(storeName);
    final records = await store.find(database);
    return records.map((record) => record.value).toList();
  }

  Future<void> update(
    String storeName,
    String key,
    Map<String, dynamic> data,
  ) async {
    final store = stringMapStoreFactory.store(storeName);
    await store.record(key).update(database, data);
  }

  Future<void> delete(String storeName, String key) async {
    final store = stringMapStoreFactory.store(storeName);
    await store.record(key).delete(database);
  }

  Future<List<Map<String, dynamic>>> query(
    String storeName, {
    Finder? finder,
  }) async {
    final store = stringMapStoreFactory.store(storeName);
    final records = await store.find(database, finder: finder);
    return records.map((record) => record.value).toList();
  }

  Stream<List<Map<String, dynamic>>> watchAll(String storeName) {
    final store = stringMapStoreFactory.store(storeName);
    final query = store.query();
    return query.onSnapshots(database).map((snapshots) {
      return snapshots.map((snapshot) => snapshot.value).toList();
    });
  }

  Stream<List<Map<String, dynamic>>> watchQuery(
    String storeName, {
    Finder? finder,
  }) {
    final store = stringMapStoreFactory.store(storeName);
    final query = store.query(finder: finder);
    return query.onSnapshots(database).map((snapshots) {
      return snapshots.map((snapshot) => snapshot.value).toList();
    });
  }

  Stream<Map<String, dynamic>?> watchOne(String storeName, String key) {
    final store = stringMapStoreFactory.store(storeName);
    final record = store.record(key);
    return record.onSnapshot(database).map((snapshot) {
      return snapshot?.value;
    });
  }
}
