import 'package:flutter_test/flutter_test.dart';
import 'package:listly/features/shopping_list/data/repositories/local_shopping_list_repository.dart';
import 'package:listly/shared/models/shopping_list.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mock_helpers.mocks.dart';
import '../../../../helpers/test_data.dart';

void main() {
  group('LocalShoppingListRepository', () {
    late MockSembastService mockSembastService;
    late LocalShoppingListRepository repository;

    setUp(() {
      mockSembastService = MockSembastService();
      repository = LocalShoppingListRepository(
        sembastService: mockSembastService,
      );
    });

    group('getById', () {
      test('returns shopping list when found', () async {
        final testList = TestData.sampleShoppingList;
        final testJson = testList.toJson();

        when(
          mockSembastService.read('lists', testList.id),
        ).thenAnswer((_) async => testJson);

        final result = await repository.getById(testList.id);

        expect(result, isNotNull);
        expect(result!.id, equals(testList.id));
        expect(result.name, equals(testList.name));
        verify(mockSembastService.read('lists', testList.id)).called(1);
      });

      test('returns null when not found', () async {
        const testId = 'non_existent_id';

        when(
          mockSembastService.read('lists', testId),
        ).thenAnswer((_) async => null);

        final result = await repository.getById(testId);

        expect(result, isNull);
        verify(mockSembastService.read('lists', testId)).called(1);
      });

      test('throws exception when service fails', () {
        const testId = 'test_id';

        when(
          mockSembastService.read('lists', testId),
        ).thenThrow(Exception('Database error'));

        expect(() => repository.getById(testId), throwsA(isA<Exception>()));
      });
    });

    group('getAll', () {
      test('returns all shopping lists', () async {
        final testLists = TestData.sampleShoppingLists;
        final testJsonList = testLists.map((list) => list.toJson()).toList();

        when(
          mockSembastService.readAll('lists'),
        ).thenAnswer((_) async => testJsonList);

        final result = await repository.getAll();

        expect(result.length, equals(testLists.length));
        expect(
          result.map((l) => l.id),
          containsAll(testLists.map((l) => l.id)),
        );
        verify(mockSembastService.readAll('lists')).called(1);
      });

      test('returns empty list when no lists exist', () async {
        when(mockSembastService.readAll('lists')).thenAnswer((_) async => []);

        final result = await repository.getAll();

        expect(result, isEmpty);
        verify(mockSembastService.readAll('lists')).called(1);
      });

      test('throws exception when service fails', () {
        when(
          mockSembastService.readAll('lists'),
        ).thenThrow(Exception('Database error'));

        expect(() => repository.getAll(), throwsA(isA<Exception>()));
      });
    });

    group('create', () {
      test('successfully creates shopping list', () async {
        final testList = TestData.sampleShoppingList;

        when(
          mockSembastService.create('lists', testList.id, any),
        ).thenAnswer((_) async {});

        await repository.create(testList);

        verify(
          mockSembastService.create('lists', testList.id, testList.toJson()),
        ).called(1);
      });

      test('throws exception when service fails', () {
        final testList = TestData.sampleShoppingList;

        when(
          mockSembastService.create('lists', testList.id, any),
        ).thenThrow(Exception('Database error'));

        expect(() => repository.create(testList), throwsA(isA<Exception>()));
      });
    });

    group('update', () {
      test('successfully updates shopping list with new timestamp', () async {
        final testList = TestData.sampleShoppingList;

        when(
          mockSembastService.update('lists', testList.id, any),
        ).thenAnswer((_) async {});

        await repository.update(testList);

        final capturedCall =
            verify(
                  mockSembastService.update('lists', testList.id, captureAny),
                ).captured.first
                as Map<String, dynamic>;

        expect(capturedCall['id'], equals(testList.id));
        expect(capturedCall['name'], equals(testList.name));
        // Updated timestamp should be newer than original
        final updatedAtString = capturedCall['updated_at'] as String;
        final updatedAt = DateTime.parse(updatedAtString);
        expect(updatedAt.isAfter(testList.updatedAt), isTrue);
      });

      test('throws exception when service fails', () {
        final testList = TestData.sampleShoppingList;

        when(
          mockSembastService.update('lists', testList.id, any),
        ).thenThrow(Exception('Database error'));

        expect(() => repository.update(testList), throwsA(isA<Exception>()));
      });
    });

    group('delete', () {
      test('successfully deletes shopping list', () async {
        const testId = 'test_id';

        when(
          mockSembastService.delete('lists', testId),
        ).thenAnswer((_) async {});

        await repository.delete(testId);

        verify(mockSembastService.delete('lists', testId)).called(1);
      });

      test('throws exception when service fails', () {
        const testId = 'test_id';

        when(
          mockSembastService.delete('lists', testId),
        ).thenThrow(Exception('Database error'));

        expect(() => repository.delete(testId), throwsA(isA<Exception>()));
      });
    });

    group('getUserLists', () {
      test('returns lists where user is creator', () async {
        final testLists = [TestData.sampleShoppingList];
        final testJsonList = testLists.map((list) => list.toJson()).toList();
        const userId = 'user_123';

        when(
          mockSembastService.query('lists', finder: anyNamed('finder')),
        ).thenAnswer((_) async => testJsonList);

        final result = await repository.getUserLists(userId);

        expect(result.length, equals(1));
        expect(result.first.creatorUserId, equals(userId));
        verify(
          mockSembastService.query('lists', finder: anyNamed('finder')),
        ).called(1);
      });

      test('returns empty list when user has no lists', () async {
        const userId = 'user_no_lists';

        when(
          mockSembastService.query('lists', finder: anyNamed('finder')),
        ).thenAnswer((_) async => []);

        final result = await repository.getUserLists(userId);

        expect(result, isEmpty);
      });

      test('throws exception when service fails', () {
        const userId = 'user_123';

        when(
          mockSembastService.query('lists', finder: anyNamed('finder')),
        ).thenThrow(Exception('Database error'));

        expect(
          () => repository.getUserLists(userId),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('addParticipant', () {
      test('successfully adds participant to list', () async {
        final testList = TestData.sampleShoppingList;
        const newUserId = 'new_user_456';

        when(
          mockSembastService.read('lists', testList.id),
        ).thenAnswer((_) async => testList.toJson());
        when(
          mockSembastService.update('lists', testList.id, any),
        ).thenAnswer((_) async {});

        await repository.addParticipant(testList.id, newUserId);

        final capturedCall =
            verify(
                  mockSembastService.update('lists', testList.id, captureAny),
                ).captured.first
                as Map<String, dynamic>;

        final participantIds = capturedCall['participant_ids'] as List;
        expect(participantIds, contains(newUserId));
        expect(
          participantIds.length,
          equals(testList.participantIds.length + 1),
        );
      });

      test('does not add duplicate participant', () async {
        final testList = TestData.sampleShoppingList;
        const existingUserId = 'user_456'; // Already in participantIds

        when(
          mockSembastService.read('lists', testList.id),
        ).thenAnswer((_) async => testList.toJson());

        await repository.addParticipant(testList.id, existingUserId);

        // Should not call update since user is already a participant
        verifyNever(mockSembastService.update('lists', testList.id, any));
      });

      test('throws exception when list not found', () {
        const testId = 'non_existent_list';
        const userId = 'user_123';

        when(
          mockSembastService.read('lists', testId),
        ).thenAnswer((_) async => null);

        expect(
          () => repository.addParticipant(testId, userId),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('removeParticipant', () {
      test('successfully removes participant from list', () async {
        final testList = TestData.sampleShoppingList;
        const userToRemove = 'user_456'; // Exists in participantIds

        when(
          mockSembastService.read('lists', testList.id),
        ).thenAnswer((_) async => testList.toJson());
        when(
          mockSembastService.update('lists', testList.id, any),
        ).thenAnswer((_) async {});

        await repository.removeParticipant(testList.id, userToRemove);

        final capturedCall =
            verify(
                  mockSembastService.update('lists', testList.id, captureAny),
                ).captured.first
                as Map<String, dynamic>;

        final participantIds = capturedCall['participant_ids'] as List;
        expect(participantIds, isNot(contains(userToRemove)));
        expect(
          participantIds.length,
          equals(testList.participantIds.length - 1),
        );
      });

      test('handles removing non-existent participant gracefully', () async {
        final testList = TestData.sampleShoppingList;
        const nonExistentUser = 'non_existent_user';

        when(
          mockSembastService.read('lists', testList.id),
        ).thenAnswer((_) async => testList.toJson());
        when(
          mockSembastService.update('lists', testList.id, any),
        ).thenAnswer((_) async {});

        await repository.removeParticipant(testList.id, nonExistentUser);

        // Should still call update, but list should remain unchanged
        verify(mockSembastService.update('lists', testList.id, any)).called(1);
      });

      test('throws exception when list not found', () {
        const testId = 'non_existent_list';
        const userId = 'user_123';

        when(
          mockSembastService.read('lists', testId),
        ).thenAnswer((_) async => null);

        expect(
          () => repository.removeParticipant(testId, userId),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('archiveList', () {
      test('successfully archives list', () async {
        final testList = TestData.sampleShoppingList;

        when(
          mockSembastService.read('lists', testList.id),
        ).thenAnswer((_) async => testList.toJson());
        when(
          mockSembastService.update('lists', testList.id, any),
        ).thenAnswer((_) async {});

        await repository.archiveList(testList.id);

        final capturedCall =
            verify(
                  mockSembastService.update('lists', testList.id, captureAny),
                ).captured.first
                as Map<String, dynamic>;

        expect(capturedCall['is_archived'], isTrue);
      });

      test('throws exception when list not found', () {
        const testId = 'non_existent_list';

        when(
          mockSembastService.read('lists', testId),
        ).thenAnswer((_) async => null);

        expect(() => repository.archiveList(testId), throwsA(isA<Exception>()));
      });
    });

    group('watch', () {
      test('returns stream of shopping lists', () async {
        final testLists = TestData.sampleShoppingLists;
        final testJsonList = testLists.map((list) => list.toJson()).toList();

        when(
          mockSembastService.watchQuery('lists', finder: anyNamed('finder')),
        ).thenAnswer((_) => Stream.value(testJsonList));

        final stream = repository.watch();

        await expectLater(stream.take(1), emits(hasLength(testLists.length)));

        verify(
          mockSembastService.watchQuery('lists', finder: anyNamed('finder')),
        ).called(1);
      });

      test('throws exception when service fails', () {
        when(
          mockSembastService.watchQuery('lists', finder: anyNamed('finder')),
        ).thenThrow(Exception('Database error'));

        expect(() => repository.watch(), throwsA(isA<Exception>()));
      });
    });

    group('watchById', () {
      test('returns stream of specific shopping list', () async {
        final testList = TestData.sampleShoppingList;
        final testJson = testList.toJson();

        when(
          mockSembastService.watchOne('lists', testList.id),
        ).thenAnswer((_) => Stream.value(testJson));

        final stream = repository.watchById(testList.id);

        await expectLater(stream.take(1), emits(isA<ShoppingList>()));

        verify(mockSembastService.watchOne('lists', testList.id)).called(1);
      });

      test('returns stream with null when list not found', () async {
        const testId = 'non_existent_id';

        when(
          mockSembastService.watchOne('lists', testId),
        ).thenAnswer((_) => Stream.value(null));

        final stream = repository.watchById(testId);

        await expectLater(stream.take(1), emits(isNull));
      });

      test('throws exception when service fails', () {
        const testId = 'test_id';

        when(
          mockSembastService.watchOne('lists', testId),
        ).thenThrow(Exception('Database error'));

        expect(() => repository.watchById(testId), throwsA(isA<Exception>()));
      });
    });

    group('watchUserLists', () {
      test('returns stream of user shopping lists', () async {
        final testLists = [TestData.sampleShoppingList];
        final testJsonList = testLists.map((list) => list.toJson()).toList();
        const userId = 'user_123';

        when(
          mockSembastService.watchQuery('lists', finder: anyNamed('finder')),
        ).thenAnswer((_) => Stream.value(testJsonList));

        final stream = repository.watchUserLists(userId);

        await expectLater(stream.take(1), emits(hasLength(1)));

        verify(
          mockSembastService.watchQuery('lists', finder: anyNamed('finder')),
        ).called(1);
      });

      test('throws exception when service fails', () {
        const userId = 'user_123';

        when(
          mockSembastService.watchQuery('lists', finder: anyNamed('finder')),
        ).thenThrow(Exception('Database error'));

        expect(
          () => repository.watchUserLists(userId),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('edge cases', () {
      test('handles concurrent operations correctly', () async {
        final testList = TestData.sampleShoppingList;

        when(
          mockSembastService.create('lists', any, any),
        ).thenAnswer((_) async {});

        // Simulate concurrent creates
        final futures = List.generate(
          10,
          (i) => repository.create(testList.copyWith(id: 'list_$i')),
        );

        await Future.wait(futures);

        verify(mockSembastService.create('lists', any, any)).called(10);
      });

      test('handles large participant lists', () async {
        final longParticipantList = List.generate(100, (i) => 'user_$i');
        final testList = TestData.createShoppingList(
          participantIds: longParticipantList,
        );

        when(
          mockSembastService.create('lists', testList.id, any),
        ).thenAnswer((_) async {});

        await repository.create(testList);

        final capturedCall =
            verify(
                  mockSembastService.create('lists', testList.id, captureAny),
                ).captured.first
                as Map<String, dynamic>;

        final participantIds = capturedCall['participant_ids'] as List;
        expect(participantIds.length, equals(100));
        expect(participantIds, containsAll(longParticipantList));
      });

      test('handles malformed JSON gracefully', () {
        const testId = 'test_id';
        const malformedJson = {'incomplete': 'data'};

        when(
          mockSembastService.read('lists', testId),
        ).thenAnswer((_) async => malformedJson);

        expect(() => repository.getById(testId), throwsA(isA<Exception>()));
      });
    });
  });
}
