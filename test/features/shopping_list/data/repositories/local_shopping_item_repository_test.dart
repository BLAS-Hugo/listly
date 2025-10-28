import 'package:flutter_test/flutter_test.dart';
import 'package:listly/features/shopping_list/data/repositories/local_shopping_item_repository.dart';
import 'package:listly/shared/models/shopping_item.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mock_helpers.mocks.dart';
import '../../../../helpers/test_data.dart';

void main() {
  group('LocalShoppingItemRepository', () {
    late MockSembastService mockSembastService;
    late LocalShoppingItemRepository repository;

    setUp(() {
      mockSembastService = MockSembastService();
      repository = LocalShoppingItemRepository(
        sembastService: mockSembastService,
      );
    });

    group('getById', () {
      test('returns shopping item when found', () async {
        final testItem = TestData.sampleShoppingItem;
        final testJson = testItem.toJson();

        when(
          mockSembastService.read('shopping_items', testItem.id),
        ).thenAnswer((_) async => testJson);

        final result = await repository.getById(testItem.id);

        expect(result, isNotNull);
        expect(result!.id, equals(testItem.id));
        expect(result.name, equals(testItem.name));
        expect(result.listId, equals(testItem.listId));
        verify(mockSembastService.read('shopping_items', testItem.id)).called(1);
      });

      test('returns null when not found', () async {
        const testId = 'non_existent_id';

        when(
          mockSembastService.read('shopping_items', testId),
        ).thenAnswer((_) async => null);

        final result = await repository.getById(testId);

        expect(result, isNull);
        verify(mockSembastService.read('shopping_items', testId)).called(1);
      });

      test('throws exception when service fails', () {
        const testId = 'test_id';

        when(
          mockSembastService.read('shopping_items', testId),
        ).thenThrow(Exception('Database error'));

        expect(() => repository.getById(testId), throwsA(isA<Exception>()));
      });
    });

    group('getAll', () {
      test('returns all shopping items', () async {
        final testItems = TestData.sampleShoppingItems;
        final testJsonList = testItems.map((item) => item.toJson()).toList();

        when(
          mockSembastService.readAll('shopping_items'),
        ).thenAnswer((_) async => testJsonList);

        final result = await repository.getAll();

        expect(result.length, equals(testItems.length));
        expect(
          result.map((i) => i.id),
          containsAll(testItems.map((i) => i.id)),
        );
        verify(mockSembastService.readAll('shopping_items')).called(1);
      });

      test('returns empty list when no items exist', () async {
        when(mockSembastService.readAll('shopping_items')).thenAnswer((_) async => []);

        final result = await repository.getAll();

        expect(result, isEmpty);
        verify(mockSembastService.readAll('shopping_items')).called(1);
      });

      test('throws exception when service fails', () {
        when(
          mockSembastService.readAll('shopping_items'),
        ).thenThrow(Exception('Database error'));

        expect(() => repository.getAll(), throwsA(isA<Exception>()));
      });
    });

    group('getItemsByListId', () {
      test('returns items for specific list sorted by sortOrder', () async {
        final testItems = TestData.sampleShoppingItems;
        final testJsonList = testItems.map((item) => item.toJson()).toList();
        const listId = 'list_123';

        when(
          mockSembastService.query('shopping_items', finder: anyNamed('finder')),
        ).thenAnswer((_) async => testJsonList);

        final result = await repository.getItemsByListId(listId);

        expect(result.length, equals(testItems.length));
        expect(result.first.listId, equals(listId));
        verify(
          mockSembastService.query('shopping_items', finder: anyNamed('finder')),
        ).called(1);
      });

      test('returns empty list when list has no items', () async {
        const listId = 'empty_list';

        when(
          mockSembastService.query('shopping_items', finder: anyNamed('finder')),
        ).thenAnswer((_) async => []);

        final result = await repository.getItemsByListId(listId);

        expect(result, isEmpty);
      });

      test('throws exception when service fails', () {
        const listId = 'list_123';

        when(
          mockSembastService.query('shopping_items', finder: anyNamed('finder')),
        ).thenThrow(Exception('Database error'));

        expect(
          () => repository.getItemsByListId(listId),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('create', () {
      test('successfully creates shopping item', () async {
        final testItem = TestData.sampleShoppingItem;

        when(
          mockSembastService.create('shopping_items', testItem.id, any),
        ).thenAnswer((_) async {});

        await repository.create(testItem);

        verify(
          mockSembastService.create('shopping_items', testItem.id, testItem.toJson()),
        ).called(1);
      });

      test('throws exception when service fails', () {
        final testItem = TestData.sampleShoppingItem;

        when(
          mockSembastService.create('shopping_items', testItem.id, any),
        ).thenThrow(Exception('Database error'));

        expect(() => repository.create(testItem), throwsA(isA<Exception>()));
      });
    });

    group('update', () {
      test('successfully updates shopping item with new timestamp', () async {
        final testItem = TestData.sampleShoppingItem;

        when(
          mockSembastService.update('shopping_items', testItem.id, any),
        ).thenAnswer((_) async {});

        await repository.update(testItem);

        final capturedCall =
            verify(
                  mockSembastService.update('shopping_items', testItem.id, captureAny),
                ).captured.first
                as Map<String, dynamic>;

        expect(capturedCall['id'], equals(testItem.id));
        expect(capturedCall['name'], equals(testItem.name));
        // Updated timestamp should be newer than original
        final updatedAtString = capturedCall['updated_at'] as String;
        final updatedAt = DateTime.parse(updatedAtString);
        expect(updatedAt.isAfter(testItem.updatedAt), isTrue);
      });

      test('throws exception when service fails', () {
        final testItem = TestData.sampleShoppingItem;

        when(
          mockSembastService.update('shopping_items', testItem.id, any),
        ).thenThrow(Exception('Database error'));

        expect(() => repository.update(testItem), throwsA(isA<Exception>()));
      });
    });

    group('delete', () {
      test('successfully deletes shopping item', () async {
        const testId = 'test_id';

        when(
          mockSembastService.delete('shopping_items', testId),
        ).thenAnswer((_) async {});

        await repository.delete(testId);

        verify(mockSembastService.delete('shopping_items', testId)).called(1);
      });

      test('throws exception when service fails', () {
        const testId = 'test_id';

        when(
          mockSembastService.delete('shopping_items', testId),
        ).thenThrow(Exception('Database error'));

        expect(() => repository.delete(testId), throwsA(isA<Exception>()));
      });
    });

    group('toggleCompleted', () {
      test('successfully marks uncompleted item as completed', () async {
        final testItem = TestData.sampleShoppingItem;
        final testJson = testItem.toJson();

        when(
          mockSembastService.read('shopping_items', testItem.id),
        ).thenAnswer((_) async => testJson);
        when(
          mockSembastService.update('shopping_items', testItem.id, any),
        ).thenAnswer((_) async {});

        await repository.toggleCompleted(testItem.id);

        final capturedCall =
            verify(
                  mockSembastService.update('shopping_items', testItem.id, captureAny),
                ).captured.first
                as Map<String, dynamic>;

        expect(capturedCall['is_completed'], isTrue);
        expect(capturedCall['completed_at'], isNotNull);
      });

      test('successfully marks completed item as uncompleted', () async {
        final testItem = TestData.completedShoppingItem;
        final testJson = testItem.toJson();

        when(
          mockSembastService.read('shopping_items', testItem.id),
        ).thenAnswer((_) async => testJson);
        when(
          mockSembastService.update('shopping_items', testItem.id, any),
        ).thenAnswer((_) async {});

        await repository.toggleCompleted(testItem.id);

        final capturedCall =
            verify(
                  mockSembastService.update('shopping_items', testItem.id, captureAny),
                ).captured.first
                as Map<String, dynamic>;

        expect(capturedCall['is_completed'], isFalse);
        expect(capturedCall['completed_at'], isNull);
      });

      test('throws exception when item not found', () {
        const testId = 'non_existent_item';

        when(
          mockSembastService.read('shopping_items', testId),
        ).thenAnswer((_) async => null);

        expect(
          () => repository.toggleCompleted(testId),
          throwsA(isA<Exception>()),
        );
      });

      test('throws exception when service fails', () {
        const testId = 'test_id';

        when(
          mockSembastService.read('shopping_items', testId),
        ).thenThrow(Exception('Database error'));

        expect(
          () => repository.toggleCompleted(testId),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('watch', () {
      test('returns stream of shopping items sorted by sortOrder', () async {
        final testItems = TestData.sampleShoppingItems;
        final testJsonList = testItems.map((item) => item.toJson()).toList();

        when(
          mockSembastService.watchQuery('shopping_items', finder: anyNamed('finder')),
        ).thenAnswer((_) => Stream.value(testJsonList));

        final stream = repository.watch();

        await expectLater(stream.take(1), emits(hasLength(testItems.length)));

        verify(
          mockSembastService.watchQuery('shopping_items', finder: anyNamed('finder')),
        ).called(1);
      });

      test('throws exception when service fails', () {
        when(
          mockSembastService.watchQuery('shopping_items', finder: anyNamed('finder')),
        ).thenThrow(Exception('Database error'));

        expect(() => repository.watch(), throwsA(isA<Exception>()));
      });
    });

    group('watchById', () {
      test('returns stream of specific shopping item', () async {
        final testItem = TestData.sampleShoppingItem;
        final testJson = testItem.toJson();

        when(
          mockSembastService.watchOne('shopping_items', testItem.id),
        ).thenAnswer((_) => Stream.value(testJson));

        final stream = repository.watchById(testItem.id);

        await expectLater(stream.take(1), emits(isA<ShoppingItem>()));

        verify(mockSembastService.watchOne('shopping_items', testItem.id)).called(1);
      });

      test('returns stream with null when item not found', () async {
        const testId = 'non_existent_id';

        when(
          mockSembastService.watchOne('shopping_items', testId),
        ).thenAnswer((_) => Stream.value(null));

        final stream = repository.watchById(testId);

        await expectLater(stream.take(1), emits(isNull));
      });

      test('throws exception when service fails', () {
        const testId = 'test_id';

        when(
          mockSembastService.watchOne('shopping_items', testId),
        ).thenThrow(Exception('Database error'));

        expect(() => repository.watchById(testId), throwsA(isA<Exception>()));
      });
    });

    group('watchItemsByListId', () {
      test('returns stream of items for specific list', () async {
        final testItems = TestData.sampleShoppingItems;
        final testJsonList = testItems.map((item) => item.toJson()).toList();
        const listId = 'list_123';

        when(
          mockSembastService.watchQuery('shopping_items', finder: anyNamed('finder')),
        ).thenAnswer((_) => Stream.value(testJsonList));

        final stream = repository.watchItemsByListId(listId);

        await expectLater(stream.take(1), emits(hasLength(testItems.length)));

        verify(
          mockSembastService.watchQuery('shopping_items', finder: anyNamed('finder')),
        ).called(1);
      });

      test('returns empty stream when list has no items', () async {
        const listId = 'empty_list';

        when(
          mockSembastService.watchQuery('shopping_items', finder: anyNamed('finder')),
        ).thenAnswer((_) => Stream.value([]));

        final stream = repository.watchItemsByListId(listId);

        await expectLater(stream.take(1), emits(isEmpty));
      });

      test('throws exception when service fails', () {
        const listId = 'list_123';

        when(
          mockSembastService.watchQuery('shopping_items', finder: anyNamed('finder')),
        ).thenThrow(Exception('Database error'));

        expect(
          () => repository.watchItemsByListId(listId),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('edge cases', () {
      test('handles concurrent operations correctly', () async {
        final testItem = TestData.sampleShoppingItem;

        when(
          mockSembastService.create('shopping_items', any, any),
        ).thenAnswer((_) async {});

        // Simulate concurrent creates
        final futures = List.generate(
          10,
          (i) => repository.create(testItem.copyWith(id: 'item_$i')),
        );

        await Future.wait(futures);

        verify(mockSembastService.create('shopping_items', any, any)).called(10);
      });

      test('handles items with minimal fields', () async {
        final minimalItem = TestData.minimalShoppingItem;

        when(
          mockSembastService.create('shopping_items', minimalItem.id, any),
        ).thenAnswer((_) async {});

        await repository.create(minimalItem);

        final capturedCall =
            verify(
                  mockSembastService.create('shopping_items', minimalItem.id, captureAny),
                ).captured.first
                as Map<String, dynamic>;

        expect(capturedCall['id'], equals(minimalItem.id));
        expect(capturedCall['name'], equals(minimalItem.name));
        expect(capturedCall['description'], isNull);
        // Quantity has a default value of 1 in the ShoppingItem model
        expect(capturedCall['quantity'], equals(1));
      });

      test('handles large quantity values', () async {
        final testItem = TestData.createShoppingItem(quantity: 99999);

        when(
          mockSembastService.create('shopping_items', testItem.id, any),
        ).thenAnswer((_) async {});

        await repository.create(testItem);

        final capturedCall =
            verify(
                  mockSembastService.create('shopping_items', testItem.id, captureAny),
                ).captured.first
                as Map<String, dynamic>;

        expect(capturedCall['quantity'], equals(99999));
      });

      test('handles malformed JSON gracefully', () {
        const testId = 'test_id';
        const malformedJson = {'incomplete': 'data'};

        when(
          mockSembastService.read('shopping_items', testId),
        ).thenAnswer((_) async => malformedJson);

        expect(() => repository.getById(testId), throwsA(isA<Exception>()));
      });

      test('handles rapid toggle operations', () async {
        final testItem = TestData.sampleShoppingItem;
        final testJson = testItem.toJson();

        when(
          mockSembastService.read('shopping_items', testItem.id),
        ).thenAnswer((_) async => testJson);
        when(
          mockSembastService.update('shopping_items', testItem.id, any),
        ).thenAnswer((_) async {});

        // Simulate rapid toggles
        final futures = List.generate(
          5,
          (_) => repository.toggleCompleted(testItem.id),
        );

        await Future.wait(futures);

        verify(
          mockSembastService.update('shopping_items', testItem.id, any),
        ).called(5);
      });

      test('handles items with special characters in name', () async {
        final specialItem = TestData.createShoppingItem(
          name: 'Crème Brûlée & "Special" Items (10%)',
        );

        when(
          mockSembastService.create('shopping_items', specialItem.id, any),
        ).thenAnswer((_) async {});

        await repository.create(specialItem);

        final capturedCall =
            verify(
                  mockSembastService.create('shopping_items', specialItem.id, captureAny),
                ).captured.first
                as Map<String, dynamic>;

        expect(capturedCall['name'], equals('Crème Brûlée & "Special" Items (10%)'));
      });
    });
  });
}

