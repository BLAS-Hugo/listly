import 'package:flutter_test/flutter_test.dart' hide Finder;
import 'package:listly/core/database/sembast/sembast_service.dart';
import 'package:sembast/sembast_memory.dart';

void main() {
  group('SembastService', () {
    late Database database;
    late SembastService sembastService;
    const String testStoreName = 'test_store';
    const String testKey = 'test_key';
    final testData = {'name': 'Test Item', 'value': 42, 'active': true};

    setUp(() async {
      // Use in-memory database for testing
      database = await databaseFactoryMemory.openDatabase('test.db');
      sembastService = SembastService(database: database);
    });

    tearDown(() async {
      await database.close();
    });

    group('create', () {
      test('successfully creates a record', () async {
        await sembastService.create(testStoreName, testKey, testData);

        final store = stringMapStoreFactory.store(testStoreName);
        final result = await store.record(testKey).get(database);

        expect(result, equals(testData));
      });

      test('overwrites existing record with same key', () async {
        const initialData = {'name': 'Initial', 'value': 1};
        const updatedData = {'name': 'Updated', 'value': 2};

        await sembastService.create(testStoreName, testKey, initialData);
        await sembastService.create(testStoreName, testKey, updatedData);

        final store = stringMapStoreFactory.store(testStoreName);
        final result = await store.record(testKey).get(database);

        expect(result, equals(updatedData));
      });

      test('creates records in different stores independently', () async {
        const store1Data = {'store': 'store1'};
        const store2Data = {'store': 'store2'};

        await sembastService.create('store1', testKey, store1Data);
        await sembastService.create('store2', testKey, store2Data);

        final result1 = await sembastService.read('store1', testKey);
        final result2 = await sembastService.read('store2', testKey);

        expect(result1, equals(store1Data));
        expect(result2, equals(store2Data));
      });
    });

    group('read', () {
      test('successfully reads existing record', () async {
        await sembastService.create(testStoreName, testKey, testData);

        final result = await sembastService.read(testStoreName, testKey);

        expect(result, equals(testData));
      });

      test('returns null for non-existent record', () async {
        final result = await sembastService.read(
          testStoreName,
          'non_existent_key',
        );

        expect(result, isNull);
      });

      test('returns null for non-existent store', () async {
        final result = await sembastService.read('non_existent_store', testKey);

        expect(result, isNull);
      });
    });

    group('update', () {
      test('successfully updates existing record', () async {
        const initialData = {'name': 'Initial', 'value': 1};
        const updateData = {'name': 'Updated', 'value': 2};

        await sembastService.create(testStoreName, testKey, initialData);
        await sembastService.update(testStoreName, testKey, updateData);

        final result = await sembastService.read(testStoreName, testKey);

        expect(result, equals(updateData));
      });

      test('merges data when updating', () async {
        const initialData = {'name': 'Initial', 'value': 1, 'existing': true};
        const updateData = {'name': 'Updated', 'newField': 'new'};

        await sembastService.create(testStoreName, testKey, initialData);
        await sembastService.update(testStoreName, testKey, updateData);

        final result = await sembastService.read(testStoreName, testKey);

        expect(result?['name'], equals('Updated'));
        expect(result?['newField'], equals('new'));
        expect(result?['existing'], isTrue);
        expect(result?['value'], equals(1));
      });

      test('update on non-existent record completes without error', () async {
        // Sembast allows updates on non-existent records (they just don't do anything)
        await sembastService.update(testStoreName, 'non_existent', testData);

        // Verify the record was not created
        final result = await sembastService.read(testStoreName, 'non_existent');
        expect(result, isNull);
      });
    });

    group('delete', () {
      test('successfully deletes existing record', () async {
        await sembastService.create(testStoreName, testKey, testData);

        await sembastService.delete(testStoreName, testKey);

        final result = await sembastService.read(testStoreName, testKey);
        expect(result, isNull);
      });

      test('does not throw when deleting non-existent record', () {
        expect(
          () => sembastService.delete(testStoreName, 'non_existent'),
          returnsNormally,
        );
      });

      test('only deletes specified record', () async {
        const data1 = {'id': '1', 'name': 'Item 1'};
        const data2 = {'id': '2', 'name': 'Item 2'};

        await sembastService.create(testStoreName, 'key1', data1);
        await sembastService.create(testStoreName, 'key2', data2);

        await sembastService.delete(testStoreName, 'key1');

        final result1 = await sembastService.read(testStoreName, 'key1');
        final result2 = await sembastService.read(testStoreName, 'key2');

        expect(result1, isNull);
        expect(result2, equals(data2));
      });
    });

    group('readAll', () {
      test('returns empty list for empty store', () async {
        // Clear any existing data first
        final store = stringMapStoreFactory.store(testStoreName);
        await store.delete(database);

        final result = await sembastService.readAll(testStoreName);

        expect(result, isEmpty);
      });

      test('returns all records from store', () async {
        const data1 = {'id': '1', 'name': 'Item 1'};
        const data2 = {'id': '2', 'name': 'Item 2'};
        const data3 = {'id': '3', 'name': 'Item 3'};

        await sembastService.create(testStoreName, 'key1', data1);
        await sembastService.create(testStoreName, 'key2', data2);
        await sembastService.create(testStoreName, 'key3', data3);

        final result = await sembastService.readAll(testStoreName);

        expect(result.length, equals(3));
        expect(result, containsAll([data1, data2, data3]));
      });

      test('does not return records from other stores', () async {
        const store1Data = {'store': 'store1'};
        const store2Data = {'store': 'store2'};

        await sembastService.create('store1', testKey, store1Data);
        await sembastService.create('store2', testKey, store2Data);

        final result = await sembastService.readAll('store1');

        expect(result.length, equals(1));
        expect(result.first, equals(store1Data));
      });
    });

    group('query', () {
      setUp(() async {
        // Clear any existing data first
        final store = stringMapStoreFactory.store(testStoreName);
        await store.delete(database);
        // Set up test data for querying
        await sembastService.create(testStoreName, 'user1', {
          'name': 'Alice',
          'age': 25,
          'active': true,
        });
        await sembastService.create(testStoreName, 'user2', {
          'name': 'Bob',
          'age': 30,
          'active': false,
        });
        await sembastService.create(testStoreName, 'user3', {
          'name': 'Charlie',
          'age': 35,
          'active': true,
        });
      });

      test('returns all records when no finder provided', () async {
        final result = await sembastService.query(testStoreName);

        expect(result.length, equals(3));
      });

      test('filters records using finder', () async {
        final finder = Finder(filter: Filter.equals('active', true));

        final result = await sembastService.query(
          testStoreName,
          finder: finder,
        );

        expect(result.length, equals(2));
        expect(result.every((record) => record['active'] == true), isTrue);
      });

      test('sorts records using finder', () async {
        final finder = Finder(sortOrders: [SortOrder('age')]);

        final result = await sembastService.query(
          testStoreName,
          finder: finder,
        );

        expect(result.length, equals(3));
        expect(result[0]['age'], equals(25));
        expect(result[1]['age'], equals(30));
        expect(result[2]['age'], equals(35));
      });

      test('combines filter and sort in finder', () async {
        final finder = Finder(
          filter: Filter.equals('active', true),
          sortOrders: [SortOrder('age', false)], // descending
        );

        final result = await sembastService.query(
          testStoreName,
          finder: finder,
        );

        expect(result.length, equals(2));
        expect(result[0]['age'], equals(35)); // Charlie first (older)
        expect(result[1]['age'], equals(25)); // Alice second (younger)
      });
    });

    group('watchAll', () {
      test('emits current data on subscription', () async {
        const data1 = {'id': '1', 'name': 'Item 1'};
        const data2 = {'id': '2', 'name': 'Item 2'};

        await sembastService.create(testStoreName, 'key1', data1);
        await sembastService.create(testStoreName, 'key2', data2);

        final stream = sembastService.watchAll(testStoreName);

        await expectLater(stream.take(1), emits(containsAll([data1, data2])));
      });

      test('emits updates when data changes', () async {
        const initialData = {'id': '1', 'name': 'Initial'};
        const updatedData = {'id': '1', 'name': 'Updated'};

        await sembastService.create(testStoreName, 'key1', initialData);

        final stream = sembastService.watchAll(testStoreName);
        final streamData = <List<Map<String, dynamic>>>[];

        final subscription = stream.listen(streamData.add);

        // Wait for initial data
        await Future.delayed(const Duration(milliseconds: 50));

        // Update the data
        await sembastService.update(testStoreName, 'key1', updatedData);

        // Wait for update
        await Future.delayed(const Duration(milliseconds: 50));

        await subscription.cancel();

        expect(streamData.length, greaterThanOrEqualTo(2));
        expect(streamData.first.first, equals(initialData));
        expect(streamData.last.first['name'], equals('Updated'));
      });
    });

    group('watchQuery', () {
      test('emits filtered data on subscription', () async {
        // Clear any existing data first
        final store = stringMapStoreFactory.store(testStoreName);
        await store.delete(database);

        await sembastService.create(testStoreName, 'user1', {
          'name': 'Alice',
          'active': true,
        });
        await sembastService.create(testStoreName, 'user2', {
          'name': 'Bob',
          'active': false,
        });

        final finder = Finder(filter: Filter.equals('active', true));
        final stream = sembastService.watchQuery(testStoreName, finder: finder);

        await expectLater(stream.take(1), emits(hasLength(1)));
      });

      test('emits updates when matching data changes', () async {
        // Clear any existing data first
        final store = stringMapStoreFactory.store(testStoreName);
        await store.delete(database);

        await sembastService.create(testStoreName, 'user1', {
          'name': 'Alice',
          'active': false,
        });

        final finder = Finder(filter: Filter.equals('active', true));
        final stream = sembastService.watchQuery(testStoreName, finder: finder);
        final streamData = <List<Map<String, dynamic>>>[];

        final subscription = stream.listen(streamData.add);

        // Wait for initial data (should be empty)
        await Future.delayed(const Duration(milliseconds: 50));

        // Update to match filter
        await sembastService.update(testStoreName, 'user1', {
          'name': 'Alice',
          'active': true,
        });

        // Wait for update
        await Future.delayed(const Duration(milliseconds: 50));

        await subscription.cancel();

        expect(streamData.length, greaterThanOrEqualTo(2));
        expect(streamData.first, isEmpty);
        expect(streamData.last, hasLength(1));
      });
    });

    group('watchOne', () {
      test('emits current record on subscription', () async {
        const testData = {'id': '1', 'name': 'Test Item'};
        await sembastService.create(testStoreName, testKey, testData);

        final stream = sembastService.watchOne(testStoreName, testKey);

        await expectLater(stream.take(1), emits(equals(testData)));
      });

      test('emits null for non-existent record', () async {
        final stream = sembastService.watchOne(testStoreName, 'non_existent');

        await expectLater(stream.take(1), emits(isNull));
      });

      test('emits updates when record changes', () async {
        const initialData = {'id': '1', 'name': 'Initial'};
        const updatedData = {'id': '1', 'name': 'Updated'};

        await sembastService.create(testStoreName, testKey, initialData);

        final stream = sembastService.watchOne(testStoreName, testKey);
        final streamData = <Map<String, dynamic>?>[];

        final subscription = stream.listen(streamData.add);

        // Wait for initial data
        await Future.delayed(const Duration(milliseconds: 50));

        // Update the record
        await sembastService.update(testStoreName, testKey, updatedData);

        // Wait for update
        await Future.delayed(const Duration(milliseconds: 50));

        await subscription.cancel();

        expect(streamData.length, greaterThanOrEqualTo(2));
        expect(streamData.first, equals(initialData));
        expect(streamData.last?['name'], equals('Updated'));
      });

      test('emits null when record is deleted', () async {
        const testData = {'id': '1', 'name': 'Test Item'};
        await sembastService.create(testStoreName, testKey, testData);

        final stream = sembastService.watchOne(testStoreName, testKey);
        final streamData = <Map<String, dynamic>?>[];

        final subscription = stream.listen(streamData.add);

        // Wait for initial data
        await Future.delayed(const Duration(milliseconds: 50));

        // Delete the record
        await sembastService.delete(testStoreName, testKey);

        // Wait for update
        await Future.delayed(const Duration(milliseconds: 50));

        await subscription.cancel();

        expect(streamData.length, greaterThanOrEqualTo(2));
        expect(streamData.first, equals(testData));
        expect(streamData.last, isNull);
      });
    });

    group('edge cases', () {
      test('handles empty string keys', () async {
        const emptyKey = '';
        await sembastService.create(testStoreName, emptyKey, testData);

        final result = await sembastService.read(testStoreName, emptyKey);
        expect(result, equals(testData));
      });

      test('handles special character keys', () async {
        const specialKey = 'key-with_special.chars@123';
        await sembastService.create(testStoreName, specialKey, testData);

        final result = await sembastService.read(testStoreName, specialKey);
        expect(result, equals(testData));
      });

      test('handles nested data structures', () async {
        const nestedData = {
          'user': {
            'profile': {
              'name': 'John',
              'settings': {'theme': 'dark', 'notifications': true},
            },
            'permissions': ['read', 'write'],
          },
        };

        await sembastService.create(testStoreName, testKey, nestedData);

        final result = await sembastService.read(testStoreName, testKey);
        expect(result, equals(nestedData));
      });

      test('handles large data objects', () async {
        final largeData = <String, dynamic>{};
        for (int i = 0; i < 1000; i++) {
          largeData['field_$i'] = 'value_$i';
        }

        await sembastService.create(testStoreName, testKey, largeData);

        final result = await sembastService.read(testStoreName, testKey);
        expect(result, equals(largeData));
      });
    });
  });
}
