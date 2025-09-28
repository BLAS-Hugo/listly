import 'package:deep_pick/deep_pick.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listly/shared/models/list_permissions.dart';
import 'package:listly/shared/models/shopping_list.dart';
import '../../helpers/test_data.dart';

void main() {
  group('ShoppingList', () {
    group('constructor', () {
      test('creates instance with required parameters', () {
        final list = TestData.sampleShoppingList;

        expect(list.id, equals('list_123'));
        expect(list.creatorUserId, equals('user_123'));
        expect(list.participantIds, equals(['user_456', 'user_789']));
        expect(list.name, equals('Weekly Groceries'));
        expect(list.description, equals('Weekly grocery shopping list'));
        expect(list.color, equals('#4CAF50'));
        expect(list.itemIds, equals(['item_1', 'item_2', 'item_3']));
        expect(list.isArchived, isFalse);
        expect(list.permissions, equals(TestData.defaultPermissions));
      });

      test('creates instance with minimal required parameters', () {
        final minimal = TestData.emptyShoppingList;

        expect(minimal.id, equals('list_empty'));
        expect(minimal.creatorUserId, equals('user_123'));
        expect(minimal.participantIds, isEmpty);
        expect(minimal.name, equals('Empty List'));
        expect(minimal.description, isNull);
        expect(minimal.color, isNull);
        expect(minimal.itemIds, isEmpty);
        expect(minimal.isArchived, isFalse);
      });
    });

    group('create factory', () {
      test('creates new shopping list with generated ID', () {
        final list = ShoppingList.create(
          creatorUserId: 'user_123',
          name: 'Test List',
          description: 'Test description',
          color: '#FF5722',
        );

        expect(list.id, isNotEmpty);
        expect(list.creatorUserId, equals('user_123'));
        expect(list.name, equals('Test List'));
        expect(list.description, equals('Test description'));
        expect(list.color, equals('#FF5722'));
        expect(list.participantIds, isEmpty);
        expect(list.itemIds, isEmpty);
        expect(list.isArchived, isFalse);
        expect(list.permissions, equals(TestData.defaultPermissions));
      });

      test(
        'creates new shopping list with default color when none provided',
        () {
          final list = ShoppingList.create(
            creatorUserId: 'user_123',
            name: 'Test List',
          );

          expect(list.color, equals('#2196F3'));
        },
      );

      test('creates new shopping list with minimal parameters', () {
        final list = ShoppingList.create(
          creatorUserId: 'user_123',
          name: 'Minimal List',
        );

        expect(list.id, isNotEmpty);
        expect(list.creatorUserId, equals('user_123'));
        expect(list.name, equals('Minimal List'));
        expect(list.description, isNull);
        expect(list.participantIds, isEmpty);
        expect(list.itemIds, isEmpty);
        expect(list.isArchived, isFalse);
      });

      test('sets timestamps correctly on creation', () {
        final before = DateTime.now();
        final list = ShoppingList.create(
          creatorUserId: 'user_123',
          name: 'Time Test',
        );
        final after = DateTime.now();

        expect(
          list.createdAt.isAfter(before.subtract(const Duration(seconds: 1))),
          isTrue,
        );
        expect(
          list.createdAt.isBefore(after.add(const Duration(seconds: 1))),
          isTrue,
        );
        expect(list.updatedAt, equals(list.createdAt));
        expect(list.lastActivityAt, equals(list.createdAt));
      });
    });

    group('JSON serialization', () {
      test('converts to JSON correctly', () {
        final list = TestData.sampleShoppingList;
        final json = list.toJson();

        expect(pick(json, 'id').asStringOrThrow(), equals('list_123'));
        expect(
          pick(json, 'creator_user_id').asStringOrThrow(),
          equals('user_123'),
        );
        expect(
          pick(
            json,
            'participant_ids',
          ).asListOrThrow((pick) => pick.asStringOrThrow()),
          equals(['user_456', 'user_789']),
        );
        expect(
          pick(json, 'name').asStringOrThrow(),
          equals('Weekly Groceries'),
        );
        expect(
          pick(json, 'description').asStringOrThrow(),
          equals('Weekly grocery shopping list'),
        );
        expect(pick(json, 'color').asStringOrThrow(), equals('#4CAF50'));
        expect(
          pick(
            json,
            'item_ids',
          ).asListOrThrow((pick) => pick.asStringOrThrow()),
          equals(['item_1', 'item_2', 'item_3']),
        );
        expect(pick(json, 'is_archived').asBoolOrFalse(), isFalse);
        expect(pick(json, 'permissions').asMapOrNull(), isNotNull);
        expect(
          pick(json, 'permissions', 'anyoneCanEdit').asBoolOrFalse(),
          isTrue,
        );
      });

      test('creates from JSON correctly', () {
        final json = TestData.sampleShoppingListJson;
        final list = ShoppingList.fromJson(json);

        expect(list.id, equals('list_123'));
        expect(list.creatorUserId, equals('user_123'));
        expect(list.participantIds, equals(['user_456', 'user_789']));
        expect(list.name, equals('Weekly Groceries'));
        expect(list.description, equals('Weekly grocery shopping list'));
        expect(list.color, equals('#4CAF50'));
        expect(list.isArchived, isFalse);
      });

      test('round trip JSON serialization', () {
        final original = TestData.sampleShoppingList;
        final json = original.toJson();
        final restored = ShoppingList.fromJson(json);

        expect(restored.id, equals(original.id));
        expect(restored.creatorUserId, equals(original.creatorUserId));
        expect(restored.participantIds, equals(original.participantIds));
        expect(restored.name, equals(original.name));
        expect(restored.description, equals(original.description));
        expect(restored.color, equals(original.color));
        expect(restored.itemIds, equals(original.itemIds));
        expect(restored.isArchived, equals(original.isArchived));
        expect(restored.permissions, equals(original.permissions));
      });

      test('handles null optional fields in JSON', () {
        final json = {
          'id': 'list_null_test',
          'creator_user_id': 'user_123',
          'participant_ids': <String>[],
          'name': 'Null Test List',
          'description': null,
          'color': null,
          'item_ids': <String>[],
          'created_at': '2024-01-01T00:00:00.000',
          'updated_at': '2024-01-01T00:00:00.000',
          'last_activity_at': '2024-01-01T00:00:00.000',
          'is_archived': false,
          'permissions': {
            'anyoneCanEdit': true,
            'anyoneCanInvite': false,
            'anyoneCanDelete': false,
          },
        };

        final list = ShoppingList.fromJson(json);

        expect(list.description, isNull);
        expect(list.color, isNull);
        expect(list.participantIds, isEmpty);
        expect(list.itemIds, isEmpty);
      });
    });

    group('copyWith', () {
      test('creates copy with updated name', () {
        final original = TestData.sampleShoppingList;
        final updated = original.copyWith(name: 'Updated Name');

        expect(updated.name, equals('Updated Name'));
        expect(updated.id, equals(original.id));
        expect(updated.creatorUserId, equals(original.creatorUserId));
      });

      test('creates copy with updated participants', () {
        final original = TestData.sampleShoppingList;
        final newParticipants = ['new_user_1', 'new_user_2'];
        final updated = original.copyWith(participantIds: newParticipants);

        expect(updated.participantIds, equals(newParticipants));
        expect(updated.name, equals(original.name));
      });

      test('creates copy with updated archived status', () {
        final original = TestData.sampleShoppingList;
        final updated = original.copyWith(isArchived: true);

        expect(updated.isArchived, isTrue);
        expect(original.isArchived, isFalse);
      });

      test('creates copy with updated permissions', () {
        final original = TestData.sampleShoppingList;
        const newPermissions = ListPermissions(
          anyoneCanEdit: false,
          anyoneCanInvite: true,
          anyoneCanDelete: true,
        );
        final updated = original.copyWith(permissions: newPermissions);

        expect(updated.permissions, equals(newPermissions));
        expect(updated.permissions, isNot(equals(original.permissions)));
      });

      test('creates copy with updated timestamps', () {
        final original = TestData.sampleShoppingList;
        final newUpdatedAt = DateTime.now();
        final updated = original.copyWith(updatedAt: newUpdatedAt);

        expect(updated.updatedAt, equals(newUpdatedAt));
        expect(updated.createdAt, equals(original.createdAt));
      });

      test('creates identical copy when no parameters provided', () {
        final original = TestData.sampleShoppingList;
        final updated = original.copyWith();

        expect(updated, equals(original));
      });
    });

    group('equality', () {
      test('equal when all properties match', () {
        final list1 = TestData.sampleShoppingList;
        final list2 = TestData.sampleShoppingList;

        expect(list1, equals(list2));
        expect(list1.hashCode, equals(list2.hashCode));
      });

      test('not equal when IDs differ', () {
        final list1 = TestData.sampleShoppingList;
        final list2 = list1.copyWith(id: 'different_id');

        expect(list1, isNot(equals(list2)));
      });

      test('not equal when names differ', () {
        final list1 = TestData.sampleShoppingList;
        final list2 = list1.copyWith(name: 'Different Name');

        expect(list1, isNot(equals(list2)));
      });
    });

    group('toString', () {
      test('returns string representation', () {
        final list = TestData.sampleShoppingList;
        final stringRepresentation = list.toString();

        expect(stringRepresentation, contains('ShoppingList'));
        expect(stringRepresentation, contains(list.id));
        expect(stringRepresentation, contains(list.name));
      });
    });

    group('edge cases', () {
      test('handles empty participant and item lists', () {
        final list = TestData.createShoppingList(
          participantIds: [],
          itemIds: [],
        );

        expect(list.participantIds, isEmpty);
        expect(list.itemIds, isEmpty);
      });

      test('handles very long lists', () {
        final longParticipantList = List.generate(100, (i) => 'user_$i');
        final longItemList = List.generate(1000, (i) => 'item_$i');

        final list = TestData.createShoppingList(
          participantIds: longParticipantList,
          itemIds: longItemList,
        );

        expect(list.participantIds.length, equals(100));
        expect(list.itemIds.length, equals(1000));
      });

      test('handles special characters in names and descriptions', () {
        final list = TestData.createShoppingList(
          name: 'List with émojis 🛒 and special chars åéîöü',
          description:
              'Description with "quotes" and \'apostrophes\' and newlines\n\r',
        );

        expect(list.name, contains('émojis'));
        expect(list.description, contains('quotes'));
      });
    });
  });
}
